# Universal AI Enterprise Audit Pack

A portable, evidence-first code-audit instruction pack for heterogeneous repositories and multiple coding agents.

## Install
Windows/PowerShell: `./install.ps1 -DryRun` then `./install.ps1`.
Linux/macOS/WSL: `./install.sh --dry-run` then `./install.sh`.
Use project-only/global-only and agent selection flags shown by `--help` (shell) or `Get-Help ./install.ps1`.

## Supported adapters
- Generic / AGENTS.md-compatible agents
- OpenAI/Codex skill + AGENTS.md
- Claude-compatible CLAUDE.md
- Cursor `.cursor/rules/*.mdc`
- GitHub Copilot `.github/instructions/*.instructions.md` and user-level Copilot CLI instructions
- Gemini-compatible GEMINI.md
- Antigravity-style skill directory (best-effort adapter; verify your installed product's current convention)

## Use
Ask the agent for `/audit-deep`, `/audit-goal`, `enterprise audit`, `deep code audit`, or `ممیزی جامع پروژه`. Agents do not universally implement slash commands; these are semantic triggers, not guaranteed UI commands.

## Safety / integrity
The protocol requires evidence classes, exact source locations when available, no fabricated vulnerabilities/benchmarks, and explicit coverage gaps.

## Distribution
Review the generated files before committing them. Existing instruction files are preserved/append-only where appropriate; generated dedicated rule files require `--force` / `-Force` to replace. Backups are created when replacement occurs.
