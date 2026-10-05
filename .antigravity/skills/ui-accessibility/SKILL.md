---
name: ui-accessibility
description: Inspect and repair requested UI journeys, responsive behavior, RTL and accessibility with browser evidence; distinguish source inspection from actual user interaction.
---

# ui-accessibility

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

## Workflow and completion

Identify page/journey, expected behavior, relevant devices/locales and existing design conventions. Establish applicable keyboard, focus, labels, contrast and screen-reader semantics to the depth of the request; avoid claiming conformance without its specified checks. Read relevant frontend notes in references/stack-guide.md.

Inspect real loading/empty/error/success states, navigation and permissions. For Persian verify both RTL direction and alignment, mixed identifiers/numbers, forms and icons whose direction matters. Check narrow/wide layouts, zoom and keyboard flows. Prefer semantic controls and visible focus; automated checks alone do not prove accessibility.

When repair is requested, make focused changes and verify the journey in an available browser, including an important negative path. Record viewport/locale and representative screenshots when permitted; do not expose private data. Without browser/screen-reader access disclose which source or automated checks ran and which user interactions were unverified.

Completion: observed behavior, changed paths if authorized, keyboard/RTL/responsive results, visual artifacts and accessibility gaps. Do not label source-only inspection as visual validation.
