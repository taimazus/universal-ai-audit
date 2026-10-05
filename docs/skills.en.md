<div lang="en" dir="ltr" align="left">

# Skills in a typical project workflow

[فارسی](skills.md) · [Combined workflows](combinations.en.md)

Select only stages relevant to the request. This order is a reading guide, not a mandatory pipeline. The open project is the default target; discover its paths, stack and existing reports. Brackets supply new intent or unknown criteria. Persist and restore task state using existing conventions or .ai-work. Reports default to Persian unless another language is requested. New documentation defaults to Persian and English; provide additional languages as names or locale codes. Updates synchronize existing language variants. External publication requires explicit authorization.

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

## task-orchestrator — Coordinate work

Use for a task requiring several relevant skills. Inputs: outcome, scope, acceptance checks and permissions.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use task-orchestrator to complete [task] in the relevant subsystem.
Acceptance: [observable behavior and checks]. Select only relevant skills.
Complete authorized changes and verification; separate assumptions from measured results.
Do not publish externally. Report the outcome, evidence and remaining gaps in English.
```

</div>

Output/checks: one shared ledger, completed changes and actual acceptance results. Coordination does not authorize unrelated stages or delegation.

## project-builder — Define and build a project

Use for a new project or substantial requirements work. Inputs: topic, destination, users, constraints and design/build mode.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use project-builder to build [topic] in the current workspace. Clarify essential roles,
journeys and constraints; record requirements, architecture and acceptance scenarios.
Implement the agreed scope and run acceptance checks. Create documentation in fa/en;
additional languages: [optional locale codes]. Do not deploy or publish.
```

</div>

Output/checks: requirements mapped to tests, runnable implementation and documented gaps. For planning only, explicitly request no implementation.

## feature-delivery — Deliver an existing-project feature

Existing contracts, working journey and acceptance-to-test results; no deployment.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use feature-delivery to implement [feature] here and verify [acceptance].
Report evidence, actual results and gaps; do not commit or publish.
```

</div>

[feature-delivery](../.agents/skills/feature-delivery/SKILL.md)

## project-docs — Documentation, Wiki and diagrams

Use to create or synchronize documentation from source. Inputs: topics/paths, existing locales and optional extra languages.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use project-docs for README, setup, architecture, local Wiki and editable diagrams.
Create new topics in Persian and English; additional languages: [optional locales].
Synchronize every existing language variant of affected topics. Apply RTL/right
and LTR/left layout by language, with code and commands LTR. Check semantic parity,
links and available rendering/build tools. Keep Wiki drafts local; do not publish.
```

</div>

Output/checks: locale-to-file mapping, synchronized source-grounded pages, link/build results and rendering limits. Chat report language and document language set are separate inputs.

## enterprise-audit — Broad audit

Use for evidence-based whole-repository review. Inputs: root, goals and review scope.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use enterprise-audit to review [repository] without edits. Infer goals and stack;
audit correctness, concurrency, performance, security, reliability and architecture.
Give severity, evidence class, exact path:line, failure trigger and verification
for each finding. Separate proven defects, conditional risks and hypotheses.
```

</div>

Output/checks: prioritized findings and coverage gaps. A review request does not authorize repairs.

## security-audit — Focused security review

Use for untrusted inputs, authorization, secrets and sensitive flows. Inputs: subsystem and threat boundaries.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use security-audit on [API/auth paths]. Trace input through ownership/tenant
checks to sensitive sinks. Reproduce only locally with dummy data. Do not expose
secret values, edit code or contact external systems. Give prerequisites and tests.
```

</div>

Output/checks: evidence-backed security findings and local reproduction limits.

## pr-review — Review a change

Use for regressions in a real diff. Inputs: base/head or unstaged/staged scope.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use pr-review to compare [branch] with its merge-base against [base]. Report only
introduced or worsened actionable regressions, with trigger and path:line.
Run relevant available checks; do not edit code or publish review comments.
```

</div>

Output/checks: change-specific findings. Without Git provide real before/after artifacts; do not invent a base.

## bug-investigation — Reproduce and diagnose failures

Minimal reproduction, discriminating experiments and regression evidence; diagnosis alone does not authorize edits.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use bug-investigation to reproduce [failure], test its cause and repair when requested.
Report evidence, actual results and gaps; do not commit or publish.
```

</div>

[bug-investigation](../.agents/skills/bug-investigation/SKILL.md)

## test-gap-analysis — Assess test coverage

Use to map important contracts to assertions. Inputs: subsystem, tests and failure scenarios.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use test-gap-analysis on [subsystem]. Map important contracts to existing assertions;
prioritize boundaries, retries, partial failures and cancellation where relevant.
Do not add tests yet. Give setup and expected results for each gap; report coverage
percentages only if a measurement tool actually ran.
```

</div>

Output/checks: evidence-based test plan and measured results, not an automatic test implementation.

## test-engineering — Implement tests and repair flakiness

Behavior assertions, appropriate fixtures and actual results; never weaken assertions to pass.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use test-engineering to implement tests for [behavior/gap report] and diagnose relevant flaky tests.
Report evidence, actual results and gaps; do not commit or publish.
```

</div>

[test-engineering](../.agents/skills/test-engineering/SKILL.md)

## audit-remediation — Repair confirmed findings

Use when an audit report already exists. Inputs: report, affected scope and permitted edits.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use audit-remediation to revalidate [report] against current source. Fix confirmed
defects with focused regression checks. Record fixed/disproven/already-fixed/unresolved
status, changed locations and actual results. Do not publish or deploy.
```

</div>

Output/checks: verified repairs with a finding-to-test mapping; stale findings are not proof of current defects.

## audit-fix-loop — Repeat repairs and fresh review

Use for an explicitly requested repair/review loop. Inputs: report, final review scope and any limits.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use audit-fix-loop on [report]. Repair confirmed findings, run regression checks and
freshly review the relevant scope of the current project. Keep original and new findings in one ledger. Continue until
confirmed findings are resolved and a complete pass finds no new actionable defects.
Report blockers and incomplete work honestly; do not publish.
```

</div>

Output/checks: cycle count, final finding state and actual checks. One skill owns the loop; no guarantee of all possible defects being absent.

## performance-lab — Measure and optimize performance

Baseline, identical workload, samples and correctness; never invent measurements.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use performance-lab to measure [slow journey] and repair the confirmed bottleneck.
Report evidence, actual results and gaps; do not commit or publish.
```

</div>

[performance-lab](../.agents/skills/performance-lab/SKILL.md)

## migration-upgrade — Upgrade and migrate compatibly

Install/upgrade/repeated execution/recovery with dummy data; no live data mutation.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use migration-upgrade to implement and verify [dependency/schema/API target] locally.
Report evidence, actual results and gaps; do not commit or publish.
```

</div>

[migration-upgrade](../.agents/skills/migration-upgrade/SKILL.md)

## ui-accessibility — UI, RTL and accessibility

Browser journeys and error states; source checks are not visual or full conformance evidence.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use ui-accessibility to fix [page/behavior] and verify relevant RTL, keyboard and responsive flows.
Report evidence, actual results and gaps; do not commit or publish.
```

</div>

[ui-accessibility](../.agents/skills/ui-accessibility/SKILL.md)

## operations-readiness — Service operations and recovery

Evidenced health/logging/outage/backup/restore checks; assessment does not authorize deployment.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use operations-readiness to assess this service; report only for now.
Report evidence, actual results and gaps; do not commit or publish.
```

</div>

[operations-readiness](../.agents/skills/operations-readiness/SKILL.md)

## project-cleanup — Verified cleanup

Use for unnecessary project artifacts. Inputs: exact scope and removal authorization.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use project-cleanup on the current project. Prepare a dry-run with exact candidates, Git state,
evidence, dependencies and recovery methods. Execute only verified authorized actions.
Do not treat ignored files or backups as disposable without evidence. Run affected
checks and distinguish proposals from executed changes. Do not commit or publish.
```

</div>

Output/checks: candidate ledger, recoverable changes, checks and pending uncertain paths. Skill creation or installation does not authorize cleanup.

## release-readiness — Assess readiness

Use before a release for packaging/install/upgrade/rollback assessment. Inputs: version and target environments.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use release-readiness for [version]. Check build, tests, package identity, fresh and
repeated installation, upgrade and rollback in isolated destinations. Give go/no-go
only for verified environments. Do not push, tag, publish or deploy.
```

</div>

Output/checks: evidence-based blockers and tested/untested environments. Assessment does not authorize publication.

## git-release-sync — Git and GitHub updates

Use for explicitly requested checkout, commit, push, PR or Release operations. Inputs: exact operations, remote, branch and version where relevant.

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use git-release-sync to inspect and commit only [task changes] locally after required
checks. Preserve unrelated work and history. Synchronize affected existing document
languages; create new documentation in fa/en plus [optional locales]. Do not push,
open a PR, tag or publish a Release. Report SHA and actual check results.
```

</div>

For an authorized checkout update, specify remote/upstream and preserve dirty work. For a PR, specify base/head and whether to create or update it. For publication, explicitly authorize exact refs and Release operations. Output/checks: commit/ref identity, remote SHA and PR/Release state only when those operations ran; pending CI stays pending.

## skill-evaluation — Evaluate skill behavior

Real behavior assertions with runner identity; distinguish preparation/tool tests from agent execution.

<div dir="ltr" align="left">

```text
Target the open project; restore context/valid answers and ask/record only necessary unresolved questions.
Persist state, decisions, changes, checks and next action; omit secrets.
Use skill-evaluation to evaluate [skill] on isolated fixtures.
Report evidence, actual results and gaps; do not commit or publish.
```

</div>

[skill-evaluation](../.agents/skills/skill-evaluation/SKILL.md)

</div>
