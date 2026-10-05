# Transactional state helper

Use `scripts/task_state.py` relative to this installed skill, with Python 3.10+ and an explicit verified target project root. No third-party packages, network or model APIs are required. Never execute it against a project whose writes the user forbids.

`init` creates `.ai-work/state.sqlite3`. Records and append-only revision events commit together through SQLite transactions. Updates require the revision returned by `show` (0 only for a missing record). A conflict requires rereading and reconciling; never blindly increment the expected revision. A busy database fails after about one second, preserving existing data. Interrupted transactions roll back. Unknown versions or a store copied from a different root are rejected; preserve it and prepare an explicit migration, never initialize over it to erase history.

```text
python <installed-skill>/scripts/task_state.py --root <verified-project-root> init
python <installed-skill>/scripts/task_state.py --root <verified-project-root> show --id <task-id>
python <installed-skill>/scripts/task_state.py --root <verified-project-root> checkpoint --id <task-id> --input <redacted-record.json> --expect-revision <revision>
python <installed-skill>/scripts/task_state.py --root <verified-project-root> answer --scope project --id <question-id> --input <answer.json> --expect-revision <revision>
python <installed-skill>/scripts/task_state.py --root <verified-project-root> lookup --scope project --id <question-id> --conditions <current-conditions.json>
python <installed-skill>/scripts/task_state.py --root <verified-project-root> history --kind answer --scope project --id <question-id>
```

Task JSON requires `goal`, `scope`, `status` (active/blocked/complete), arrays `acceptance`, `decisions`, `changed_paths`, `checks`, `blockers`, and string `next_action`. Checks have `command`, `status` (passed/failed/blocked/planned), `summary`, and optional boolean `required` (default true). Optional findings have `id`, `status` (open/fixed/disproven/already-fixed/unresolved), `evidence`, and optional `severity`, `evidence_class` (proven-defect/risk/hypothesis), `location`, `trigger_impact`, `verification`. Task `mode` is review/design/implementation (default implementation). Complete status is rejected with blockers or nonpassed required checks. Implementation completion also requires confirmed defects resolved; review/design may complete with open reported findings. Optional blocked checks remain honestly blocked, never relabeled passed. Empty checks mean no check was recorded, not verified success; the agent still must execute task-specific completion criteria.

Answer JSON requires `question`, `answer`, `status` (confirmed/assumed/superseded), `source`, object `conditions` of string values, and array `watch_paths` of project-relative files. Record real provenance in `source`; the tool cannot establish that a human actually confirmed a claim. Scope is `project` or a task ID. Fingerprints are calculated internally; lookup returns reusable only for confirmed answers with matching conditions and watched file contents. Recompute current conditions from evidence. A new task does not implicitly inherit another task's answers; project preferences do not grant new permissions. Desired behavior and current implementation may differ and need a user decision.

Schema: `task.schema.json`. The helper validates records directly using standard-library code; schema files are interchange documentation and must agree with validation.

SQLite records written by this helper are authoritative. STATE/JOURNAL/PROJECT-CONTEXT Markdown remain useful handoffs and are maintained explicitly; no automatic bidirectional merge or overwrite is performed. On resume read whichever stores the workflow actually used, reconcile differences and cite the source. Preserve the database with its task notes; no automatic pruning, staging or publication. Secret-key/common-token detection is defense in depth, not comprehensive DLP: sanitize inputs first and never save secret values. Do not pass raw logs or credentials in payloads or commands.

Return codes: 0 success; 2 invalid input, conflict, missing/unwritable/corrupt/foreign store. `show`, `lookup` and `history` do not initialize a missing store. Read-only means no record changes; SQLite may use internal locks. In a physically read-only filesystem use existing Markdown notes or a textual handoff and disclose the limitation.
