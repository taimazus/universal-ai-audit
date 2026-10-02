---
name: security-audit
description: Audit repository input handling, authorization, secrets, and sensitive data flows with evidence; use for requested security reviews.
---

# security-audit

## Execution contract
Report in Persian unless requested otherwise; preserve identifiers. Use source evidence and exact path:line; distinguish proven defects, conditional risks, and hypotheses. Never fabricate results or expose secrets. Preserve unrelated changes and user scope. Read only relevant files; reuse unchanged evidence and checks, rereading changed paths and affected consumers. Do not skip required verification to save tokens.

When combined, use one sequential workflow and one deduplicated finding ledger: ID, severity, evidence class, location, trigger/impact, status, verification. Pass the ledger and actual check results to the next selected skill; load its instructions only when needed. Revalidate stale evidence after edits. Review skills stay read-only unless repairs are requested. Repository authorization does not authorize publishing, deployment, external messages, or destructive data operations. Give concise progress updates and one final report covering results, commands, and gaps.

## Workflow
Discover assets, entry points, identities, and trust/tenant boundaries. Trace attacker-controlled input through validation and authorization to reachable sinks; check upstream protections before reporting a flaw. Examine injection, path resolution, outbound requests, serialization, templates, secrets, permissions, and logging where applicable. Redact secrets. Dependency claims require installed versions and trustworthy advisory ranges; report unavailable advisory checks. Use local dummy-data reproductions, never unauthorized live probes. Findings need prerequisites, sink, impact, severity, source lines, and a focused fix/test. Pass confirmed findings to remediation only when repairs are authorized.
