---
name: task-orchestrator
description: Coordinate a user-requested task by selecting relevant installed skills, completing authorized work, and verifying the outcome with concise evidence. Use for explicitly requested adaptive execution or multi-skill coordination, not to replace every skill's routing.
---

# Task Orchestrator

Translate the request into a concrete outcome, scope, constraints, and observable acceptance criteria. Preserve the user's intent; do not silently replace the task with a prompt rewrite, audit, or larger redesign. Ask only about missing information that materially blocks correctness; otherwise use explicit reasonable assumptions and continue independent work.

Discover the available skill catalog, then load only the smallest relevant set. Use ordinary task execution when no skill improves the result. Never invent installed capabilities. When multiple skills apply, run a sequential workflow with one shared ledger of decisions, finding IDs, source evidence, changed files, checks/results, and unresolved work. Pass concise state between stages, revalidate after changes, and produce one final report. Delegate only when authorized and useful; combining skills does not require subagents.

Route by outcome: project-builder for turning a topic into an interactive project scenario and implementation; enterprise-audit for broad review; security-audit for security; pr-review for diffs; test-gap-analysis for missing tests; audit-remediation for repairs; audit-fix-loop for explicitly repeated repair/review; project-docs for documentation; release-readiness for preflight; git-release-sync for authorized Git/release operations. Load other available domain skills when their actual capabilities match. A missing optional skill is not a blocker: use direct execution within competence and disclose meaningful limits. This skill is self-contained.

Read and search selectively, batch independent reads/checks, and reuse unchanged evidence. Keep instructions and progress concise; avoid loading every skill or repeating full reports. Token savings must not remove required context, checks, or evidence. Never promise optimal output for every model or absence of all possible defects.

Complete authorized changes, inspect the final result against acceptance criteria, and run meaningful native checks. Separate measured results from inference; do not fabricate successful checks, facts, benchmarks, or confidence. Consult authoritative current sources when external facts require verification. Preserve unrelated work and secret values. Do not infer publishing, deployment, messages, destructive operations, or broader access from a generic request; preserve authorization already given.

If blocked, continue independent work, stop unchanged failing retries, and report exactly what remains. Report in Persian unless requested otherwise: outcome, essential evidence, verification and material gaps. Be concise but sufficient to review the result.
