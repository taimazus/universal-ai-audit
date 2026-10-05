---
name: pr-review
description: Review a pull request or local diff for actionable regressions with exact source evidence; use for change reviews, not whole-repository audits.
---

# pr-review

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
Establish target/base from the request: branch merge-base, staged, or unstaged diff. Without history use supplied before/after evidence and report the limitation. Read changed functions, consumers, contracts, and tests. Report concrete defects introduced or materially worsened by changes; explain the triggering input and impact at the narrowest current changed location. Exclude style preferences and unsupported requirements. Run relevant checks; passing tests do not prove untested compatibility. Return severity-ordered findings, assessment, and gaps; report no actionable findings when appropriate. Do not post or merge a review unless authorized.

## Completion evidence

Actual base/head or before/after identities and affected consumers are examined; introduced/worsened defects have triggers and exact locations, with explicit review gaps.
