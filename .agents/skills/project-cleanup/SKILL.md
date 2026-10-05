---
name: project-cleanup
description: Identify and remove verified unnecessary project files and directories with a reviewable dry-run, recoverable changes, and relevant regression checks. Use for project cleanup, not general refactoring or Git history cleanup.
---

# Project Cleanup

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

Establish the repository root, requested paths, and cleanup intent. Read repository instructions, Git status, ignore rules, build/install configuration and references to candidate paths. Use explicit reasonable assumptions for a missing scope; never infer that all untracked or ignored files are disposable. A request to create this skill does not authorize running cleanup.

Prepare a dry-run ledger with each exact path, tracked/untracked/ignored state, evidence of disuse or reproducibility, dependent callers, proposed action, recovery method and relevant verification. Separate confirmed disposable artifacts from uncertain candidates. Caches and generated outputs qualify only when their source and regeneration command are established. Backups, local configuration, secrets, installed skills and user data require evidence and appropriate authorization; age, extension, duplicate-looking names or ignore status alone do not establish disuse. Do not print secret contents.

Complete the reviewable plan before requesting any necessary approval. Existing authorization for exact removals persists; do not ask again. Where a generic cleanup request does not establish permission for destructive removal of unique data, leave those candidates pending and complete independent authorized work. Prefer reversible edits or a recoverable quarantine outside build/discovery paths; record its exact location and restore procedure. Do not automatically expire or remove the quarantine or backups.

Before recursive removal or movement, resolve each absolute target and verify containment within the authorized scope. Reject the repository root, .git, paths outside scope, and symlink/junction targets that escape it. Inspect links without traversing them; do not follow them during cleanup. On Windows use one shell end-to-end and literal-path operations. Avoid broad wildcard deletion and git clean/reset; operate only on the verified ledger, rechecking state immediately before mutation. Preserve unrelated dirty files and stop if a candidate changed since inspection.

After changes, inspect the diff and remaining paths, run the affected build/install/tests, and check documentation or configuration references to removed paths. Record actual results and unavailable checks. If a required check fails because of cleanup, restore affected artifacts, verify recovery and report the unresolved cause. A second dry-run should find no remaining approved candidates, while uncertain candidates may remain.

When composed with task-orchestrator, reuse its shared ledger and acceptance criteria. Use project-docs only for affected documentation and release-readiness only for requested packaging assessment. Pass exact changed paths, checks and unresolved candidates to git-release-sync when Git operations were requested; cleanup itself does not authorize commit, push, tags, releases or deployment. Do not create nested audit loops or require all other skills.

Report in Persian unless requested otherwise: executed changes, evidence, checks, recovery location/procedure and pending candidates. Distinguish dry-run proposals from executed removals.

## Completion evidence

Only approved proven candidates changed recoverably; affected checks and second dry-run passed, with pending candidates and restoration paths reported.
