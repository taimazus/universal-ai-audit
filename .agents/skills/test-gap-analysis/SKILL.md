---
name: test-gap-analysis
description: Map important repository contracts and failure paths to test assertions and prioritize missing coverage; use for test assessments or plans.
---

# test-gap-analysis

## Execution contract
Report in Persian unless requested otherwise; preserve identifiers. Use source evidence and exact path:line; distinguish proven defects, conditional risks, and hypotheses. Never fabricate results or expose secrets. Preserve unrelated changes and user scope. Read only relevant files; reuse unchanged evidence and checks, rereading changed paths and affected consumers. Do not skip required verification to save tokens.

When combined, use one sequential workflow and one deduplicated finding ledger: ID, severity, evidence class, location, trigger/impact, status, verification. Pass the ledger and actual check results to the next selected skill; load its instructions only when needed. Revalidate stale evidence after edits. Review skills stay read-only unless repairs are requested. Repository authorization does not authorize publishing, deployment, external messages, or destructive data operations. Give concise progress updates and one final report covering results, commands, and gaps.

## Workflow
Discover runners, fixtures, CI commands, and critical contracts. Map assertions to observable behavior, distinguishing unit/integration/end-to-end/platform coverage. Inspect relevant boundaries, authorization, persistence, retries, partial failure, cancellation, ordering, and concurrency. Each gap needs implementation lines, searched test scope, behavior at risk, why current tests miss it, and a minimal setup/expected result/test layer. Separate measured coverage from inferred gaps; never invent percentages or unexecuted passes. Add tests only when requested; do not mirror internals or change production behavior merely to satisfy coverage. Pass prioritized scenarios to an authorized repair stage.
