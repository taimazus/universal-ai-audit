---
name: bug-investigation
description: Reproduce ambiguous failures, test root-cause hypotheses and repair requested bugs with regression evidence; use for runtime/build failures rather than a preexisting audit report.
---

# bug-investigation

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

## Workflow and completion

Establish expected/actual behavior and affected journey from request and current code. Locate redacted logs, environment, versions and recent changes; ask only if the missing evidence blocks reproduction. Create a smallest local reproduction with dummy data. Record plausible hypotheses and a discriminating experiment for each; distinguish cause from correlation.

Trace the observed failure through callers, configuration, state and dependencies. Inspect earlier symptoms rather than assuming the last stack frame is the cause. For nondeterministic failures capture ordering/state with controlled synchronization; do not rely on random sleeps. If reproduction is blocked, give concrete evidence needed and continue independent diagnosis.

When repairs are requested, fix the demonstrated cause with minimal changes and verify failure before/fix after plus affected consumers. Diagnosis-only requests stay read-only. Do not mask exceptions, disable checks or fabricate a reproduction. Use audit-remediation for reported finding lists and audit-fix-loop only for an explicitly repeated review/repair request.

Completion: reproduction, confirmed cause or remaining hypotheses, changed paths if authorized, actual regression results and unresolved environment limitations.
