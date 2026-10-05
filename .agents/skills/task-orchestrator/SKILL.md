---
name: task-orchestrator
description: Coordinate a user-requested task by selecting relevant installed skills, completing authorized work, and verifying the outcome with concise evidence. Use for explicitly requested adaptive execution or multi-skill coordination, not to replace every skill's routing.
---

# Task Orchestrator

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

Translate the request into a concrete outcome, scope, constraints, and observable acceptance criteria. Preserve the user's intent; do not silently replace the task with a prompt rewrite, audit, or larger redesign. Ask only about missing information that materially blocks correctness; otherwise use explicit reasonable assumptions and continue independent work.

Discover the available skill catalog, then load only the smallest relevant set. Use ordinary task execution when no skill improves the result. Never invent installed capabilities. When multiple skills apply, run a sequential workflow with one shared ledger of decisions, finding IDs, source evidence, changed files, checks/results, and unresolved work. Pass concise state between stages, revalidate after changes, and produce one final report. Delegate only when authorized and useful; combining skills does not require subagents.

Route by outcome: project-builder for turning a topic into an interactive project scenario and implementation; enterprise-audit for broad review; security-audit for security; pr-review for diffs; test-gap-analysis for missing tests; audit-remediation for repairs; audit-fix-loop for explicitly repeated repair/review; project-docs for documentation; release-readiness for preflight; git-release-sync for authorized Git/release operations. Load other available domain skills when their actual capabilities match. A missing optional skill is not a blocker: use direct execution within competence and disclose meaningful limits. This skill is self-contained.

Route verified file/directory cleanup to project-cleanup and Git/GitHub updates to git-release-sync. Reuse the shared ledger of exact paths, authorization, recovery notes and checks; do not infer commit or remote publication from cleanup.

Read and search selectively, batch independent reads/checks, and reuse unchanged evidence. Keep instructions and progress concise; avoid loading every skill or repeating full reports. Token savings must not remove required context, checks, or evidence. Never promise optimal output for every model or absence of all possible defects.

Complete authorized changes, inspect the final result against acceptance criteria, and run meaningful native checks. Separate measured results from inference; do not fabricate successful checks, facts, benchmarks, or confidence. Consult authoritative current sources when external facts require verification. Preserve unrelated work and secret values. Do not infer publishing, deployment, messages, destructive operations, or broader access from a generic request; preserve authorization already given.

If blocked, continue independent work, stop unchanged failing retries, and report exactly what remains. Report in Persian unless requested otherwise: outcome, essential evidence, verification and material gaps. Be concise but sufficient to review the result.

## Completion evidence

The original acceptance criteria are verified, stage handoffs use one ledger and incomplete work remains explicit; no unrelated stage is introduced.
