<div lang="en" dir="ltr" align="left">

# Combined workflows in project order

[فارسی](combinations.md) · [Individual skills](skills.en.md)

Select relevant stages; workflows run sequentially and do not imply delegation or publication. Share scope, permissions, language/file mapping, findings, changed paths, recovery notes and actual checks. Revalidate evidence after changes. Keep one repair-loop owner and one final report.

## Define and build a new project

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use task-orchestrator to coordinate project-builder → project-docs for [topic/path].
Clarify requirements, implement the agreed scope and verify acceptance criteria.
New documentation: fa/en; additional languages: [optional locales]. Apply direction
and alignment by language and synchronize existing translations. Do not deploy.
```

</div>

Expected: runnable agreed scope, requirement-to-test status and synchronized documentation. Add readiness only when packaging assessment is requested.

## Maintain documentation in an existing project

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use project-docs on [topics]. Update every existing language variant from current
source. New topics default to fa/en plus [optional locales]. Check links, semantic
parity and available RTL/LTR rendering; report unsupported renderer behavior.
Prepare local Wiki pages only. Do not publish or commit.
```

</div>

Expected: locale mapping, affected pages and actual source/rendering checks.

## Review changes and test gaps

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use pr-review → test-gap-analysis for [head/base/subsystem]. Keep code unchanged.
Separate regressions from missing assertions; share check results unless source
changes invalidate them. Do not publish comments.
```

</div>

Expected: one evidence-based review and prioritized test scenarios.

## Broad or security audit and repairs

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use enterprise-audit (or security-audit for [sensitive scope]) → audit-remediation.
First establish evidence, then repair confirmed defects and run regression checks.
Use audit-fix-loop only if repeated fresh review is requested. Keep one ledger and
report unresolved findings. Do not publish.
```

</div>

Expected: finding status linked to changes and actual tests; review alone remains read-only.

## Cleanup and local Git maintenance

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use project-cleanup → project-docs for the relevant scope of the current project. Prepare dry-run evidence, execute
only authorized cleanup and preserve recovery. Update affected existing translations
and check links/build/tests. Use git-release-sync only if local commit is explicitly
requested; exclude quarantine and unrelated changes. Do not push, PR, tag or release.
```

</div>

Expected: approved path ledger, recovery procedure, verified documentation and optional local commit.

## Repair, document and assess a release

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use audit-fix-loop → project-docs → release-readiness on [report/version]. Document
final behavior in all existing languages; new topics default to fa/en plus [locales].
If readiness identifies a proven defect, return it to the same repair loop and
refresh affected docs/checks. Do not publish, push or deploy.
```

</div>

Expected: final finding state, multilingual docs and readiness for tested environments.

## Authorized external publication

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use task-orchestrator for [task]. After authorized repairs, documentation and required
checks, use release-readiness → git-release-sync to push [exact remote/branch] and
publish Release [version]. This request authorizes those exact external operations.
Preserve history and verify remote SHA, tag target, Release URL/assets and CI status.
```

</div>

Use this template only when publication is intended. Release publication does not authorize deployment. Notes follow the requested language set; existing translations are synchronized.

## Custom scope and limits

<div dir="ltr" align="left">

```text
Target the project open in this environment; discover its root, instructions, stack, relevant files/report and checks.
Before work, restore the matching task from existing conventions or .ai-work/INDEX.md and .ai-work/tasks/<task-id>/STATE.md.
Persist decisions, meaningful actions, changed files, actual checks and next action in that task's STATE.md and JOURNAL.md.
On resumption reconcile notes with current code; omit secrets. If writes are forbidden/unavailable, provide a textual handoff.
Use [skills] in [order] for the relevant scope of the current project. Allowed changes: [code/tests/docs/report only].
Document languages: [default fa/en plus optional locales]. Acceptance: [checks].
Limits: [user budget/cycles if any]. If the stopping condition is unmet, report
incomplete work; do not manufacture success. External operations: [explicit scope].
```

</div>

</div>
