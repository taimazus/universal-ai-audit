<div lang="en" dir="ltr" align="left">

<p align="center"><img src="banner.jpg" alt="Universal AI Enterprise Audit Pack" width="100%"></p>

# Universal AI Enterprise Audit Pack

Version: **1.5.0**. [راهنمای فارسی](docs/README.md) · [مثال همهٔ skillها](docs/skills.md) · [حالت‌های ترکیبی](docs/combinations.md) · [نصب و rollback](docs/installation.md) · [تغییرات](CHANGELOG.md)

A portable, evidence-first code-audit instruction pack for heterogeneous repositories and multiple coding agents.

Version 1.5.0 includes the eleventh skill, `project-builder`, and installer fixes. The older `v1.4.0` tag does not contain these additions. See [CHANGELOG](CHANGELOG.md), the [Persian architecture and sequence diagrams](docs/architecture.md), and the [local Wiki draft](docs/wiki/Home.md). A version in source does not imply a hosted Release.

## Install

Download **Code → Download ZIP**, or run `git clone https://github.com/taimazus/universal-ai-audit.git` and enter the checkout. See the [download and Git update guide (Persian)](docs/installation.md) for complete Windows/Bash commands. To update a clean `main` checkout, run `git pull --ff-only origin main`, then rerun the installer with `-Force` / `--force`; pulling alone does not update installed skills.
Windows/PowerShell: `./install.ps1 -DryRun` then `./install.ps1`.
Linux/macOS/WSL: `bash ./install.sh --dry-run` then `bash ./install.sh`.
Use project-only/global-only and agent selection flags shown by `--help` (shell) or `Get-Help ./install.ps1`.

## Supported adapters
- Generic / AGENTS.md-compatible agents
- OpenAI/Codex skill + AGENTS.md
- Claude-compatible CLAUDE.md
- Cursor `.cursor/rules/*.mdc`
- GitHub Copilot `.github/instructions/*.instructions.md` and user-level Copilot CLI instructions
- Gemini-compatible GEMINI.md
- Antigravity IDE/2.0 and CLI native skills
- OpenCode native project and user skills
- Windsurf/Cascade, Cline and Roo Code native skills

## Use

[Skill tools and verification](docs/skill-tooling.en.md) · [Implementation review](docs/skill-suite-review.en.md)

Skills target the project already open in the workspace and discover available context. They checkpoint decisions, actions, checks and next steps in existing task notes or `.ai-work/`, restoring and revalidating them when work resumes. Reinstall updated skills to apply these instructions to existing installations.

See the [36 copyable lifecycle prompts](docs/prompt-library.en.md) or [Persian prompt library](docs/prompt-library.fa.md) for building, development, debugging, reviews, tests and authorized release workflows.
Ask the agent for `/audit-deep`, `/audit-goal`, `enterprise audit`, `deep code audit`, or `ممیزی جامع پروژه`. Agents do not universally implement slash commands; these are semantic triggers, not guaranteed UI commands.

## Engineering skills

Twenty focused skills supplement `enterprise-audit` in `.agents/skills/`, with Persian reports by default:

The catalog below follows typical project use; select only relevant stages. Documentation skills create new topics in Persian and English by default, accept additional language names/locale codes, and update every existing translation of an affected topic. Apply RTL/right or LTR/left layout by language, keeping commands/code LTR. See the [English skill guide](docs/skills.en.md) and [combined workflows](docs/combinations.en.md).

| Skill | Purpose |
| --- | --- |
| `project-context` | Ask necessary missing questions, persist confirmed answers, and reuse valid project decisions across runs. |
| `task-orchestrator` | Select relevant available skills, complete the requested task, and verify acceptance criteria with concise evidence. |
| `project-builder` | Turn a topic into interactive requirements, scenarios, architecture, implementation and acceptance checks. |
| `project-docs` | Create and synchronize Markdown documentation, local Wiki pages, and editable diagrams from source evidence. |
| `security-audit` | Trace untrusted input, access control, secrets, and sensitive data flows. |
| `pr-review` | Review changes for actionable regressions with exact source evidence. |
| `test-gap-analysis` | Map important contracts and failure paths to existing test assertions. |
| `audit-remediation` | Verify audit findings, fix confirmed bugs, and run regression tests. |
| `audit-fix-loop` | Repeat evidence-based repairs, regression checks, and review until confirmed findings are resolved and the final pass finds no new actionable defects. |
| `project-cleanup` | Perform verified project cleanup with a reviewable dry-run, recovery and regression checks. |
| `release-readiness` | Check installation, versions, upgrades, packaging, and rollback. |
| `skill-evaluation` | Evaluate skill behavior with isolated scenarios, observable assertions and honest measured outcomes; distinguish real agent evaluations from deterministic tool tests. |
| `bug-investigation` | Reproduce ambiguous failures, test root-cause hypotheses and repair requested bugs with regression evidence; use for runtime/build failures rather than a preexisting audit report. |
| `feature-delivery` | Implement a bounded feature in an existing project through contracts, local changes and acceptance verification; use project-builder for a new project or substantial project definition. |
| `test-engineering` | Implement meaningful tests from important behavior contracts, repair flaky tests and verify regressions; use test-gap-analysis for assessment without implementation. |
| `performance-lab` | Profile and benchmark a specific workload, repair proven bottlenecks and verify correctness and measured improvement; avoid unmeasured optimization claims. |
| `migration-upgrade` | Implement and verify dependency, framework, schema or API upgrades with compatibility checks and recovery; separate local migrations from live data operations. |
| `ui-accessibility` | Inspect and repair requested UI journeys, responsive behavior, RTL and accessibility with browser evidence; distinguish source inspection from actual user interaction. |
| `operations-readiness` | Assess and implement requested health, observability, backup and recovery for a running-service design; use release-readiness for package/install readiness and do not infer deployment permission. |
| `git-release-sync` | Perform authorized Git/version/tag/Release synchronization while preserving history and verifying publication. |

Installers include all twenty supplementary skills by default. Use `-Skills none` / `--skills none` for the original audit-only pack, or choose individual skills:

```powershell
./install.ps1 -ProjectOnly -Agents codex -Skills pr-review,security-audit -DryRun
./install.ps1 -ProjectOnly -Agents codex -Skills pr-review,security-audit
```

```bash
bash ./install.sh --project-only --agents codex --skills pr-review,security-audit --dry-run
bash ./install.sh --project-only --agents codex --skills pr-review,security-audit
```

Native project/global skill locations are supported for Codex, Claude Code, Cursor, Antigravity, Gemini CLI, GitHub Copilot, OpenCode, Windsurf/Cascade, Cline, and Roo Code. Generic writes the shared Agent Skills location. Global installs use individual SKILL.md folders instead of injecting all skill bodies into always-loaded instructions. See the [Persian global installation guide](docs/global-installation.md) for the current path matrix, migration steps, and official references.

```powershell
./install.ps1 -GlobalOnly -Agents all -Skills all -WhatIf
./install.ps1 -GlobalOnly -Agents all -Skills all
```

```bash
bash ./install.sh --global-only --agents all --skills all --dry-run
bash ./install.sh --global-only --agents all --skills all
```

`-UserHome PATH` / `--home PATH` redirects installer output to an isolated fixture; it does not reconfigure an agent. Existing legacy global files remain untouched; review old copies and instruction blocks before removing duplicates. Local user installation does not automatically sync to cloud or remote sessions.

Invoke by name, for example `Use audit-remediation to fix these findings` or `$pr-review` in a skill-aware agent. Review and assessment skills stay read-only unless changes are requested. No skill implicitly authorizes publishing, deployment, or external messages. Product-specific discovery conventions may differ; inspect the installed files in your target agent.

For a documentation refresh, ask: `Use project-docs to create or update this project's Markdown files, Wiki pages, and architecture diagrams from the current source.` The skill preserves documentation conventions and editable diagram sources, verifies available documentation tooling, and reports gaps. Wiki content is prepared locally when a Wiki checkout is unavailable; remote publishing is a separate action.

Install only this additional skill with `./install.ps1 -ProjectOnly -Skills project-docs` or `bash ./install.sh --project-only --skills project-docs`. Agent selection flags still apply.

## Safety / integrity

For a new project, ask `Use project-builder to turn this topic into a detailed scenario, ask me the essential questions, then build and test the agreed scope.` For design only, explicitly request no implementation. See the [Persian guide with dialogue and acceptance examples](docs/project-builder.md). This workflow reuses relevant available skills and does not promise flawless software.

For repeated repair and review, ask: `Use audit-fix-loop to fix all reported findings, run verification, and review the whole repository again until the final review pass finds no new actionable defects.` The skill tracks original and new findings across cycles and reports the final evidence. A persistent blocker or explicit user limit produces a partial-completion report, never a false clean result. Install it individually with `-Skills audit-fix-loop` or `--skills audit-fix-loop`.
The protocol requires evidence classes, exact source locations when available, no fabricated vulnerabilities/benchmarks, and explicit coverage gaps.

## Distribution
For installation results, temporary checkout/bootstrap cleanup, backups, and GitHub CLI login examples, see the [Persian post-installation guide](docs/post-installation.md). Keep installed skill directories; temporary source checkouts are separate from installation destinations.

Review the generated files before committing them. Existing instruction files are preserved/append-only where appropriate; generated dedicated rule files require `--force` / `-Force` to replace. Backups are created when replacement occurs.

Project installs place the protocol at `core/enterprise-audit.md`, matching the instruction files. Previous `.ai-audit/core` copies are left in place. Backups use unique names so repeated replacements preserve earlier versions. PowerShell supports both `-DryRun` and `-WhatIf` without changing files.

## Installer regression tests
Run `bash tests/install.sh` on Bash, or `powershell.exe -NoProfile -ExecutionPolicy Bypass -File tests/install.ps1` on Windows. Tests use isolated temporary directories and retain fixtures for inspection.

[فارسی](README.fa.md) · [GitHub](https://github.com/taimazus/universal-ai-audit) · [CI](https://github.com/taimazus/universal-ai-audit/actions)

</div>
