---
name: skill-evaluation
description: Evaluate skill behavior with isolated scenarios, observable assertions and honest measured outcomes; distinguish real agent evaluations from deterministic tool tests.
---

# skill-evaluation

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

## Workflow and completion

Establish which skill/version, runner and scenarios are under evaluation. Read references/evaluation.md for the supplied fixtures and result contract. Use isolated repositories/data and retain raw artifacts without secrets. Evaluation approval is not permission to mutate live systems or incur unrequested API costs.

Build representative positive, negative, interruption and misuse scenarios. Each defines setup, user request, observable success/failure, allowed side effects and limitations. Include preservation of dirty files, read-only boundaries, stale answers, blocked checks, false findings and stopping conditions where relevant. Do not coach the evaluated agent with the expected fix. A harness without an available model runner remains prepared, not executed.

Run actual tool/agent scenarios only in the authorized environment. Inspect resulting files, tests, commands, state and reported results; score assertions rather than writing style or self-rated confidence. A failing scenario is actionable evidence; minimize and reproduce before changing the skill. Keep evaluation identities and actual pass/fail/blocked results, repair proven failures and rerun affected cases. Do not equate static instruction validation or scripted mock transcripts with model behavior.

Completion: identify executed versus prepared scenarios, runner/model identity when real, assertion results, artifacts and untested behaviors. No claim of cross-model reliability without those runs.
