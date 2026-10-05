---
name: audit-fix-loop
description: Repeat verified repairs, regression checks, and fresh review until confirmed findings are resolved and a complete pass finds no new actionable defects.
---

# audit-fix-loop

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

## Execution contract
Report in Persian unless requested otherwise; preserve identifiers. Use source evidence and exact path:line; distinguish proven defects, conditional risks, and hypotheses. Never fabricate results or expose secrets. Preserve unrelated changes and user scope. Read only relevant files; reuse unchanged evidence and checks, rereading changed paths and affected consumers. Do not skip required verification to save tokens.

When combined, use one sequential workflow and one deduplicated finding ledger: ID, severity, evidence class, location, trigger/impact, status, verification. Pass the ledger and actual check results to the next selected skill; load its instructions only when needed. Revalidate stale evidence after edits. Review skills stay read-only unless repairs are requested. Repository authorization does not authorize publishing, deployment, external messages, or destructive data operations. Give concise progress updates and one final report covering results, commands, and gaps.

## Workflow
Start from the supplied report or audit the requested scope. Track finding IDs, root causes, attempts, and actual verification; deduplicate and verify claims. Repeat: prioritize unresolved confirmed defects, apply minimal repairs, test failure/boundary behavior, run required checks, then reread affected code/consumers and record newly proven findings. Reopen contradicted resolutions. Use selected review skills in their relevant stages; one coordinator owns the loop, never nested repair loops.

Finish only after all confirmed findings are demonstrably resolved, required checks pass, and a complete fresh review of the agreed scope finds no new actionable defects. Whole-repository scope requires the relevant full source/configuration surface, not just edited files. Record coverage gaps; do not guarantee absence of all possible bugs.

Respect explicit budgets. After two unsuccessful fixes without new evidence, reassess reproduction/root cause before further edits. After two cycles of the same external blocker with no independent work left, report incomplete work and what is needed; do not blindly retry. Continue independent repairs meanwhile. Material uncertainty, stalled reassessment, missing required checks, or exhausted user limits must remain explicit in the final report: cycles, old/new finding statuses, changed locations, checks, blockers, and rollback needs.

## Completion evidence

Confirmed findings are resolved, required checks pass and one complete fresh review of the agreed scope finds no new actionable defects; otherwise report incomplete work.
