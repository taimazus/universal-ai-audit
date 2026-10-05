<div lang="en" dir="ltr" align="left">

# Skill implementation and review — 2026-10-05

[فارسی](skill-suite-review.fa.md) · [Tooling](skill-tooling.en.md) · [36 scenarios](prompt-library.en.md)

Scope: current working tree, 21 skills/resources, canonical contracts/generated adapters, PowerShell/Bash installers, Git bootstraps, tests, CI and affected documentation. Existing user edits and staging were preserved. No commit, push, Release or actual global installation was performed. VERSION remains unchanged; new capabilities appear under Unreleased in the changelog.

Implementation includes eight new specialists, skill completion criteria, transactional state/versioned schema, answers with provenance/scope/conditions/fingerprints, canonical adapter generation, four stack profiles, resource installation, evaluation fixtures/runner and CI checks. Tool execution is distinguished from real-agent execution.

## Resolved findings

All items are `Proven defect`. Locations refer to current fixes; issues were verified or reproduced in intermediate versions of this work. Hypothetical risks were not counted as proven defects.

| ID | Severity | Trigger/impact | Fix location | Verification |
| --- | --- | --- | --- | --- |
| U1 | MEDIUM | Invalid saved payload could be returned as valid state without validation. | `project-context/scripts/task_state.py:195` | `test_invalid_saved_payload_is_not_reused` |
| U2 | LOW | Invalid lookup-condition structure returned stale instead of an input error. | `project-context/scripts/task_state.py:249` | `test_invalid_conditions_rejected` |
| U3 | MEDIUM | Preserving one file plus product_changed=false missed unauthorized new product files during review. | `skill-evaluation/scripts/evaluate.py:47` | `test_readonly_case_catches_unreported_new_product_file` |
| U4 | MEDIUM | init could adopt an unrecognized SQLite database by adding this tool's metadata. | `project-context/scripts/task_state.py:146` | `test_init_does_not_adopt_unrecognized_existing_database` |
| U5 | MEDIUM | Linked output parents could redirect generation outside the intended destination. | `tools/generate_adapters.py:21` | `test_linked_output_parent_cannot_escape_repository` |
| U6 | LOW | Portable audit profile was not distributed at the referenced path. | `install.ps1:101` and Bash `core/references` distribution | Portable profile hash checks in both installer suites |
| U7 | MEDIUM | Persian state show failed on ASCII/legacy Windows output with UnicodeEncodeError; exit=1 reproduced before fixing. | `project-context/scripts/task_state.py:307` | `test_unicode_state_can_be_read_on_ascii_console` |
| U8 | LOW | Bash installation stripped the terminal CR from CRLF resources, causing hash mismatch. | `install.sh:97`, verbatim resource mode | CRLF/no-final-newline and repeat-install checks |
| U9 | MEDIUM | Completion validation also rejected valid read-only completion with open reported findings. | mode/checks.required in validator/schema | `test_review_completion_preserves_open_findings_and_optional_blocked_checks`; 72 schema/runtime combinations |
| U10 | LOW | Invalid UTF-8 JSON input produced a traceback instead of a controlled input error. | `project-context/scripts/task_state.py:309` | `test_invalid_input_encoding_fails_cleanly_without_mutation` |

Skill script paths above are relative to `.agents/skills/`. Tests: [test_task_state.py](../tests/test_task_state.py), [test_evaluation.py](../tests/test_evaluation.py), [test_adapters.py](../tests/test_adapters.py).

## Checks

| Check | Result |
| --- | --- |
| Python unittest | 33 passed: processes/concurrency/rollback, answers, scope and oracle |
| JSON Schema | Valid Draft 2020-12; 72 mode/check/finding combinations agree with runtime |
| Generator parity | Passed for all skill/resource adapters |
| Documentation | Passed: catalogs, installer choices, languages, resources, links and fences |
| quick_validate | 42 valid skill files; local official validator with isolated temporary dependency |
| PowerShell installer | Full suite passed, including resource parity and installed helper execution |
| Bash installer | Full Git Bash suite passed, including CRLF/no-final-newline preservation and repeat installation |
| Agent-evaluation preparation | 7 fixtures marked prepared; no real model executed |

Three review stages: implementation/contracts; failure/recovery tests and tool repairs; scope/resources/portability review and final checks. Intentional STALE/linked-path errors in negative tests are expected assertions, not suite failures. Final checks passed; no additional actionable defect was found within the reviewed scope.

## Risks and coverage limits

- Tool tests/prepared fixtures do not prove behavior of all models or actual product discovery. No real-agent runner is configured; all 21 skills do not have executed model scenarios.
- Hosted CI and native Linux/macOS were not executed here. Bash is checked with Git Bash on Windows; the CI matrix is defined.
- Visual Markdown/Mermaid rendering, screen readers and real UI integrations were not verified. Source, links and structure were checked.
- Two historical risks from the [previous report](audit-report.md) remain separate: no whole-install transaction and no independent Git-bootstrap integration coverage. No new actual failure was reproduced for them; they remain risks/test gaps.
- SQLite preserves transactional records/revisions; it cannot independently prove a human reply, absence of all secrets or truthful test claims. Notes do not authorize new operations and recovery requires accessible files.

Current assessment: confirmed defects were fixed; final check results and the above limits govern the conclusion. This does not guarantee absence of every possible defect.

</div>
