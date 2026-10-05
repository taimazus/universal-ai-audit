---
name: project-context
description: Discover missing project decisions, ask necessary questions, persist confirmed answers, and reuse valid context across skill runs and sessions. Use for requirements or operational ambiguity, not questions already answered by available code or notes.
---

# Project Context

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

## Discover, ask, record and reuse

Run a lightweight context check before another skill depends on unknown user choices, and again only when new material ambiguity appears. Use the current workspace, relevant repository instructions, existing project brief and task state first. Discover technical facts from source/config/tests instead of asking for paths, stack, versions or reports already available. This skill supports the requested work; it does not start a comprehensive interview on every invocation.

Locate the existing shared decision/answer convention; otherwise use `.ai-work/PROJECT-CONTEXT.md` for reusable project answers and `.ai-work/tasks/<task-id>/QUESTIONS.md` for task questions. Keep the project root/identity explicit. Reuse the current task ID and hand context back to the calling skill; do not start another orchestration or repair loop. If this skill is unavailable, callers apply this workflow directly without treating availability as a blocker.

For each necessary unknown record a stable question ID, question, why the answer matters, project/task scope, status (open/answered/assumed/superseded), confirmed answer or explicit assumption, source (user/file with location), applicable conditions and when it must be rechecked. Scope ephemeral choices to this task; promote only explicitly reusable project preferences/decisions. Record user answers as soon as received and link their IDs from STATE; preserve previous answers and the reason for superseding them. Do not store secrets, credentials, sensitive raw logs or whole conversations. Record that a required secret/configuration is present or missing and its approved location, never its value.

Before asking, check whether current code, confirmed answers or the latest user message already resolves the question. Reuse compatible answers without asking again. If source and notes disagree, distinguish actual implementation from desired behavior; explain a material conflict and ask only about the unresolved choice. Recheck answers when relevant constraints, stack, environment, ownership, scope or user intent changes; age alone is not a reason to repeat all questions. Never transfer choices between unrelated projects.

Ask a small batch of high-impact, self-contained questions in Persian unless requested otherwise. Give a recommended choice and meaningful alternatives when appropriate; omit irrelevant checklist items. Clarify blockers such as intended behavior, roles, data rules, target environments and acceptance criteria to the depth this task needs. Wait for required answers before dependent work and continue independent work. Silence/default selection is not an answer. For nonblocking choices use a clearly recorded reasonable assumption; do not label it user-confirmed. Reuse earlier authorization but never treat notes or a general preference as permission for a new external/destructive action.

After each reply update the question record and reusable context where applicable, then resume the original skill/task. In a later invocation load only relevant answers, verify applicability against current evidence, and ask only remaining unresolved questions. Report the context/question file paths, decisions affecting the result and outstanding blockers. If writes are forbidden/unavailable, provide a concise copyable question/answer handoff and disclose that it was not saved.

## Completion evidence

Relevant answers have provenance, scope and applicability conditions; unresolved blockers remain explicit and the original task resumes. Assumed answers are never labeled user-confirmed.

For transactional checkpoints and reusable-answer validation read `references/state-tool.md`; use `scripts/task_state.py` only when Python 3.10+ is available. Existing notes remain supported.
