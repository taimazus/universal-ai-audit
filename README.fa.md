<p align="center">
  <img src="banner.jpg" alt="Universal AI Enterprise Audit Pack" width="100%">
</p>

<div dir="rtl">

# بسته ممیزی سازمانی هوش مصنوعی — Universal AI Enterprise Audit Pack

<p align="center"><strong>یک ممیزی؛ برای Agentهای مختلف هوش مصنوعی و repositoryهای مختلف.</strong></p>

<p align="center">
<a href="https://github.com/taimazus/universal-ai-audit/releases">Release</a> ·
<a href="https://github.com/taimazus/universal-ai-audit/actions">CI</a> ·
<a href="LICENSE">License</a> ·
<a href="https://github.com/taimazus/universal-ai-audit/stargazers">⭐ Star</a>
</p>

**نسخه: 1.2.0**

[English](README.md) | **فارسی**

یک بسته متن‌باز، قابل‌حمل و مبتنی بر شواهد برای ممیزی عمیق کد و معماری پروژه‌ها توسط Agentهای مختلف هوش مصنوعی.

**ساخته و نگهداری‌شده توسط [Taimazus](https://github.com/taimazus).**

## راهنمای نسخهٔ جدید

[هشت skill و مثال‌ها](docs/skills.md) · [ترکیب‌ها](docs/combinations.md) · [نصب و بازیابی](docs/installation.md)

نسخهٔ جدید شامل workflow مشترک، نصب انتخابی skillها، حلقهٔ اصلاح و مستندات پروژه است. مسیرهای قدیمی Antigravity برای سازگاری حفظ شده‌اند؛ مسیر استاندارد workspace نیز نصب می‌شود.

## قابلیت‌ها

این بسته برای استفاده روی repositoryهای ناهمگون طراحی شده و ممیزی را به یک زبان خاص محدود نمی‌کند. هسته ممیزی روی مواردی مانند هدف و دامنه پروژه، معماری، الگوریتم‌ها و پیچیدگی، امنیت، هم‌زمانی، مدیریت منابع، کارایی، تست‌پذیری و صحت پیاده‌سازی تمرکز دارد.

Adapterهای فعلی شامل Agentهای سازگار با `AGENTS.md`، Codex/OpenAI، Claude، Cursor، GitHub Copilot، Gemini و Google Antigravity است.

## شروع سریع در Windows / PowerShell

```powershell
git clone https://github.com/taimazus/universal-ai-audit.git
cd universal-ai-audit
Unblock-File -LiteralPath .\install.ps1
.\install.ps1 -DryRun
.\install.ps1
```

اگر در پایان `Failed=0` مشاهده کردید، نصب بدون خطای گزارش‌شده انجام شده است.

برای نصب اجباری فایل‌های اختصاصی بسته در صورت وجود نسخه قبلی:

```powershell
.\install.ps1 -Force
```

> اگر سیستم شما تحت `AllSigned` یا Group Policy سازمانی است، policy امنیتی سازمان را دنبال کنید و Execution Policy را به‌صورت دائمی تضعیف نکنید.

## نصب در Linux / macOS / WSL

```bash
git clone https://github.com/taimazus/universal-ai-audit.git
cd universal-ai-audit
chmod +x ./install.sh
./install.sh --dry-run
./install.sh
```

## Google Antigravity

مسیرهای مورد استفاده installer برای Antigravity:

- Workspace: `.agents/skills/enterprise-audit/SKILL.md`
- Global IDE: `~/.gemini/config/skills/enterprise-audit/SKILL.md`
- Global CLI: `~/.gemini/antigravity-cli/skills/enterprise-audit/SKILL.md`

فقط Antigravity:

```powershell
.\install.ps1 -Agents antigravity
```

فقط یک پروژه مشخص:

```powershell
.\install.ps1 -ProjectOnly -Agents antigravity -ProjectPath "C:\path\to\project"
```

بعد از نصب Global، در حالت عادی لازم نیست برای هر پروژه دوباره installer را اجرا کنید. پروژه را در Antigravity باز کنید، یک conversation جدید ایجاد کنید و بنویسید:

```text
/enterprise-audit
```

یا به فارسی:

```text
کل این repository را با Enterprise Audit ممیزی کن.
گزارش را فارسی بده و فقط یافته‌های دارای شواهد را با مسیر و شماره خط دقیق گزارش کن.
```

## سایر Agentها

می‌توانید درخواست‌هایی مانند موارد زیر بدهید:

```text
enterprise audit
deep code audit
/audit-deep
/audit-goal
ممیزی جامع پروژه
```

رفتار slash command در Agentهای مختلف یکسان نیست؛ این عبارت‌ها در همه Agentها الزاماً command واقعی UI نیستند.

## نصب Project-level در برابر Global

نصب **Global** برای استفاده شخصی روی پروژه‌های مختلف مناسب است. نصب **Project-level** زمانی مفید است که می‌خواهید دستورالعمل‌های ممیزی همراه خود repository نگهداری شوند و سایر اعضای تیم نیز آن‌ها را دریافت کنند.

نمونه:

```powershell
.\install.ps1 -ProjectOnly -ProjectPath "D:\Projects\MyProject"
```

## به‌روزرسانی با Git

اگر repository را با `git clone` دریافت کرده باشید:

```powershell
git pull
Unblock-File -LiteralPath .\install.ps1
.\install.ps1
```

اگر پیام `fatal: not a git repository` می‌بینید، معمولاً پوشه را از ZIP استخراج کرده‌اید و metadata مربوط به Git (`.git`) در آن وجود ندارد. برای دریافت به‌روزرسانی‌های بعدی، repository را clone کنید.

## یکپارچگی گزارش

پروتکل ممیزی از Agent می‌خواهد یافته‌ها را بر اساس شواهد گزارش کند، محل دقیق سورس را در صورت امکان مشخص کند، vulnerability یا benchmark ساختگی تولید نکند و محدودیت‌های پوشش ممیزی را صریح بیان کند. یافته‌های تولیدشده توسط AI همچنان باید پیش از تغییرات production توسط مهندس بررسی شوند.

## مشارکت و امنیت

مشارکت‌ها خوش‌آمد هستند. راهنمای مشارکت را در [CONTRIBUTING.md](CONTRIBUTING.md) ببینید. برای گزارش‌های حساس امنیتی، به‌جای انتشار جزئیات exploit در Issue عمومی، [SECURITY.md](SECURITY.md) را دنبال کنید.

## نسخه

نسخه فعلی: **1.1.0**

تغییرات اصلی این نسخه:

- مستندات کامل فارسی
- لینک جابه‌جایی بین README انگلیسی و فارسی
- مستندسازی نصب Global و Project-level
- راهنمای Windows Execution Policy / `Unblock-File`
- پشتیبانی اصلاح‌شده از مسیرهای Antigravity IDE و CLI
- راهنمای اجرای `/enterprise-audit`
- CI چندسکویی و ارائه عمومی پروژه

## سازنده

این پروژه توسط **[Taimazus](https://github.com/taimazus)** ساخته و نگهداری می‌شود. اگر برایتان مفید بود، با ⭐ دادن به repository و معرفی آن به توسعه‌دهندگان دیگر به دیده‌شدن پروژه کمک کنید.

## مجوز

شرایط استفاده را در فایل [LICENSE](LICENSE) مشاهده کنید.

</div>
