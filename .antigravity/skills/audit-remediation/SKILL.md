---
name: audit-remediation
description: Fix reported audit defects and verify repairs with focused regression tests; use for remediation rather than read-only review.
---

# audit-remediation

## Execution contract
Report in Persian unless requested otherwise; preserve identifiers. Use source evidence and exact path:line; distinguish proven defects, conditional risks, and hypotheses. Never fabricate results or expose secrets. Preserve unrelated changes and user scope. Read only relevant files; reuse unchanged evidence and checks, rereading changed paths and affected consumers. Do not skip required verification to save tokens.

When combined, use one sequential workflow and one deduplicated finding ledger: ID, severity, evidence class, location, trigger/impact, status, verification. Pass the ledger and actual check results to the next selected skill; load its instructions only when needed. Revalidate stale evidence after edits. Review skills stay read-only unless repairs are requested. Repository authorization does not authorize publishing, deployment, external messages, or destructive data operations. Give concise progress updates and one final report covering results, commands, and gaps.

## Workflow
Verify each report against current source; mark disproven/already-fixed claims with evidence. Fix confirmed root causes in severity/dependency order using minimal compatible changes. Test observable failure behavior, meaningful boundaries, and affected callers. Never weaken assertions to pass. Run native required checks; record exit status and unavailable checks. Deliver finding statuses, changed locations, verification, and migration/rollback needs. When combined with audit-fix-loop, perform its repair stage without starting a second loop.
