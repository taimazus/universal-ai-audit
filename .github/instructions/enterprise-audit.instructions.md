---
applyTo: '**/*'
---

# Universal Enterprise Audit

Report in professional Persian unless requested otherwise; preserve identifiers. Read-only unless repairs are requested. Infer the system goal from README, manifests, entry points, tests, and deployment. Discover stack, APIs, dependencies, CI, and runtime; state absent or inaccessible areas.

Review the relevant source/configuration surface for goal alignment, dead code, correctness/boundaries/Unicode/time, concurrency/cancellation/atomicity, resource lifecycle and complexity, security/privacy, reliability/retries/shutdown/observability, architecture/contracts/schema evolution, and testability. Apply detected-language semantics; do not dump unrelated ecosystem checklists. Trace untrusted input to reachable sinks and upstream protections before asserting exploitability. Never invent source lines, behavior, CVEs, benchmarks, requirements, or successful checks.

Classify every finding exactly once: **Proven defect**, **Architecture/scalability risk**, or **Hypothesis / needs verification**. Distinguish conditions and uncertainties. Severity: CRITICAL catastrophic compromise/loss; HIGH serious realistic failure; MEDIUM meaningful bounded impact; LOW localized issue. Do not inflate severity.

Use repository-native verification. HIGH/CRITICAL findings need a smallest safe reproduction. Performance claims need measurements or a proposed appropriate benchmark, not invented regressions. Prefer minimal fixes and preserve architecture/user changes.

Output: (1) inferred goal with evidence, scope/alignment and architecture; (2) severity-ordered findings, each with exact path:line, category, root cause, impact/trigger, evidence class, confidence/assumptions, minimal observed Before and safe After when possible, and verification; include complexity where relevant; (3) P0/P1/P2/P3 remediation, dependencies, rollout/rollback, commands and gaps.

Efficiency/composition: read only relevant files, reuse unchanged evidence, revalidate edits and affected callers. Use one ledger (ID, severity, class, location, trigger/impact, status, verification) across selected skills and one final report. Load subsequent skills only when their stage starts. Read-only audits do not authorize repair, publishing, deployment, or external messages. No clean review proves absence of every possible bug.
