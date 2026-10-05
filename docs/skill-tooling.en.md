<div lang="en" dir="ltr" align="left">

# Skill tools, durable state and evaluation

[فارسی](skill-tooling.fa.md) · [Skills](skills.en.md) · [36 lifecycle scenarios](prompt-library.en.md)

The pack contains 21 skills: `enterprise-audit` plus 20 supplementary skills. New specialists are `skill-evaluation`, `bug-investigation`, `feature-delivery`, `test-engineering`, `performance-lab`, `migration-upgrade`, `ui-accessibility` and `operations-readiness`. Each has completion criteria, permission boundaries, state recovery and actual-result reporting. Select relevant stages rather than running every skill.

## Canonical sources and adapters

Specialist content lives in `.agents/skills/`, the shared contract in `core/skill-contract.md`, and profiles in `core/stack-profiles.md`. Generation embeds the contract and synchronizes `.antigravity/skills/`, the audit protocol, Cursor/Copilot audit adapters and `core/skills.json`. Installed skills remain self-contained. Unexpected adapter resources require review and are not deleted automatically.

<div dir="ltr" align="left">

```text
python tools/generate_adapters.py
python tools/generate_adapters.py --check
python tests/docs.py
```

</div>

Installers distribute `SKILL.md` and UTF-8 text resources under `scripts/`, `references/`, `assets/` and `agents/` to native and portable destinations. Binary resources are outside this contract. For existing installations, inspect dry-run and reinstall with Force as described in [installation](installation.md). Creating skills does not authorize modifying actual global installations.

## Recoverable memory

With Python 3.10+, run `project-context/scripts/task_state.py` relative to its installed location using the verified open project root. `init` creates `.ai-work/state.sqlite3`. Records and revision history commit in one transaction. Every update requires the previous revision; conflicts or active locks fail explicitly while preserving existing data. Interruption before commit is not success.

Answers carry provenance, scope, confirmed/assumed/superseded status, applicability conditions and fingerprints of relevant files. Only confirmed answers whose conditions/files still match are reusable. Task-specific answers do not transfer to another task. Notes do not grant new external permissions, and the tool cannot independently prove a claimed human confirmation.

<div dir="ltr" align="left">

```text
python <installed-project-context>/scripts/task_state.py --root <verified-project-root> init
python <installed-project-context>/scripts/task_state.py --root <verified-project-root> show --id <task-id>
python <installed-project-context>/scripts/task_state.py --root <verified-project-root> checkpoint --id <task-id> --input <redacted-task.json> --expect-revision <revision>
```

</div>

SQLite is authoritative for records written by the helper; existing Markdown notes are neither deleted nor automatically overwritten. The agent identifies which stores it used and reconciles conflicts against current evidence. Without Python, authorized writes or accessible files, keep Markdown/textual handoff and disclose limitations. Linked paths and stores from another root are rejected; unknown versions are not automatically replaced. The [tool contract](../.agents/skills/project-context/references/state-tool.md) defines CLI, schema and exit codes.

Inputs must already be redacted. Sensitive-key/common-token rejection is not comprehensive sensitive-data detection. Never automatically stage/publish/prune databases or task notes. Current database/schema version is 1; incompatible upgrades require explicit migration.

## Tool tests versus agent evaluations

Python standard-library tests exercise cross-process recovery, revision conflicts, competing writers, locks, process-interruption rollback, stale answers, scope isolation, corrupt records and false-completion rejection. Harness tests exercise runner failure, timeout, file preservation and an oracle outside the workspace. These are real executable tool tests; they do not prove LLM behavior.

<div dir="ltr" align="left">

```text
python -m unittest discover -s tests -p "test_*.py" -v
```

</div>

`skill-evaluation` provides seven behavioral fixtures and a configurable runner. Without a runner it only prepares workspaces and reports `prepared`; it makes no model API calls. For real execution an authorized runner invokes the actual agent with the evaluated skill and records agent/model identity and results. Expected assertions/oracles are withheld from the model. Actual `passed`, `failed` and `blocked` outcomes are distinguished; existing reports are not overwritten.

<div dir="ltr" align="left">

```text
python <installed-skill-evaluation>/scripts/evaluate.py --output <new-report.json>
python <installed-skill-evaluation>/scripts/evaluate.py --runner-config <authorized-runner.json> --output <new-report.json>
```

</div>

These fixtures do not cover every behavior of all 21 skills. Temporary directories are not an OS security sandbox; runners must be trusted and authorized. Declared runner identity is not cryptographic attestation, and self-reported JSON alone cannot prove that the right question was asked. See the [evaluation contract](../.agents/skills/skill-evaluation/references/evaluation.md).

## Stack profiles and quality controls

React/browser, Python, .NET and relational database profiles are read only for the detected stack. Actual versions and conventions govern; changing external claims require current primary documentation. Edit the [profile source](../core/stack-profiles.md) and relevant generated skill resources.

CI runs installation/documentation/parity checks and Python tool tests on Windows/Linux/macOS. Job definitions or local passes do not establish hosted CI success. Skill completion requires actual evidence for the current request; no skill guarantees absence of all bugs, perfect security or infallible memory.

</div>
