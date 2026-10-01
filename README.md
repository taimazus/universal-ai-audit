# Universal AI Enterprise Audit Pack

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
- Google Antigravity 2.0 / IDE / CLI

## Antigravity 2.0

Current official skill locations used by the PowerShell installer:

- Workspace: `.agents/skills/enterprise-audit/SKILL.md`
- Antigravity 2.0 / IDE global: `~/.gemini/config/skills/enterprise-audit/SKILL.md`
- Antigravity CLI global: `~/.gemini/antigravity-cli/skills/enterprise-audit/SKILL.md`

After installation, open a new Antigravity conversation and invoke:

```text
/enterprise-audit
```

Antigravity can also discover the skill automatically from a relevant request such as:

```text
Run the enterprise-audit skill against this entire repository and report evidence-backed findings.
```

## Use with other agents

Ask for `enterprise audit`, `deep code audit`, `/audit-deep`, `/audit-goal`, or `ممیزی جامع پروژه`. Slash-command behavior varies by agent; Antigravity 2.0 explicitly exposes installed skills as `/<skill-name>`.

## Safety / integrity

The protocol requires evidence classes, exact source locations when available, no fabricated vulnerabilities/benchmarks, and explicit coverage gaps.

## Distribution

Review generated files before committing them. Existing instruction files are preserved/append-only where appropriate; generated dedicated rule files require `--force` / `-Force` to replace. Backups are created when replacement occurs.
