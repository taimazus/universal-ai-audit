<div lang="fa" dir="rtl" align="right">

<p align="center"><img src="banner.jpg" alt="Universal AI Enterprise Audit Pack" width="100%"></p>

# بستهٔ ممیزی و مهارت‌های مهندسی چند agent

نسخه: **1.5.0** · [English](README.md) · [راهنمای کامل فارسی](docs/README.md)

نسخهٔ 1.5.0 شامل اسکیل جدید و اصلاحات installer است؛ tag قدیمی 1.4.0 این موارد را ندارد. ثبت شمارهٔ نسخه در کد به معنی ایجاد GitHub Release نیست.

بیست‌ویک skill به ترتیب معمول هماهنگی، ساخت پروژه، مستندات، ممیزی گسترده و تخصصی، ارزیابی تست، اصلاح و حلقهٔ اصلاح، پاک‌سازی، آمادگی انتشار و Git/GitHub در دسترس‌اند. فقط مراحل مرتبط انتخاب شوند. متن skillها انگلیسی است؛ [راهنمای فارسی](docs/skills.md) و [English guide](docs/skills.en.md) و نمونه‌های ترکیبی دو زبان موجودند.

اسکیل‌های مستندسازی موضوع جدید را به‌طور پیش‌فرض فارسی و انگلیسی می‌سازند؛ زبان اضافی با نام یا locale ورودی داده می‌شود و انتخاب صریح کاربر مقدم است. هنگام به‌روزرسانی، همهٔ ترجمه‌های موجود موضوع هماهنگ می‌شوند. جهت و تراز متن مطابق زبان، RTL/راست‌چین یا LTR/چپ‌چین است و کد و فرمان‌ها LTR می‌مانند.

## نصب سراسری

ابتدا بسته را [دانلود یا با Git clone کنید](docs/installation.md). همین راهنما دستورهای `git pull` و نصب مجدد برای ارتقا را نیز دارد؛ دستورهای زیر از پوشهٔ دریافت‌شده اجرا می‌شوند.

<div dir="ltr">

<div dir="ltr" align="left">

```powershell
./install.ps1 -GlobalOnly -Agents all -Skills all -WhatIf
./install.ps1 -GlobalOnly -Agents all -Skills all
```

</div>

</div>

<div dir="ltr">

<div dir="ltr" align="left">

```bash
bash ./install.sh --global-only --agents all --skills all --dry-run
bash ./install.sh --global-only --agents all --skills all
```

</div>

</div>

پشتیبانی native: Codex، Claude Code، Cursor، Antigravity، Gemini CLI، GitHub Copilot ، OpenCode، Windsurf/Cascade، Cline و Roo Code؛ generic برای قرارداد مشترک. نصب حساب کاربری محلی خودبه‌خود به session ابری منتقل نمی‌شود.

## راهنماها

- [نصب پروژه‌ای، ارتقا و بازیابی](docs/installation.md)
- [نصب سراسری، جدول مسیرها و منابع رسمی](docs/global-installation.md)
- [مثال کامل همهٔ skillها](docs/skills.md)
- [ساخت پروژه از موضوع با تعامل و سناریوی جامع](docs/project-builder.md)
- [ترکیب‌های کامل و الگوی ترکیب دلخواه](docs/combinations.md)
- [تست و نگهداری](docs/maintenance.md)
- [معماری و نمودارهای قابل ویرایش](docs/architecture.md)
- [پیش‌نویس Wiki محلی](docs/wiki/Home.md)
- [مشارکت](CONTRIBUTING.fa.md)
- [امنیت](SECURITY.fa.md)
- [توضیح فارسی مجوز](LICENSE.fa.md) و [مجوز حقوقی اصلی](LICENSE)
- [تاریخچهٔ تغییرات](CHANGELOG.fa.md)

## استفاده

[ابزارها، حافظه و ارزیابی](docs/skill-tooling.fa.md) · [گزارش بررسی](docs/skill-suite-review.fa.md)

اسکیل‌ها پروژهٔ باز در محیط را هدف می‌گیرند و اطلاعات موجود را کشف می‌کنند. تصمیم‌ها، اقدامات، checks و قدم بعدی در یادداشت‌های موجود یا `.ai-work/` ذخیره و هنگام ادامه بازیابی و با کد تطبیق داده می‌شوند. برای اعمال این قرارداد در نصب‌های قبلی، اسکیل‌های به‌روزشده را دوباره نصب کنید.

[کتابخانهٔ ۳۶ پرامپت آماده](docs/prompt-library.fa.md) و [نسخهٔ انگلیسی](docs/prompt-library.en.md) سناریوهای ساخت، توسعه، دیباگ، بررسی، تست و انتشار مجاز را پوشش می‌دهند.

پس از نصب، [راهنمای بررسی خروجی و پاک‌سازی](docs/post-installation.md) توضیح می‌دهد کدام فایل‌ها موقت‌اند، کدام مسیرها باید حفظ شوند و چگونه وضعیت GitHub CLI را بررسی کنید.

<div dir="ltr" align="left">

```text
security-audit → audit-fix-loop → project-docs → release-readiness را روی این پروژه اجرا کن.
نقص‌های تأییدشده را اصلاح و تست کن، مستندات را هماهنگ کن و یک گزارش فارسی بده.
در صورت blocker نتیجهٔ ناتمام را صریح بگو. انتشار یا deployment انجام نده.
```

</div>

فایل‌های موجود بدون Force حفظ می‌شوند و جایگزینی backup یکتا می‌سازد. نصب تازهٔ global همهٔ متن‌ها را به دستورالعمل همیشه‌فعال تزریق نمی‌کند. کپی‌ها و بلوک‌های نسخهٔ قدیمی به صورت خودکار حذف نمی‌شوند؛ راهنمای مهاجرت را بخوانید.

دستورالعمل کوتاه‌تر تضمین بهترین پاسخ یا نبود تمام باگ‌ها نیست. گزارش agent و خط‌مشی سازمانی را بررسی کنید. تست‌ها رفتار installer را می‌سنجند؛ discovery واقعی محصول باید در محیط هدف تأیید شود.

[GitHub](https://github.com/taimazus/universal-ai-audit) · [CI](https://github.com/taimazus/universal-ai-audit/actions) · [Release](https://github.com/taimazus/universal-ai-audit/releases)

</div>
