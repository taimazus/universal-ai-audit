---
name: test-engineering
description: Implement meaningful tests from important behavior contracts, repair flaky tests and verify regressions; use test-gap-analysis for assessment without implementation.
---

# test-engineering

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

## Workflow and completion

Discover existing runners, fixtures, CI and external dependency boundaries. Confirm requested test scope and prioritized behavior contracts; revalidate supplied gap plans against current source. Use relevant stack notes in references/stack-guide.md, not an unrelated framework checklist.

Add tests for observable success and important negative/boundary/failure paths. Reproduce a bug before the fix when possible. Prefer realistic integration tests for persistence/authorization contracts and narrow unit tests for pure logic. Mock only external boundaries with explicit contract assumptions; implementation detail duplication is not evidence.

For flaky tests, reproduce under controlled seed/order/parallelism and identify shared state, timing or leaked resources. Replace arbitrary delays with deterministic synchronization and ensure cleanup. Do not weaken assertions, skip failing tests or change production behavior solely to raise coverage. Fault injection must use isolated dummy resources.

Run new tests and required affected suites, recording command, environment and outcomes. Report measured coverage only after executing the measurement. Completion: concrete assertions, before/after regression evidence where applicable, actual results and remaining untested contracts.
