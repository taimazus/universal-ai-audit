---
name: release-readiness
description: Assess installation, packaging, versions, upgrades, compatibility, and rollback before a release; assessment alone does not authorize publishing.
---

# release-readiness

## Execution contract
Report in Persian unless requested otherwise; preserve identifiers. Use source evidence and exact path:line; distinguish proven defects, conditional risks, and hypotheses. Never fabricate results or expose secrets. Preserve unrelated changes and user scope. Read only relevant files; reuse unchanged evidence and checks, rereading changed paths and affected consumers. Do not skip required verification to save tokens.

When combined, use one sequential workflow and one deduplicated finding ledger: ID, severity, evidence class, location, trigger/impact, status, verification. Pass the ledger and actual check results to the next selected skill; load its instructions only when needed. Revalidate stale evidence after edits. Review skills stay read-only unless repairs are requested. Repository authorization does not authorize publishing, deployment, external messages, or destructive data operations. Give concise progress updates and one final report covering results, commands, and gaps.

## Workflow
Identify artifact, intended version, distribution, and evidenced support matrix. Run native build/tests; verify artifact contents, entry points, dependencies, and version consistency. In isolated destinations check fresh/repeated/upgrade installs, existing config, paths with spaces, invalid arguments, permissions, dry-run, exit codes, and backup preservation. Trace migrations and rollback of both executable artifacts and state; flag irreversible/unverified restoration. Report source-backed blockers, executed checks, untested environments, and scoped go/no-go. In a combination use completed repair results but rerun checks invalidated by later edits. Do not tag, push, publish, or deploy merely because readiness passes.
