---
name: git-release-sync
description: Prepare and perform authorized Git synchronization, commits, version updates, tags, and hosted releases while preserving history and verifying the published commit. Use for explicit Git or release maintenance requests.
---

# Git and Release Sync

Establish the requested operations: local edits/commit, fetch/integration, push, tag, hosted Release, and assets are distinct. A local Git update alone does not authorize remote publication. An explicit push or release request authorizes that operation; do not repeatedly ask for permission already given. Read repository instructions, contribution/release conventions, status, branch/remotes/upstream, version files, existing tags/releases, and native checks.

Preserve user changes and existing history. Never force-push, reset, clean, delete remote branches/tags, overwrite another release, or stage unrelated changes merely to synchronize. Fetch authorized remotes; inspect divergence before integrating. Resolve conflicts from behavior and intent, preserving upstream-only files. For unrelated histories, explain and prepare a reviewable merge rather than replacing remote history. Respect branch protection; use a PR when required instead of weakening controls.

Choose the version from user intent and established policy; coordinate manifests, changelogs, docs, packaging, and CI metadata. Never reuse an existing tag for different contents. Run relevant build/test/docs checks or the available release-readiness workflow. Required failing checks block publication; state unavailable checks. Inspect the staged diff for secrets, generated artifacts, unintended deletions, and unrelated files before committing with a concrete summary.

Push only authorized refs using normal history-preserving operations. Verify remote SHA matches the intended commit. For an authorized hosted Release, create a unique tag at the verified commit and prepare exact notes with changes, tests, compatibility/rollback and limits. Use structured arguments or a notes file to preserve multiline text. Attach only requested or established release artifacts built from that commit; exclude secrets, caches, backups, and .git. Verify tag target, Release URL/state/assets, and applicable CI outcome. If CI is pending, report it as pending; do not call it passed.

Make retries idempotent: inspect whether the intended commit/ref/release already exists before repeating a mutation. If network/auth/policy blocks publication, complete independent local work and report the exact unresolved step. Do not bypass approval rejection or branch protection. If version or release already exists, update only authorized notes/assets after inspecting it; do not silently replace or delete content.

Report in Persian unless requested otherwise: version, branch, commit SHA, pushed refs, CI result, Release link/assets, and remaining gaps. A Release record is not deployment; do not deploy or message others without scope and authorization.
