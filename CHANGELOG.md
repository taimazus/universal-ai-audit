# Changelog

All notable changes to Universal AI Enterprise Audit Pack are documented here.

## [1.1.0] - 2026-10-01

### Added
- Full Persian documentation in `README.fa.md`.
- English/Persian language navigation.
- GitHub Actions CI across Windows, Ubuntu, and macOS.
- PowerShell parser validation and installer dry-run smoke tests.
- Antigravity workspace installation smoke test.
- Package/version metadata validation.

### Changed
- Google Antigravity integration now uses current skill locations:
  - Workspace: `.agents/skills/enterprise-audit/SKILL.md`
  - IDE/global: `~/.gemini/config/skills/enterprise-audit/SKILL.md`
  - CLI/global: `~/.gemini/antigravity-cli/skills/enterprise-audit/SKILL.md`
- Windows documentation now explains `Unblock-File` and Execution Policy behavior.

### Notes
- Existing project/global instruction files continue to be preserved where appropriate.
- `/enterprise-audit` is the explicit Antigravity skill invocation; behavior of slash commands in other agents varies by product.

## [1.0.0]

- Initial public release of the universal multi-agent enterprise code-audit pack.
