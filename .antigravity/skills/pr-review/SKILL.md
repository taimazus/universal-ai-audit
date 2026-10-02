---
name: pr-review
description: Review a pull request or local diff for actionable regressions with exact source evidence; use for change reviews, not whole-repository audits.
---

# pr-review

## Execution contract
Report in Persian unless requested otherwise; preserve identifiers. Use source evidence and exact path:line; distinguish proven defects, conditional risks, and hypotheses. Never fabricate results or expose secrets. Preserve unrelated changes and user scope. Read only relevant files; reuse unchanged evidence and checks, rereading changed paths and affected consumers. Do not skip required verification to save tokens.

When combined, use one sequential workflow and one deduplicated finding ledger: ID, severity, evidence class, location, trigger/impact, status, verification. Pass the ledger and actual check results to the next selected skill; load its instructions only when needed. Revalidate stale evidence after edits. Review skills stay read-only unless repairs are requested. Repository authorization does not authorize publishing, deployment, external messages, or destructive data operations. Give concise progress updates and one final report covering results, commands, and gaps.

## Workflow
Establish target/base from the request: branch merge-base, staged, or unstaged diff. Without history use supplied before/after evidence and report the limitation. Read changed functions, consumers, contracts, and tests. Report concrete defects introduced or materially worsened by changes; explain the triggering input and impact at the narrowest current changed location. Exclude style preferences and unsupported requirements. Run relevant checks; passing tests do not prove untested compatibility. Return severity-ordered findings, assessment, and gaps; report no actionable findings when appropriate. Do not post or merge a review unless authorized.
