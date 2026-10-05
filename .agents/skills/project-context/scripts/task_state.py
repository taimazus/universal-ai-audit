"""Project-local task state. Python standard library only; notes never grant authority."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import sqlite3
import sys
from datetime import datetime, timezone

VERSION = 1
ID = re.compile(r"^[a-z0-9][a-z0-9-]{0,79}$")
SENSITIVE_KEYS = {"password", "secret", "token", "api_key", "apikey", "credential", "private_key"}


class StateError(ValueError):
    pass


def fail(message):
    raise StateError(message)


def text(value, label, empty=False):
    if not isinstance(value, str) or (not empty and not value.strip()) or len(value) > 20000:
        fail("Invalid " + label)


def fields(value, required, optional=()):
    if not isinstance(value, dict) or not set(required) <= value.keys() or value.keys() - set(required) - set(optional):
        fail("Invalid record fields")


def safe_summary(value):
    if isinstance(value, dict):
        for key, item in value.items():
            if key.lower() in SENSITIVE_KEYS:
                fail("Sensitive field rejected; record presence/location only")
            safe_summary(item)
    elif isinstance(value, list):
        for item in value:
            safe_summary(item)
    elif isinstance(value, str):
        if re.search(r"-----BEGIN .*PRIVATE KEY-----|\b(?:sk-|ghp_)[A-Za-z0-9_-]{16,}|\bBearer\s+\S+", value):
            fail("Possible credential rejected; redact input")


def identifier(value):
    if not isinstance(value, str) or not ID.fullmatch(value):
        fail("Invalid record identifier")


def validate_task(data):
    fields(data, ["goal", "scope", "status", "acceptance", "decisions", "changed_paths", "checks", "blockers", "next_action"], ["findings", "mode"])
    if data.get("mode", "implementation") not in ["review", "design", "implementation"]:
        fail("Invalid task mode")
    for key in ["goal", "scope", "next_action"]:
        text(data[key], key, empty=key == "next_action")
    if data["status"] not in ["active", "blocked", "complete"]:
        fail("Invalid task status")
    for key in ["acceptance", "decisions", "changed_paths", "blockers"]:
        if not isinstance(data[key], list):
            fail("Invalid " + key)
        for item in data[key]:
            text(item, key)
    if not isinstance(data["checks"], list):
        fail("Invalid checks")
    for check in data["checks"]:
        fields(check, ["command", "status", "summary"], ["required"])
        if "required" in check and not isinstance(check["required"], bool):
            fail("Invalid required-check flag")
        text(check["command"], "check command")
        text(check["summary"], "check summary")
        if check["status"] not in ["passed", "failed", "blocked", "planned"]:
            fail("Invalid check status")
    if data["status"] == "complete" and (data["blockers"] or any(c.get("required", True) and c["status"] != "passed" for c in data["checks"])):
        fail("Incomplete checks/blockers cannot be marked complete")
    if "findings" in data:
        if not isinstance(data["findings"], list):
            fail("Invalid findings")
        for item in data["findings"]:
            fields(item, ["id", "status", "evidence"], ["severity", "evidence_class", "location", "trigger_impact", "verification"])
            text(item["id"], "finding id")
            text(item["evidence"], "finding evidence")
            if item["status"] not in ["open", "fixed", "disproven", "already-fixed", "unresolved"]:
                fail("Invalid finding status")
            if "severity" in item and item["severity"] not in ["CRITICAL", "HIGH", "MEDIUM", "LOW"]:
                fail("Invalid finding severity")
            if "evidence_class" in item and item["evidence_class"] not in ["proven-defect", "risk", "hypothesis"]:
                fail("Invalid evidence class")
            for key in ["location", "trigger_impact", "verification"]:
                if key in item:
                    text(item[key], key)
        if data["status"] == "complete" and data.get("mode", "implementation") == "implementation" and any(
            f["status"] in ["open", "unresolved"] and f.get("evidence_class", "proven-defect") == "proven-defect" for f in data["findings"]
        ):
            fail("Unresolved findings cannot be marked complete")
    safe_summary(data)


def validate_answer(data):
    fields(data, ["question", "answer", "status", "source", "conditions", "watch_paths"])
    for key in ["question", "answer", "source"]:
        text(data[key], key)
    if data["status"] not in ["confirmed", "assumed", "superseded"]:
        fail("Invalid answer status")
    if not isinstance(data["conditions"], dict):
        fail("Invalid conditions")
    for key, value in data["conditions"].items():
        text(key, "condition key")
        text(value, "condition value")
    if not isinstance(data["watch_paths"], list):
        fail("Invalid watch paths")
    for item in data["watch_paths"]:
        text(item, "watch path")
    safe_summary(data)


def timestamp():
    return datetime.now(timezone.utc).isoformat()


class Store:
    def __init__(self, root, create=False):
        self.root = Path(root).resolve(strict=True)
        if not self.root.is_dir():
            fail("Project root must be a directory")
        directory = self.root / ".ai-work"
        self._no_link(directory)
        if create:
            directory.mkdir(exist_ok=True)
        self.path = directory / "state.sqlite3"
        self._no_link(self.path)
        for suffix in ["-journal", "-wal", "-shm"]:
            self._no_link(Path(str(self.path) + suffix))
        if not create and not self.path.is_file():
            fail("State store missing; initialize explicitly")
        existing = self.path.exists()
        # URI mode prevents a read command from creating a missing database.
        self.db = sqlite3.connect(self.path.as_uri() + ("?mode=rwc" if create else "?mode=rw"), uri=True, timeout=1)
        try:
            self.db.execute("PRAGMA busy_timeout=1000")
            if create:
                self.db.execute("BEGIN IMMEDIATE")
                if existing:
                    try:
                        prior = dict(self.db.execute("SELECT key,value FROM metadata"))
                    except sqlite3.Error:
                        fail("Unrecognized existing state; preserve it and recover explicitly")
                    if prior.get("version") != str(VERSION) or prior.get("root") != str(self.root):
                        fail("Unsupported or foreign existing state; preserve it and migrate explicitly")
                self.db.execute("CREATE TABLE IF NOT EXISTS metadata (key TEXT PRIMARY KEY, value TEXT NOT NULL)")
                self.db.execute("CREATE TABLE IF NOT EXISTS records (kind TEXT, scope TEXT, id TEXT, revision INTEGER, payload TEXT NOT NULL, PRIMARY KEY(kind,scope,id))")
                self.db.execute("CREATE TABLE IF NOT EXISTS events (seq INTEGER PRIMARY KEY, at TEXT NOT NULL, kind TEXT NOT NULL, scope TEXT NOT NULL, id TEXT NOT NULL, revision INTEGER NOT NULL, payload TEXT NOT NULL)")
                self.db.execute("INSERT OR IGNORE INTO metadata VALUES ('version',?)", (str(VERSION),))
                self.db.execute("INSERT OR IGNORE INTO metadata VALUES ('root',?)", (str(self.root),))
            meta = dict(self.db.execute("SELECT key,value FROM metadata"))
            if meta.get("version") != str(VERSION):
                fail("Unsupported state version; preserve store and migrate explicitly")
            if meta.get("root") != str(self.root):
                fail("State belongs to a different project root")
            if create:
                self.db.commit()
        except Exception:
            self.db.rollback()
            self.db.close()
            raise

    @staticmethod
    def _no_link(path):
        if path.is_symlink() or (hasattr(path, "is_junction") and path.is_junction()):
            fail("Linked state paths are not supported")
        # Python <3.12 Windows junctions.
        if os.name == "nt" and path.exists():
            import stat
            if path.lstat().st_file_attributes & stat.FILE_ATTRIBUTE_REPARSE_POINT:
                fail("Reparse state paths are not supported")

    def close(self):
        self.db.close()

    def watch(self, relative):
        path = self.root / relative
        if Path(relative).is_absolute() or ".." in Path(relative).parts:
            fail("Watch path must stay within project")
        current = path
        while current != self.root:
            self._no_link(current)
            current = current.parent
        if not path.resolve().is_relative_to(self.root):
            fail("Watch path escapes project")
        return hashlib.sha256(path.read_bytes()).hexdigest() if path.is_file() else "missing"

    def get(self, kind, scope, record_id):
        row = self.db.execute("SELECT revision,payload FROM records WHERE kind=? AND scope=? AND id=?", (kind, scope, record_id)).fetchone()
        if row is None:
            return None
        data = json.loads(row[1])
        if kind == "task":
            validate_task(data)
        elif kind == "answer":
            if not isinstance(data, dict) or not isinstance(data.get("fingerprints"), dict):
                fail("Corrupt saved answer")
            original = {key: value for key, value in data.items() if key != "fingerprints"}
            validate_answer(original)
            if set(data["fingerprints"]) != set(data["watch_paths"]) or any(
                not isinstance(value, str) or (value != "missing" and not re.fullmatch(r"[a-f0-9]{64}", value))
                for value in data["fingerprints"].values()
            ):
                fail("Corrupt answer fingerprints")
        else:
            fail("Invalid record kind")
        if not isinstance(row[0], int) or row[0] < 1:
            fail("Corrupt record revision")
        return {"revision": row[0], "data": data}

    def put(self, kind, scope, record_id, data, expected):
        identifier(record_id)
        if scope != "project":
            identifier(scope)
        if not isinstance(expected, int) or isinstance(expected, bool) or expected < 0:
            fail("Expected revision must be nonnegative")
        if kind == "task":
            if scope != "project":
                fail("Task records require project scope")
            validate_task(data)
        elif kind == "answer":
            validate_answer(data)
            data = dict(data, fingerprints={p: self.watch(p) for p in data["watch_paths"]})
        else:
            fail("Invalid record kind")
        encoded = json.dumps(data, ensure_ascii=False, sort_keys=True)
        try:
            self.db.execute("BEGIN IMMEDIATE")
            current = self.get(kind, scope, record_id)
            revision = current["revision"] if current else 0
            if revision != expected:
                fail("Revision conflict; reread and reconcile before retrying")
            revision += 1
            self.db.execute("INSERT OR REPLACE INTO records VALUES (?,?,?,?,?)", (kind, scope, record_id, revision, encoded))
            self.db.execute("INSERT INTO events(at,kind,scope,id,revision,payload) VALUES (?,?,?,?,?,?)", (timestamp(), kind, scope, record_id, revision, encoded))
            self.db.commit()
            return revision
        except Exception:
            self.db.rollback()
            raise

    def lookup(self, scope, record_id, conditions):
        if not isinstance(conditions, dict) or any(not isinstance(v, str) for v in conditions.values()):
            fail("Invalid lookup conditions")
        safe_summary(conditions)
        record = self.get("answer", scope, record_id)
        if not record:
            return {"status": "missing"}
        answer = record["data"]
        if answer["status"] != "confirmed":
            return {"status": answer["status"], "revision": record["revision"]}
        if conditions != answer["conditions"] or any(self.watch(p) != h for p, h in answer["fingerprints"].items()):
            return {"status": "stale", "revision": record["revision"]}
        return {"status": "reusable", "revision": record["revision"], "answer": answer["answer"], "source": answer["source"]}

    def history(self, kind, scope, record_id):
        return [{"at": row[0], "revision": row[1], "data": json.loads(row[2])} for row in self.db.execute("SELECT at,revision,payload FROM events WHERE kind=? AND scope=? AND id=? ORDER BY seq", (kind, scope, record_id))]


def read_json(path):
    with open(path, encoding="utf-8-sig") as handle:
        return json.load(handle)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", required=True, help="Verified target project root, not installed skill directory")
    commands = parser.add_subparsers(dest="command", required=True)
    commands.add_parser("init")
    for command in ["show", "history", "checkpoint", "answer", "lookup"]:
        item = commands.add_parser(command)
        item.add_argument("--id", required=True)
        item.add_argument("--scope", default="project")
        if command in ["show", "history"]:
            item.add_argument("--kind", choices=["task", "answer"], default="task")
        if command in ["checkpoint", "answer"]:
            item.add_argument("--input", required=True, help="Redacted JSON record file")
            item.add_argument("--expect-revision", required=True, type=int)
        if command == "lookup":
            item.add_argument("--conditions", required=True, help="JSON file with current applicability conditions")
    args = parser.parse_args(argv)
    store = None
    try:
        if args.command != "init":
            identifier(args.id)
            if args.scope != "project":
                identifier(args.scope)
        store = Store(args.root, create=args.command == "init")
        if args.command == "init":
            result = {"version": VERSION, "path": str(store.path)}
        elif args.command in ["show", "history"]:
            result = getattr(store, "get" if args.command == "show" else "history")(args.kind, args.scope, args.id)
        elif args.command == "lookup":
            result = store.lookup(args.scope, args.id, read_json(args.conditions))
        else:
            kind = "task" if args.command == "checkpoint" else "answer"
            revision = store.put(kind, args.scope, args.id, read_json(args.input), args.expect_revision)
            result = {"revision": revision, "path": str(store.path)}
        # JSON escapes remain parseable even on Windows consoles using a legacy encoding.
        print(json.dumps(result, ensure_ascii=True))
        return 0
    except (StateError, OSError, sqlite3.Error, json.JSONDecodeError, UnicodeError) as exc:
        # Do not print input values or credential-bearing exception details.
        print(str(exc) if isinstance(exc, StateError) else "State operation failed; inspect permissions, input or store integrity", file=sys.stderr)
        return 2
    finally:
        if store:
            store.close()


if __name__ == "__main__":
    sys.exit(main())
