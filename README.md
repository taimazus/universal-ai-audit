<p align="center">
  <img src="banner.jpg" alt="Universal AI Enterprise Audit Pack — One Audit. Any AI Agent, Any Repository." width="100%">
</p>

# Universal AI Enterprise Audit Pack

<p align="center">
  <strong>One Audit. Any AI Agent, Any Repository.</strong><br>
  Evidence-first code, architecture, security, performance and quality audits for modern AI coding agents.
</p>

<p align="center">
  <a href="https://github.com/taimazus/universal-ai-audit/releases"><img src="https://img.shields.io/github/v/release/taimazus/universal-ai-audit?display_name=tag" alt="Release"></a>
  <a href="https://github.com/taimazus/universal-ai-audit/actions/workflows/ci.yml"><img src="https://github.com/taimazus/universal-ai-audit/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/taimazus/universal-ai-audit" alt="License"></a>
  <a href="https://github.com/taimazus/universal-ai-audit/stargazers"><img src="https://img.shields.io/github/stars/taimazus/universal-ai-audit?style=flat" alt="GitHub stars"></a>
</p>

<p align="center"><strong>Version 1.1.0</strong> · <strong>English</strong> | <a href="README.fa.md">فارسی</a></p>

A portable, open-source, evidence-first enterprise code-audit instruction pack for heterogeneous repositories and multiple AI coding agents.

**Created and maintained by [Taimazus](https://github.com/taimazus).**

## Why this project?

Install the audit protocol once and reuse it across projects. It is designed to make AI-assisted audits more systematic: architecture, correctness, security, performance, concurrency, resource management, testing, maintainability, and goal alignment are reviewed with an emphasis on evidence and explicit coverage gaps.

## Supported adapters

| Agent / convention | Integration |
| --- | --- |
| OpenAI / Codex | Skill + `AGENTS.md` |
| Claude-compatible agents | `CLAUDE.md` |
| Cursor | `.cursor/rules/*.mdc` |
| GitHub Copilot | `.github/instructions/*.instructions.md` |
| Gemini-compatible agents | `GEMINI.md` |
| Google Antigravity | Workspace + IDE/CLI global skills |
| Generic agents | `AGENTS.md` |

## Quick start — Windows

```powershell
git clone https://github.com/taimazus/universal-ai-audit.git
cd universal-ai-audit
Unblock-File -LiteralPath .\install.ps1
.\install.ps1 -DryRun
.\install.ps1
```

If an organizational `AllSigned`/Group Policy applies, follow your organization's signing policy rather than permanently weakening ExecutionPolicy.

## Quick start — Linux / macOS / WSL

```bash
git clone https://github.com/taimazus/universal-ai-audit.git
cd universal-ai-audit
chmod +x ./install.sh
./install.sh --dry-run
./install.sh
```

## Run an audit

Open the repository in your AI coding agent and request an enterprise audit. For Antigravity, the installed skill can be invoked with:

```text
/enterprise-audit
```

For other agents, requests such as `enterprise audit`, `deep code audit`, `/audit-deep`, `/audit-goal`, or `ممیزی جامع پروژه` can be used. Slash-command behavior varies by agent; these phrases are not guaranteed native UI commands everywhere.

Example request:

```text
Run the enterprise audit against this entire repository.
Report evidence-backed findings with source paths and line numbers where available.
Separate proven defects, architecture risks, and hypotheses, and list coverage gaps.
```

## Antigravity

Skill locations used by the PowerShell installer:

- Workspace: `.agents/skills/enterprise-audit/SKILL.md`
- IDE global: `~/.gemini/config/skills/enterprise-audit/SKILL.md`
- CLI global: `~/.gemini/antigravity-cli/skills/enterprise-audit/SKILL.md`

After global installation, you normally do not need to reinstall it for every repository.

Install only Antigravity:

```powershell
.\install.ps1 -Agents antigravity
```

Install it only into a particular workspace:

```powershell
.\install.ps1 -ProjectOnly -Agents antigravity -ProjectPath "C:\path\to\project"
```

## Global vs project-level installation

Global installation is intended for repeated personal use across repositories. Project-level installation is useful when the audit instructions should travel with the repository for teammates or other environments.

```powershell
.\install.ps1 -ProjectOnly -ProjectPath "D:\Projects\MyProject"
```

## Updating

If you cloned this repository with Git:

```powershell
git pull
Unblock-File -LiteralPath .\install.ps1
.\install.ps1
```

If `git pull` reports `fatal: not a git repository`, the directory was likely downloaded/extracted without Git metadata. Clone the repository for convenient future updates.

## Integrity principles

The protocol requires evidence classes, exact source locations when available, no fabricated vulnerabilities or benchmarks, and explicit coverage gaps. AI-generated audit findings still require engineering review before production changes are made.

## Contributing & security

Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md). For security-sensitive reports, follow [SECURITY.md](SECURITY.md) instead of posting exploit details publicly.

## Version 1.1.0

Highlights include Persian documentation, bilingual navigation, Windows `Unblock-File` guidance, corrected Antigravity skill paths, CI across major operating systems, and global/project-level installation guidance. See [CHANGELOG.md](CHANGELOG.md) for details.

## Author

Created and maintained by **[Taimazus](https://github.com/taimazus)**. If the project helps you, please consider [starring the repository](https://github.com/taimazus/universal-ai-audit) and sharing it with other developers.

See [LICENSE](LICENSE) for license terms.
