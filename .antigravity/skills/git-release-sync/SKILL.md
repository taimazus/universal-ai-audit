---
name: git-release-sync
description: Prepare and perform authorized Git synchronization, commits, version updates, tags, and hosted releases while preserving history and verifying the published commit. Use for explicit Git or release maintenance requests.
---

# Git and Release Sync

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

When authoring human-facing repository documentation or release notes, default new topics to Persian and English and accept additional user-supplied languages; explicit language choices take precedence. Synchronize all existing language variants of updated topics. Preserve technical identifiers and language links, and apply RTL/right alignment or LTR/left alignment according to the language, with commands/code LTR. Reuse project-docs when available; otherwise perform the same parity/link/source checks directly and disclose unverified rendering. Preparing multilingual notes does not authorize publishing them.

For Git/GitHub updates, distinguish updating a local checkout, committing task changes, pushing refs, opening/updating a PR, changing repository settings, and publishing a Release. Inspect the actual remote host and available GitHub connector or CLI; do not assume GitHub from a folder name. Read-only remote inspection does not authorize remote mutations. An unspecified update request defaults to preparing and verifying local changes; report the unresolved target rather than choosing a remote branch or publishing implicitly.

For an authorized checkout update, inspect upstream divergence and worktree changes before fetching and integrating. Prefer fast-forward integration when possible; if it cannot succeed, inspect the conflicting history and prepare a reviewable integration consistent with user intent. Do not auto-stash unrelated work or discard it. For an authorized GitHub PR update, inspect base/head, current diff and existing PR before mutation, use exact notes through structured arguments or a body file, then verify its URL, branches and head SHA. Inspect remote state after an ambiguous failure before retrying.

When combined with task-orchestrator, reuse its ledger of scope, changed paths, checks and authorization. Accept project-cleanup's executed path list and recovery notes, but independently inspect the staged diff; do not stage quarantines or unrelated removals. project-docs owns documentation changes and release-readiness provides assessment; neither authorizes publication. Preserve an explicit local-only constraint throughout the workflow.

Establish the requested operations: local edits/commit, fetch/integration, push, tag, hosted Release, and assets are distinct. A local Git update alone does not authorize remote publication. An explicit push or release request authorizes that operation; do not repeatedly ask for permission already given. Read repository instructions, contribution/release conventions, status, branch/remotes/upstream, version files, existing tags/releases, and native checks.

Preserve user changes and existing history. Never force-push, reset, clean, delete remote branches/tags, overwrite another release, or stage unrelated changes merely to synchronize. Fetch authorized remotes; inspect divergence before integrating. Resolve conflicts from behavior and intent, preserving upstream-only files. For unrelated histories, explain and prepare a reviewable merge rather than replacing remote history. Respect branch protection; use a PR when required instead of weakening controls.

Choose the version from user intent and established policy; coordinate manifests, changelogs, docs, packaging, and CI metadata. Never reuse an existing tag for different contents. Run relevant build/test/docs checks or the available release-readiness workflow. Required failing checks block publication; state unavailable checks. Inspect the staged diff for secrets, generated artifacts, unintended deletions, and unrelated files before committing with a concrete summary.

Push only authorized refs using normal history-preserving operations. Verify remote SHA matches the intended commit. For an authorized hosted Release, create a unique tag at the verified commit and prepare exact notes with changes, tests, compatibility/rollback and limits. Use structured arguments or a notes file to preserve multiline text. Attach only requested or established release artifacts built from that commit; exclude secrets, caches, backups, and .git. Verify tag target, Release URL/state/assets, and applicable CI outcome. If CI is pending, report it as pending; do not call it passed.

Make retries idempotent: inspect whether the intended commit/ref/release already exists before repeating a mutation. If network/auth/policy blocks publication, complete independent local work and report the exact unresolved step. Do not bypass approval rejection or branch protection. If version or release already exists, update only authorized notes/assets after inspecting it; do not silently replace or delete content.

Report in Persian unless requested otherwise: version, branch, commit SHA, pushed refs, CI result, Release link/assets, and remaining gaps. A Release record is not deployment; do not deploy or message others without scope and authorization.

## Completion evidence

Only authorized refs/actions changed; staged scope and remote/tag/Release identities are verified with actual CI state, or remaining publication steps are explicit.
