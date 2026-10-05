---
name: migration-upgrade
description: Implement and verify dependency, framework, schema or API upgrades with compatibility checks and recovery; separate local migrations from live data operations.
---

# migration-upgrade

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

## Workflow and completion

Establish source/target versions, support matrix, consumers and compatibility expectations. Inspect lockfiles and relevant stack notes in references/stack-guide.md. Consult current primary release/advisory documentation when external changing facts matter; do not guess supported versions or security ranges.

Plan ordered code/config/schema changes, compatibility windows, data backfill and failure recovery. Distinguish reversible artifact changes from irreversible data changes; do not describe a down migration as tested recovery without execution. Use isolated data and temporary installations. Deployment or live-data mutation needs its own explicit authorization.

Implement requested local upgrade, lockfile and migration changes; verify clean install, upgrade from the supported previous state, repeated execution, failure paths and consumer behavior. Check downgrade only when supported and relevant. Preserve user configuration and backup/recovery evidence; do not discard a lockfile to conceal conflicts.

Completion: source/target identities, compatibility results, executed migration/recovery checks and irreversible or blocked paths. Unknown environments remain unverified.
