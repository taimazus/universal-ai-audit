---
name: audit-fix-loop
description: Repeat verified repairs, regression checks, and fresh review until confirmed findings are resolved and a complete pass finds no new actionable defects.
---

# audit-fix-loop

## Execution contract
Report in Persian unless requested otherwise; preserve identifiers. Use source evidence and exact path:line; distinguish proven defects, conditional risks, and hypotheses. Never fabricate results or expose secrets. Preserve unrelated changes and user scope. Read only relevant files; reuse unchanged evidence and checks, rereading changed paths and affected consumers. Do not skip required verification to save tokens.

When combined, use one sequential workflow and one deduplicated finding ledger: ID, severity, evidence class, location, trigger/impact, status, verification. Pass the ledger and actual check results to the next selected skill; load its instructions only when needed. Revalidate stale evidence after edits. Review skills stay read-only unless repairs are requested. Repository authorization does not authorize publishing, deployment, external messages, or destructive data operations. Give concise progress updates and one final report covering results, commands, and gaps.

## Workflow
Start from the supplied report or audit the requested scope. Track finding IDs, root causes, attempts, and actual verification; deduplicate and verify claims. Repeat: prioritize unresolved confirmed defects, apply minimal repairs, test failure/boundary behavior, run required checks, then reread affected code/consumers and record newly proven findings. Reopen contradicted resolutions. Use selected review skills in their relevant stages; one coordinator owns the loop, never nested repair loops.

Finish only after all confirmed findings are demonstrably resolved, required checks pass, and a complete fresh review of the agreed scope finds no new actionable defects. Whole-repository scope requires the relevant full source/configuration surface, not just edited files. Record coverage gaps; do not guarantee absence of all possible bugs.

Respect explicit budgets. After two unsuccessful fixes without new evidence, reassess reproduction/root cause before further edits. After two cycles of the same external blocker with no independent work left, report incomplete work and what is needed; do not blindly retry. Continue independent repairs meanwhile. Material uncertainty, stalled reassessment, missing required checks, or exhausted user limits must remain explicit in the final report: cycles, old/new finding statuses, changed locations, checks, blockers, and rollback needs.
