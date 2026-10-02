<div dir="rtl">

برای حذف فایل‌های موقت بدون آسیب به مسیرهای نصب سراسری، [راهنمای پاک‌سازی پس از نصب](post-installation.md) را بخوانید.

# نصب سراسری برای agentها

ابتدا بسته را با ZIP یا Git دریافت کنید؛ [راهنمای دانلود، clone و pull](installation.md) دستورهای کامل Windows و Bash را دارد. اجرای installer از داخل checkout بسته انجام می‌شود. برای ارتقا، پس از pull باید نصب را نیز با Force تکرار کنید؛ pull به‌تنهایی skillهای نصب‌شده را تغییر نمی‌دهد.

از پوشهٔ بسته اجرا کنید. نصب سراسری برای حساب کاربری فعلی است و معمولاً دسترسی administrator نمی‌خواهد؛ این نصب معادل نصب برای همهٔ کاربران سیستم یا session ابری نیست.

## همهٔ agentهای پشتیبانی‌شده

<div dir="ltr">

```powershell
./install.ps1 -GlobalOnly -Agents all -Skills all -WhatIf
./install.ps1 -GlobalOnly -Agents all -Skills all
```

</div>

<div dir="ltr">

```bash
bash ./install.sh --global-only --agents all --skills all --dry-run
bash ./install.sh --global-only --agents all --skills all
```

</div>

`all` شامل agentهای جدول زیر است. هیچ installer نمی‌تواند discovery در همهٔ محصولات یا نسخه‌ها را تضمین کند. Generic فقط مسیر مشترک Agent Skills را می‌نویسد و برای محصولی که این قرارداد را نمی‌خواند، پشتیبانی native محسوب نمی‌شود.

| انتخاب agent | مسیر سراسری زیر home | مسیر native پروژه |
| --- | --- | --- |
| codex | `.agents/skills` | `.agents/skills` |
| claude | `.claude/skills` | `.claude/skills` |
| cursor | `.cursor/skills` | `.cursor/skills` |
| antigravity | `.gemini/config/skills` و `.gemini/antigravity-cli/skills` | `.agents/skills` |
| gemini | `.gemini/skills` | `.gemini/skills` |
| copilot | `.copilot/skills` | `.github/skills` |
| opencode | `.config/opencode/skills` | `.opencode/skills` |
| windsurf | `.codeium/windsurf/skills` | `.windsurf/skills` |
| cline | `.cline/skills` | `.cline/skills` |
| roo | `.roo/skills` | `.roo/skills` |
| generic | `.agents/skills` | AGENTS.md و core/skills |

هر skill در `<root>/<name>/SKILL.md` قرار می‌گیرد. مسیر مشترک codex و generic فقط یک بار نوشته می‌شود. enterprise-audit همیشه نصب می‌شود؛ `none` تنها نه skill تکمیلی را کنار می‌گذارد. نصب global فایل پروژه‌ای تولید نمی‌کند.

## انتخاب چند agent یا چند skill

<div dir="ltr">

```powershell
./install.ps1 -GlobalOnly -Agents codex,claude,cursor,antigravity -Skills all
./install.ps1 -GlobalOnly -Agents gemini,copilot,opencode -Skills security-audit,audit-fix-loop
```

</div>

<div dir="ltr">

```bash
bash ./install.sh --global-only --agents codex,claude,cursor,antigravity --skills all
bash ./install.sh --global-only --agents gemini,copilot,opencode --skills security-audit,audit-fix-loop
```

</div>

نام صحیح گزینه‌ها `claude` و `cursor` است. `cloude` یا `cursour` پذیرفته نمی‌شود. برای نصب در پروژه از project-only و مسیر پروژه استفاده کنید؛ لازم نیست هر پروژه را برای استفاده از skill سراسری تغییر دهید.

## فراخوانی بعد از نصب

session تازه باز کنید یا skillها را مطابق محصول reload کنید. ابتدا دستور معمولی و قابل‌حمل زیر را امتحان کنید:

```text
از skill security-audit برای بررسی امنیت همین پروژه استفاده کن؛ فقط یافته‌های مستند را فارسی گزارش بده.
```

در Codex نام skill را از selector انتخاب کنید یا `$security-audit` را بنویسید. در Claude Code و Antigravity می‌توانید `/security-audit` را در رابط پشتیبانی‌شده انتخاب کنید. در Gemini CLI از `gemini skills list --all` برای بررسی discovery استفاده کنید. در Cursor فهرست Skills و در Copilot یا OpenCode قابلیت skill همان محصول را بررسی کنید. میان‌برهای slash برای تمام agentها یکسان یا تضمین‌شده نیستند.

نمونهٔ ترکیبی:

```text
security-audit → audit-fix-loop → project-docs → release-readiness را روی همین repository اجرا کن.
یافته‌های اثبات‌شده را رفع و تست کن، مستندات نهایی را هماهنگ کن و آمادگی انتشار را گزارش بده.
یک ledger مشترک و یک گزارش فارسی بده؛ publish یا deployment انجام نده.
```

## مقصد آزمایشی، ارتقا و مهاجرت

<div dir="ltr">

```powershell
./install.ps1 -GlobalOnly -UserHome 'C:/temp/skill-fixture' -Agents all -Skills all
```

</div>

<div dir="ltr">

```bash
bash ./install.sh --global-only --home '/tmp/skill-fixture' --agents all --skills all
```

</div>

این گزینه‌ها فقط ریشهٔ خروجی installer را تغییر می‌دهند؛ تنظیم home یا مسیر discovery محصول را عوض نمی‌کنند. فایل‌های موجود بدون Force حفظ می‌شوند. برای ارتقا ابتدا dry-run سپس `-Force` یا `--force` اجرا کنید. backupها با نام یکتا حفظ می‌شوند.

در نسخه‌های قبلی ممکن است skillها در `.codex/skills`، `.cursor/rules`، `.copilot/instructions` یا داخل `.claude/CLAUDE.md` کپی شده باشند. installer جدید آن‌ها را حذف نمی‌کند. پس از مقایسهٔ نسخه‌ها، بلوک‌ها و کپی‌های مربوط به این بسته را دستی پاک کنید تا نسخهٔ قدیمی و مصرف همیشه‌فعال باقی نماند. به تنظیمات دیگر کاربر دست نزنید.

نصب محلی خودکار به محیط cloud، remote SSH یا ماشین دیگر منتقل نمی‌شود. برای چنین محیط‌هایی از skill پروژه‌ای داخل repository یا سازوکار sync همان محصول استفاده کنید.

Windsurf/Cascade در مستندات فعلی به Devin Desktop ارجاع می‌دهد؛ مسیر قدیمی `.windsurf/skills` همچنان پشتیبانی می‌شود. در Cline/Roo فعال بودن skill و دسترسی آن را در تنظیمات محصول بررسی کنید.

## منابع رسمی مسیرها

- [Codex](https://learn.chatgpt.com/docs/build-skills)
- [Claude Code](https://code.claude.com/docs/en/skills)
- [Cursor](https://prod.cursor.com/docs/skills)
- [Antigravity](https://antigravity.google/docs/skills?app=antigravity-ide)
- [Gemini CLI](https://geminicli.com/docs/cli/skills/)
- [GitHub Copilot](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills)
- [OpenCode](https://opencode.ai/docs/skills/)
- [Windsurf/Cascade](https://docs.devin.ai/desktop/cascade/skills)
- [Cline](https://docs.cline.bot/customization/skills)
- [Roo Code](https://roocodeinc.github.io/Roo-Code/features/skills/)

مسیرها در ۲۰۲۶-۱۰-۰۲ با این منابع بررسی شده‌اند؛ رفتار هر نسخه و policy سازمانی باید در محیط مقصد تأیید شود.

</div>
