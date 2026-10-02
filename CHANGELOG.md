# Changelog

[فارسی](CHANGELOG.fa.md)

<div dir="rtl">

## 1.4.0 — ۲۰۲۶-۱۰-۰۲

- افزودن task-orchestrator برای اجرای تطبیقی درخواست با انتخاب skillهای مرتبط و معیار پذیرش.
- افزودن git-release-sync برای هماهنگی Git، نسخه، tag و Release مجاز با حفظ تاریخچه.
- ده skill قابل نصب؛ راهنماهای فارسی و مثال‌های تکی/ترکیبی تکمیل شدند.
- انتشار تجمیعی بهبودهای نسخه‌های 1.2 و 1.3 همراه تغییرات جدید.

</div>

## 1.3.0 — 2026-10-02

- Native global skills for Codex, Claude Code, Cursor, Antigravity, Gemini CLI, Copilot, OpenCode, Windsurf/Cascade, Cline and Roo Code.
- Isolated user-home override and global installation regressions; no always-loaded global skill injection.
- Bash 3.2 empty-array fix based on macOS CI failure.
- Persian documentation counterparts and current official path references.

<div dir="rtl">

# تغییرات

## 1.2.0 — ۲۰۲۶-۱۰-۰۲

- هشت skill برای ممیزی، اصلاح، امنیت، PR، تست، انتشار، مستندات و حلقهٔ اصلاح.
- دستورالعمل‌های فشرده با انتقال مشترک یافته‌ها و گزارش یکپارچه در ترکیب‌ها.
- راهنمای فارسی نصب، استفادهٔ تکی و ترکیبی، تست و بازیابی.
- نصب انتخابی و adapterهای پروژه‌ای/سراسری؛ frontmatter معتبر برای enterprise-audit.
- اصلاح مسیر پروتکل، WhatIf، حفظ backupها و اعتبارسنجی ورودی و منابع.
- تست‌های regression در PowerShell و Bash.

حجم متن هشت SKILL.md از ۲۸٬۸۲۷ به ۱۷٬۰۲۳ کاراکتر کاهش یافت (حدود ۴۱٪). این معیار معادل تعداد توکن یا تضمین کیفیت مدل نیست؛ صرفه‌جویی واقعی به tokenizer و دامنهٔ کار بستگی دارد.

</div>

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
