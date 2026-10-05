---
name: feature-delivery
description: Implement a bounded feature in an existing project through contracts, local changes and acceptance verification; use project-builder for a new project or substantial project definition.
---

# feature-delivery

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

## Workflow and completion

Read the existing journey, consumers and project conventions. Clarify feature outcome, excluded work and observable positive/negative acceptance criteria using project-context when needed. Review relevant references/stack-guide.md only for the detected stack. Identify public contracts, data/permission changes and integration constraints before dependent work.

Implement the smallest complete vertical slice, then complete the requested scope. Include validation, authorization, failure/recovery and UI loading/empty/error states where applicable. Preserve existing user edits and avoid unrelated architecture changes. Real integrations must be tested when available; intentional stubs and blocked integrations stay explicit.

Run native required checks and scenario acceptance, inspect the actual diff and consumer effects, and fix confirmed regressions. Use test-engineering for substantial test implementation and project-docs for affected documentation when available; neither is a mandatory extra stage for a small change.

Completion: acceptance-to-test mapping, runnable changed behavior, actual checks and remaining gaps. Do not mark a blocked integration complete or deploy merely because local tests pass.
