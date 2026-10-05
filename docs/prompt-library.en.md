<div lang="en" dir="ltr" align="left">

# Prompt library for the project lifecycle

[فارسی](prompt-library.fa.md) · [Skills](skills.en.md) · [Combinations](combinations.en.md) · [Installation, Persian](installation.md)

This guide uses the current local repository. `.agents/skills/` contains 21 skills: `enterprise-audit` and 20 supplementary skills. Prompts request work; naming a skill does not install it. Install the pack in the target project and verify discovery first. `/audit-deep` and `/audit-goal` are semantic triggers, not guaranteed UI commands.

## How to use

Assume the project is already open in the agent environment. Paste the prompt there; paths, stack, existing reports and commands are discovered from the project. Fill brackets only for new intent, issue details or unknown criteria. Direct execution is sufficient for small tasks; use `task-orchestrator` for coordination and `project-builder` for substantial project definition/building. These stages are selectable.

Every block is independent. Append this context if useful:

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Scope: the current project/module. Constraints: [time, compatibility, technology, excluded files].
Acceptance: [Given ... When ... Then ... with an observable result].
Respect project instructions and existing changes. Do not print secrets.
Report in Persian: outcome, changed files, executed checks, and actual limitations.
Do not invent test success, coverage, benchmarks, or absence of all bugs.
```

</div>

Repair prompts authorize local edits within their scope. Review/design alone does not authorize repairs. Except for the explicit publication block, these examples do not request commits, pushes, publication, deployment, or operations on real data. Previously given authorization persists; ask only for material ambiguity or work outside scope.

## project-context — Necessary questions and reusable answers

Use when needed information is absent, a decision is ambiguous or previous answers conflict with current conditions. Inputs: current request and open project. Discover existing answers first, then ask only necessary unresolved questions.

<div dir="ltr" align="left">

```text
Use project-context before and during relevant skills in the current project.
Do not ask again about answers available in code, brief, STATE or .ai-work/PROJECT-CONTEXT.md.
Ask concise necessary questions and immediately save replies with ID, source, scope and status in this task's QUESTIONS.md.
Keep reusable decisions in PROJECT-CONTEXT.md; distinguish assumptions from confirmed answers.
Reuse valid answers later; clarify only material conflicts/changes. Wait for blocking replies while continuing independent work.
Resume the original task afterward. Omit secrets; context notes do not grant new external permissions.
Report note paths and unresolved questions.
```

</div>

Output/checks: traceable confirmed answers, open questions, assumptions and continuation of the original work. Use existing conventions or `.ai-work/PROJECT-CONTEXT.md` and `.ai-work/tasks/<task-id>/QUESTIONS.md`. Task-specific answers do not automatically become preferences across projects; never infer secret values or new authorization from memory.

## Quick selection

Task state uses the project's existing convention or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md` plus `JOURNAL.md`. STATE is the current handoff; JOURNAL preserves meaningful actions, decisions, failures and actual results. Reuse the same ID across stages/sessions of the same task. Do not automatically commit/publish these files or store secrets.

To resume after closing a conversation:

<div dir="ltr" align="left">

```text
Target the project open in this environment. Read INDEX, STATE and relevant JOURNAL entries in .ai-work or existing project conventions.
Find the task matching my latest request; ask briefly if multiple plausible tasks make the choice ambiguous.
Reconcile goals, decisions, authorization, checks and next action with current code and diff.
Continue authorized unfinished work; reuse valid completed checks and inspect uncertain mutations before retrying.
Update that task's STATE and JOURNAL after meaningful actions; report the state path at the end.
```

</div>

Recovery depends on accessible files; another environment needs access to them. If writing is forbidden/unavailable, provide a textual handoff without claiming persistence. An open project does not authorize overwriting it; new user decisions or ambiguous publication targets still need clarification.

| Need | Skill or method | Reviewable output |
| --- | --- | --- |
| Multistage task | task-orchestrator | Completed work, one ledger, acceptance checks |
| Define/build project | project-builder | Requirements, scenarios, architecture, implementation, acceptance |
| Documentation | project-docs | Synchronized pages, link/render checks |
| Broad review | enterprise-audit | Findings, path:line, coverage gaps |
| Security | security-audit | Input-to-sink flow, exploitation prerequisites |
| Changes | pr-review | Regressions tied to actual diff |
| Test assessment | test-gap-analysis | Contract-to-assertion mapping and test plan |
| Existing findings | audit-remediation | Finding status and regression checks |
| Repeated repair/review | audit-fix-loop | Cycle count and final review result |
| Unnecessary files | project-cleanup | Dry-run, recovery, checks |
| Version readiness | release-readiness | Blockers and environment-scoped go/no-go |
| Authorized Git/publication | git-release-sync | SHA, refs, CI status, publication URL |
| Small feature/debug/performance | Direct execution or task-orchestrator | Focused change and behavior checks |

## 1. Adaptive task execution

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use task-orchestrator to complete [request] in the relevant scope of the current project. Acceptance: [observable behavior].
Select only relevant available skills. Necessary local edits are authorized.
Keep one shared ledger and report actual results. Ask about material blockers while continuing independent work.
Do not commit or publish.
```

</div>

## 2. Discovery without building

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use project-builder to discover requirements for [topic]; do not implement yet.
Ask concise questions about users, roles, problem, journeys, constraints, and exclusions.
Create a brief with confirmed requirements, assumptions, open decisions, MVP, and acceptance criteria.
Reuse previous answers; do not present unresolved decisions as settled.
```

</div>

## 3. Design without implementation

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use project-builder to design [topic/brief]; do not implement yet.
Specify relevant main/error/recovery flows, roles, data model, API contracts, and UI states.
Propose the smallest suitable architecture; separate proposals/tradeoffs from code facts.
Provide editable diagrams and Given/When/Then for sensitive journeys. Documentation: fa/en.
```

</div>

## 4. Build a new project

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use project-builder to define, implement, and verify [topic] in the current workspace, preserving existing applications.
Users/constraints: [details]. Resolve important ambiguities and prepare a reviewable scenario first.
Start with a real runnable slice and complete agreed scope; preserve existing files.
Map requirements to acceptance tests and provide setup/start instructions and fa/en documentation.
Label blocked integrations and stubs. Do not deploy or create paid resources.
```

</div>

## 5. Continue unfinished work

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use task-orchestrator to complete [scenario] in the current project.
Compare relevant code, TODOs, and tests with expected behavior; distinguish existing/incomplete/blocked work.
Implement and verify missing parts of that scenario; do not add future features automatically.
Acceptance: [criteria]. Synchronize affected documentation and report unfinished work.
```

</div>

## 6. Add an existing-project feature

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Implement [feature] in the relevant module; inspect existing behavior and conventions first.
Acceptance: [positive/negative scenarios]. Identify public contracts and necessary migrations.
Make focused changes with appropriate validation/error handling and run relevant behavior tests.
Update consumer documentation. Do not commit or publish.
```

</div>

## 7. Fix a reproducible bug

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Fix [bug] in the relevant scope of the current project. Reproduction: [steps/dummy data].
Expected: [result]. Actual: [behavior/redacted error].
Trace the cause to code, apply a minimal fix, and run a regression test failing before and passing after.
If reproduction is blocked, separate hypotheses and needed evidence; do not invent a definite cause.
```

</div>

## 8. Fix build or CI failure

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Investigate and repair [command/job] using the relevant available redacted log (request it only if absent).
Establish runtime versions, lockfile/config, and local/CI differences from evidence.
Fix the cause; do not disable tests or security controls just to make CI green.
Rerun the failed command and affected checks; do not claim unexecuted remote CI passed.
```

</div>

## 9. Preserve behavior while refactoring

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Perform a focused refactor in the relevant module for [specific goal].
Record and preserve observable inputs/outputs, side effects, ordering, and errors.
Avoid whole-project rewrites or unnecessary dependencies; inspect consumers.
Run relevant contract tests and report compatibility only within verified scope.
```

</div>

## 10. Improve performance

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Investigate slowness in [scenario/scope] and fix the confirmed bottleneck.
Define benchmark data, workload, and environment; measure a real baseline.
Inspect relevant consumers, queries, allocations, or I/O and make focused improvements.
Compare before/after with identical workloads and verify correctness; do not invent measurements.
```

</div>

## 11. Concurrency and repeat execution

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Investigate [duplicate request/race/cancellation] in [operation] and fix proven defects.
Trace state ownership, transactions, locks, idempotency keys, and side-effect ordering.
Implement/run suitable deterministic tests for concurrent runs, retries, and partial failure.
Explain throughput/error-contract effects; random sleeps are insufficient evidence.
```

</div>

## 12. Schema or API changes

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Implement and verify [schema/API change] locally in the relevant scope of the current project.
Inspect consumers, old data, version compatibility, backfill, and migrations.
Test upgrade/recovery in a temporary environment with dummy data; do not operate on real data.
Document rollback limitations and recovery for irreversible changes.
```

</div>

## 13. UI, RTL, and accessibility

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Fix [issue] on [page/path] while preserving existing UI conventions.
Check relevant loading/empty/error/success states and viewport sizes.
For Persian, verify direction/alignment, mixed text, keyboard navigation, labels, and focus.
Run the scenario in an available browser; distinguish source inspection from visual verification.
```

</div>

## 14. Documentation, local Wiki, diagrams

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use project-docs to synchronize [topics] in the relevant scope of the current project with current code.
New topics: fa/en plus [optional languages]. Update all existing translations of affected topics.
Ground relevant setup/config/API/architecture/troubleshooting in source evidence.
Check direction/alignment, LTR code, links, and available rendering; without a checkout keep Wiki work local.
```

</div>

## 15. Read-only enterprise audit

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use enterprise-audit and core/enterprise-audit.md to audit the relevant scope of the current project; do not edit code.
Discover goals/stack; inspect relevant correctness, concurrency, performance, security, reliability, architecture.
Separate proven defects, conditional risks, and hypotheses.
Provide severity, path:line, trigger, impact, verification test, and coverage limitations.
```

</div>

## 16. Read-only security audit

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use security-audit to review [API/auth/storage paths] only.
Trace controlled input to sinks; check ownership, tenants, permissions, secrets, and logging.
Reproduce only locally with dummy data. Provide prerequisites, impact, path:line, verification tests.
Do not guess CVE/CWE; distinguish environment-dependent risks from proven vulnerabilities.
```

</div>

## 17. PR or diff review

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use pr-review on [branch against merge-base with actual base / unstaged diff].
Report only introduced/worsened regressions with triggers and path:line.
Inspect consumers/tests; disclose unavailable base rather than fabricating one.
Do not edit code or publish external comments; report limitations even when no findings remain.
```

</div>

## 18. Test-gap assessment

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use test-gap-analysis to map the relevant scope of the current project contracts to existing assertions; do not add tests.
For important gaps provide setup, expected result, code location, and priority.
Include relevant error/boundary/partial-failure paths; test file count is insufficient.
Report coverage only when a measurement tool was run.
```

</div>

## 19. Implement important tests

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Revalidate the relevant existing test-gap report against current code and implement [priorities/IDs].
Use existing framework/fixtures; assert public behavior and real failure modes.
Avoid flaky tests and assertions merely mirroring implementation.
Run new tests and affected suites; do not blame the environment without evidence.
```

</div>

## 20. Repair an existing report

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use audit-remediation to revalidate the relevant existing report and repair confirmed defects.
Record each ID as fixed/disproven/already-fixed/unresolved with evidence.
Apply minimal fixes and regression tests; do not repeat old severity without verification.
Report changed files, actual checks, and blockers. Do not publish.
```

</div>

## 21. Repeated audit and repair

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use audit-fix-loop to audit, repair proven defects, and test the relevant scope of the current project.
Keep one ledger and one loop owner; perform fresh reviews in the same scope after repairs.
Continue until confirmed findings are resolved and one complete pass finds no new actionable defects.
Optional limit: [cycles/time or no additional limit]. Report partial completion if the end condition is unmet.
Report cycles, ID status, checks, and coverage gaps; do not guarantee absence of all bugs.
```

</div>

## 22. Recoverable cleanup

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use project-cleanup in [exact scope]; prepare a reviewable dry-run of unnecessary files.
Record exact paths, Git state, disuse/regeneration evidence, consumers, and recovery.
Clean only proven authorized candidates with reliable recovery; retain unique data and uncertain candidates.
Verify resolved paths/containment before actions; run affected tests and a second dry-run.
Report quarantine location and restoration command. Do not commit or push.
```

</div>

## 23. Readiness without publication

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use release-readiness for [version] on [target environments].
Check required validation, packaging, fresh/repeated installation, upgrade, compatibility, and rollback in temporary destinations.
Provide blockers and go/no-go only for checked environments; pending CI is not passed.
Do not tag, push, publish, or deploy. List untested environments.
```

</div>

## 24. Local commit

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use git-release-sync to review and locally commit only [task/paths].
Inspect status/diff/checks; do not stage unrelated work, secrets, or quarantine.
Update versions only when project policy and task scope require it.
Do not push, tag, open PRs, or publish Releases. Report SHA and checks.
```

</div>

## 25. Update a checkout

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use git-release-sync to update the current checkout from [actual remote/branch].
Inspect status/divergence and preserve local changes; fetch and fast-forward when possible.
For conflicts/incompatible histories prepare reviewable integration based on behavior; do not reset/force.
Verify version and relevant checks. Do not push or publish Releases.
```

</div>

## 26. Explicit scoped publication

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use git-release-sync to publish [unique version] to [actual remote] on [authorized branch].
This authorizes committing related changes, pushing that branch, a new tag, and a GitHub Release of that commit.
After required checks pass, synchronize version/changelog/docs and verify remote/tag SHA.
Preserve history and branch protection; do not force-push or replace existing tags.
Report Release URL, SHA, assets, and actual CI status. Deployment is excluded.
```

</div>

For a PR instead of a Release, specify the operation, repository, base/head, and draft status. Creating a Release does not deploy it.

## 27. Combined: feature to documentation

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use task-orchestrator to implement [feature] in the relevant scope of the current project and verify [acceptance].
Use project-builder if substantial definition is needed; finish with project-docs for affected documentation.
Use pr-review on the actual diff; repair confirmed regressions and rerun relevant tests.
Give one final report. Do not commit or publish.
```

</div>

## 28. Combined: audit to readiness

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use task-orchestrator for enterprise-audit → audit-fix-loop → project-docs → release-readiness in the relevant scope of the current project.
Local repairs of confirmed defects are authorized; keep one ledger and one repair-loop owner.
Document final behavior. Return newly proven readiness defects to the loop and refresh affected docs/checks.
Report outcome, repair cycles, readiness, and unfinished work. Do not publish.
```

</div>

## 29. skill-evaluation — Evaluate skill behavior

Real behavior assertions with runner identity; distinguish preparation/tool tests from agent execution.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use skill-evaluation to evaluate [skill] on isolated fixtures.
Verify the skill completion criteria; separate executed results from prepared/blocked work.
```

</div>

## 30. bug-investigation — Reproduce and diagnose failures

Minimal reproduction, discriminating experiments and regression evidence; diagnosis alone does not authorize edits.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use bug-investigation to reproduce [failure], test its cause and repair when requested.
Verify the skill completion criteria; separate executed results from prepared/blocked work.
```

</div>

## 31. feature-delivery — Deliver an existing-project feature

Existing contracts, working journey and acceptance-to-test results; no deployment.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use feature-delivery to implement [feature] here and verify [acceptance].
Verify the skill completion criteria; separate executed results from prepared/blocked work.
```

</div>

## 32. test-engineering — Implement tests and repair flakiness

Behavior assertions, appropriate fixtures and actual results; never weaken assertions to pass.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use test-engineering to implement tests for [behavior/gap report] and diagnose relevant flaky tests.
Verify the skill completion criteria; separate executed results from prepared/blocked work.
```

</div>

## 33. performance-lab — Measure and optimize performance

Baseline, identical workload, samples and correctness; never invent measurements.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use performance-lab to measure [slow journey] and repair the confirmed bottleneck.
Verify the skill completion criteria; separate executed results from prepared/blocked work.
```

</div>

## 34. migration-upgrade — Upgrade and migrate compatibly

Install/upgrade/repeated execution/recovery with dummy data; no live data mutation.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use migration-upgrade to implement and verify [dependency/schema/API target] locally.
Verify the skill completion criteria; separate executed results from prepared/blocked work.
```

</div>

## 35. ui-accessibility — UI, RTL and accessibility

Browser journeys and error states; source checks are not visual or full conformance evidence.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use ui-accessibility to fix [page/behavior] and verify relevant RTL, keyboard and responsive flows.
Verify the skill completion criteria; separate executed results from prepared/blocked work.
```

</div>

## 36. operations-readiness — Service operations and recovery

Evidenced health/logging/outage/backup/restore checks; assessment does not authorize deployment.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use operations-readiness to assess this service; report only for now.
Verify the skill completion criteria; separate executed results from prepared/blocked work.
```

</div>

## Review of the Gemini response and improvement proposals

The review uses the [shared conversation](https://share.gemini.google/7FDkCBW0uLkl) and local files. The Gemini ZIP was unavailable; equivalence with this checkout was not verified.

- Gemini says “10 skills” but lists 11; the current checkout contains 21. Counts need a version and source.
- Nested fences break several prompt blocks. This guide gives each prompt one independent block.
- `audit-remediation` verifies and repairs reported defects, rather than only planning. `test-gap-analysis` assesses coverage; test implementation needs a request.
- An audit request demanding replacement code mixes review and repair. This guide separates them and supplies authorized combinations.
- A 1–100 health score, absolute compatibility guarantees, and “production-ready” labels need criteria and actual checks.
- Similar adapter files alone do not prove a defect. The generator and `tests/docs.py` now check all skill/resource parity while preserving adapter copies.
- JSON state/schema, stack profiles and an evaluation harness are implemented; security SARIF and exhaustive real-model evaluations are not claimed. Static Markdown checks do not verify agent behavior.

Versioned state tooling, behavioral fixtures/runner, stack profiles and adapter generation are now implemented. Tool tests and prepared fixtures are not model evaluations. See [tooling and verification](skill-tooling.en.md).

## Assessing an agent result

A result should answer the request within scope, identify changed files/evidence, and separate executed commands/results from test plans. Partial completion should identify blockers and remaining work. Use `ID | severity | evidence-class | path:line | trigger/impact | status | verification` for findings and requirement-to-acceptance-test mapping for builds. No prompt guarantees every project type or absence of every defect.

Local sources: [Coordination](../.agents/skills/task-orchestrator/SKILL.md), [Project building](../.agents/skills/project-builder/SKILL.md), [Documentation](../.agents/skills/project-docs/SKILL.md), [Audit protocol](../core/enterprise-audit.md), [Cleanup](../.agents/skills/project-cleanup/SKILL.md), [Git/publication](../.agents/skills/git-release-sync/SKILL.md), [Documentation checks](../tests/docs.py).

</div>
