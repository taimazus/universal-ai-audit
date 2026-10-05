---
name: operations-readiness
description: Assess and implement requested health, observability, backup and recovery for a running-service design; use release-readiness for package/install readiness and do not infer deployment permission.
---

# operations-readiness

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

## Workflow and completion

Establish service topology, environments, ownership, data criticality and recovery targets from project evidence and user decisions. Inspect relevant stack notes in references/stack-guide.md. Assess readiness/liveness semantics, logs/metrics/alerts, configuration, resource limits and dependency outages without probing unauthorized live systems.

Trace failure modes, retry budgets, graceful shutdown, cancellation, queues and partial writes where relevant. Distinguish health responses from actual dependency availability. Review sensitive log handling and actionable alerts. Assess backup scope, retention, restore integrity and explicitly agreed recovery time/data-loss targets.

For implementation requests add focused local configuration/code/runbooks. Exercise outage, restart and backup/restore in isolated dummy environments, verifying actual restored data and consumers. Assessment alone stays read-only; do not create cloud resources, rotate credentials, change production settings or deploy without authorization.

Completion: evidenced operational gaps, executed failure/recovery checks, runbook and recovery limits. A configured backup or green health endpoint is not proof of tested recovery.
