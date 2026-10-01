# Universal AI Enterprise Audit Pack

**Version: 1.1.0**

**English** | [فارسی](README.fa.md)

A portable, evidence-first code-audit instruction pack for heterogeneous repositories and multiple coding agents.

## Windows / PowerShell

If Windows marks the downloaded script as coming from the Internet, unblock it first:

```powershell
Unblock-File -LiteralPath .\install.ps1
.\install.ps1 -DryRun
.\install.ps1
```

If an organizational `AllSigned`/Group Policy applies, follow your organization's signing policy rather than permanently weakening ExecutionPolicy.

Install only Antigravity:

```powershell
.\install.ps1 -Agents antigravity
```

Install Antigravity only into a particular workspace:

```powershell
.\install.ps1 -ProjectOnly -Agents antigravity -ProjectPath "C:\path\to\project"
```

## Linux / macOS / WSL

```bash
chmod +x ./install.sh
./install.sh --dry-run
./install.sh
```

## Supported adapters

- Generic / `AGENTS.md` compatible agents
- OpenAI/Codex skill + `AGENTS.md`
- Claude-compatible `CLAUDE.md`
- Cursor `.cursor/rules/*.mdc`
- GitHub Copilot `.github/instructions/*.instructions.md`
- Gemini-compatible `GEMINI.md`
- Google Antigravity IDE / CLI

## Antigravity

Skill locations used by the PowerShell installer:

- Workspace: `.agents/skills/enterprise-audit/SKILL.md`
- Antigravity IDE global: `~/.gemini/config/skills/enterprise-audit/SKILL.md`
- Antigravity CLI global: `~/.gemini/antigravity-cli/skills/enterprise-audit/SKILL.md`

After global installation, you normally do not need to reinstall for every repository. Open a project in Antigravity, start a new conversation, and invoke:

```text
/enterprise-audit
```

Antigravity can also discover the skill automatically from a relevant request such as:

```text
Run the enterprise-audit skill against this entire repository and report evidence-backed findings.
```

## Use with other agents

Ask for `enterprise audit`, `deep code audit`, `/audit-deep`, `/audit-goal`, or `ممیزی جامع پروژه`. Slash-command behavior varies by agent; these phrases are not guaranteed to be native UI commands in every agent.

## Global vs project-level installation

Global installation is intended for repeated personal use across repositories. Project-level installation is useful when audit instructions should travel with the repository for teammates or other environments.

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

## Safety / integrity

The protocol requires evidence classes, exact source locations when available, no fabricated vulnerabilities/benchmarks, and explicit coverage gaps.

## Distribution

Review generated files before committing them. Existing instruction files are preserved/append-only where appropriate; generated dedicated rule files require `--force` / `-Force` to replace. Backups are created when replacement occurs.

## Version 1.1.0

Highlights:

- Full Persian documentation (`README.fa.md`)
- English/Persian documentation navigation
- Windows `Unblock-File` guidance
- Corrected Antigravity workspace, IDE-global, and CLI-global skill paths
- Global vs project-level usage guidance
- `/enterprise-audit` usage documentation

See [LICENSE](LICENSE) for license terms.
