---
name: project-builder
description: Turn a project topic into an interactive requirements brief, detailed scenarios, architecture, and an implemented, verified project. Use for starting or substantially defining a project, not isolated fixes or documentation-only requests.
---

# Project Builder

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

Report and discuss in Persian unless requested otherwise; preserve technical identifiers. Support discovery-only, design-only, and build modes. Infer the mode from the request; a request to plan does not authorize implementation. Respect existing work, chosen technologies, scope, budget, and prior authorization. Never promise a flawless project or invent successful tests.

## Discover and agree

Inspect relevant repository instructions and existing code first. For a new topic, identify the problem, target users, main outcomes, boundaries, and success criteria. Maintain one concise project brief: confirmed requirements, explicit assumptions, unresolved decisions, acceptance criteria, and implementation status. Reuse it across turns; do not repeat answered questions.

Ask a small batch of high-impact questions about users/roles, essential journeys, platform, data/integrations, constraints, and what must be excluded. Offer a recommended choice and meaningful tradeoffs when useful. Adapt follow-ups to answers rather than delivering an exhaustive questionnaire. Ask about security/privacy, scale, accessibility, deployment, maintenance, time, and cost only to the depth relevant to the project. User-owned constraints must not be guessed. Wait for required answers; meanwhile complete independent research or design. Silence is not acceptance.

Present a concrete scenario and scope for user review. Resolve materially conflicting or blocking answers before dependent work. Reuse permission already granted; do not add repeated approval gates. If the user requested a build and the material decisions are settled, proceed with the agreed scope. Mark optional future features separately; do not silently implement them. When stack is unspecified, compare suitable options briefly and propose the smallest adequate architecture; verify changing external claims with current primary sources.

## Specify the observable project

Scale detail to complexity, covering applicable areas rather than creating boilerplate:

- Actors, permissions, journeys, states, screens, navigation, validation, empty/loading/error states, recovery, localization and accessibility.
- Domain entities, ownership, invariants, lifecycle, schema constraints, migrations, retention and deletion; API/events, contracts, authentication and authorization.
- Main, alternate, failure and abuse scenarios; boundaries, concurrency, duplicate requests, time handling and integration outages where relevant.
- Architecture and editable diagrams, modules, dependencies, configuration, secret handling, environments, observability, performance targets, installation, upgrade and rollback.
- Ordered milestones with dependencies, MVP versus later scope, requirement IDs linked to measurable acceptance tests, and meaningful risks/unknowns.

Use concrete examples and Given/When/Then criteria for critical journeys. Separate evidence, proposed design, and assumptions. Keep requirements, scenarios, design decisions and test mapping in the project's existing documentation conventions; otherwise use a small docs set. Record deferred decisions instead of presenting guesses as settled facts. Do not impose backend/database/cloud components on projects that do not need them.

## Build and verify

Create new human-facing project documentation in Persian and English by default, plus additional languages supplied by the user; an explicit narrower set overrides the default. When updating a topic, synchronize all its existing language variants. Preserve locale/file conventions and reciprocal language links, semantic parity and technical identifiers. Apply language-appropriate RTL/right or LTR/left layout while keeping code/commands LTR. Use project-docs' language/direction workflow when available; otherwise apply these requirements directly and disclose missing translation or rendering checks. This concerns documentation, not an implicit requirement to localize the product UI.

Work in the requested project destination; do not overwrite an existing application to scaffold a new one. Implement a small working vertical slice first, then complete agreed milestones. Prefer actual usable behavior over placeholder screens or mocked success. Label intentional stubs and unavailable integrations; provide a local substitute only when appropriate and clearly disclosed.

Discover available skills and load only relevant ones: task-orchestrator for coordination, project-docs for substantial documentation, security-audit for sensitive boundaries, test-gap-analysis for uncertain coverage, audit-remediation or audit-fix-loop for verified defects, release-readiness for packaging. Missing optional skills do not block direct work. Do not invoke every review automatically, start nested repair loops, or delegate without authorization. Pass the same brief and deduplicated finding ledger between stages.

Run the project's required checks and meaningful acceptance tests, including applicable negative/boundary paths. Inspect the built result against journeys and requirements; run UI/accessibility checks when tooling exists. Repair confirmed defects and recheck affected behavior. If a requirement or check is blocked, continue independent milestones and report the remaining gap; do not call an untested integration complete.

Finish with runnable setup/start commands, final scenario/design documentation, requirement-to-test status, actual checks and results, known risks/deferred features, and operational/rollback guidance appropriate to the project. Review the agreed scope for omissions. Keep the final report concise and link detailed artifacts. Publishing, deployment, paid resources and destructive data changes require their own authorization; an end-to-end project request does not imply them.

## Completion evidence

Agreed requirements map to observable acceptance results, runnable setup and actual integration status; design-only work does not silently build.
