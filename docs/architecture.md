<div dir="rtl">

# معماری و جریان‌های اجرا

این repository یک بستهٔ دستورالعمل و installer است؛ سرور یا API سرویس ندارد؛ ابزار حافظهٔ محلی SQLite و ابزار ارزیابی fixture به آن افزوده شده‌اند. نسخهٔ ثبت‌شده در [VERSION](../VERSION)، `1.5.0` است و اسکیل `project-builder` را دارد. فهرست فعلی بیست‌ویک اسکیل را در [راهنمای استفاده](skills.md) ببینید؛ tag قدیمی `v1.4.0` این تغییرات را ندارد و ثبت نسخه به معنی ایجاد Release نیست.

## اجزا و منبع حقیقت

| جزء | مسئولیت و شواهد کد |
| --- | --- |
| پروتکل پایه | [core/enterprise-audit.md](../core/enterprise-audit.md)، خروجی تولیدشده از مهارت enterprise-audit و خوانده‌شده توسط هر دو installer |
| اسکیل‌های تکمیلی | `.agents/skills/<name>/SKILL.md`؛ منبع محتوای تخصصی و منابع اجرایی؛ انتخاب و خواندن توسط هر دو installer |
| دستورالعمل‌های agent | [AGENTS.md](../AGENTS.md)، [CLAUDE.md](../CLAUDE.md) و [GEMINI.md](../GEMINI.md)؛ مسیریابی به پروتکل، نه موتور اجرای خودکار |
| installerهای محلی | [install.ps1](../install.ps1) و [install.sh](../install.sh)؛ نصب پروژه‌ای، سراسری یا هر دو، انتخاب agent/skill، dry-run و backup |
| bootstrapهای Git | [install-from-git.ps1](../install-from-git.ps1) و [install-from-git.sh](../install-from-git.sh)؛ clone branch/tag، اجرای installer و نگه‌داشتن checkout |
| adapterها | مسیرهای native، قواعد Cursor و دستورالعمل Copilot؛ جدول دقیق در [نصب سراسری](global-installation.md) |
| تست و CI | [tests/install.ps1](../tests/install.ps1)، [tests/install.sh](../tests/install.sh) و [ci.yml](../.github/workflows/ci.yml)؛ fixtureهای ایزوله و بررسی installerها |

## نمودار معماری قابل ویرایش

منبع نمودار، بلوک Mermaid همین صفحه است؛ فایل تصویر مستقلی منبع حقیقت نیست.

<div dir="ltr">

```mermaid
flowchart TD
    User["کاربر: agent، skill و مقصد"] --> Bootstrap["bootstrap اختیاری Git"]
    Bootstrap --> Checkout["checkout branch یا tag"]
    Checkout --> Installer["installer PowerShell یا Bash"]
    User --> Installer
    Contract["core/skill-contract.md و stack-profiles.md"] --> Generator["tools/generate_adapters.py"]
    Generator --> Core["core/enterprise-audit.md"]
    Generator --> Adapters["adapterها و core/skills.json"]
    Core --> Installer
    Skills[".agents/skills: ۲۰ اسکیل تکمیلی"] --> Installer
    Routes["AGENTS.md: دستور مسیریابی پایه"] --> Installer
    Installer --> Preview["DryRun / WhatIf: بدون نوشتن مقصد"]
    Installer --> Project["مقصد پروژه: core، routes و adapterها"]
    Installer --> Global["مقصد سراسری: پوشه‌های SKILL.md"]
    Installer --> Backups["backup هنگام تغییر فایل موجود"]
    Project --> Agent["agent مقصد: شناسایی و اجرای دستورالعمل"]
    Global --> Agent
    Agent --> Memory["project-context: SQLite و یادداشت‌های task"]
    Agent --> Evaluation["skill-evaluation: fixture و runner مجاز"]
    CI["CI و تست‌های fixture"] --> Installer
```

</div>

`enterprise-audit` از پروتکل پایه ساخته می‌شود؛ ۲۰ اسکیل دیگر از منابع تکمیلی خوانده می‌شوند. انتخاب `none` فقط اسکیل‌های تکمیلی را کنار می‌گذارد. installerها منابع را پیش از نوشتن مقصد بررسی می‌کنند؛ یک اسکیل به‌تنهایی وجود همهٔ اسکیل‌های اختیاری را تضمین نمی‌کند.

## sequence نصب مستقیم از Git

<div dir="ltr">

```mermaid
sequenceDiagram
    actor U as کاربر
    participant B as bootstrap
    participant G as Git
    participant I as installer
    participant D as مقصد نصب
    participant K as محل backup
    U->>B: branch/tag و گزینه‌های نصب
    B->>G: clone در پوشهٔ موقت
    alt clone ناموفق یا installer مفقود
        B-->>U: خطا؛ نصب شروع نمی‌شود
    else دریافت موفق
        B-->>U: مسیر SOURCE؛ checkout حفظ می‌شود
        B->>I: اجرای installer با گزینه‌های کاربر
        I->>I: بررسی انتخاب‌ها و منابع
        alt پیش‌نمایش
            I-->>U: تغییرات پیشنهادی؛ بدون نوشتن مقصد
        else نصب واقعی
            loop هر فایل مقصد
                I->>D: بررسی فایل موجود
                alt فایل یکسان یا حفظ بدون Force
                    I-->>U: Skipped
                else نیاز به نوشتن
                    opt فایل موجود
                        I->>K: backup پیش از تغییر
                    end
                    I->>D: نوشتن یا append
                end
            end
            I-->>U: Changed / Skipped / Failed و exit code
        end
    end
```

</div>

ترتیب clone و اجرا از `install-from-git.ps1:20` تا 27 و `install-from-git.sh:23` تا 27 گرفته شده است. DryRun bootstrap نیز checkout را دریافت می‌کند. خطای ورودی یا منابع installer می‌تواند پیش از چاپ خلاصه، اجرا را متوقف کند. خطاهای نوشتن در installer ثبت می‌شوند؛ نصب چندفایلی تراکنش واحد نیست.

## sequence ساخت پروژه با تعامل

این نمودار دستورالعمل اسکیل است، نه یک سرویس یا ابزار خودکار پیاده‌سازی‌شده. منبع: [.agents/skills/project-builder/SKILL.md](../.agents/skills/project-builder/SKILL.md).

<div dir="ltr">

```mermaid
sequenceDiagram
    actor U as کاربر
    participant A as agent با project-builder
    participant P as brief و پروژه
    participant T as ابزارهای تست موجود
    U->>A: موضوع، مقصد و حالت طراحی یا ساخت
    A->>P: بررسی وضعیت و قراردادهای موجود
    loop تا روشن‌شدن تصمیم‌های مؤثر
        A-->>U: پرسش‌های کوتاه و گزینه‌های مرتبط
        U->>A: پاسخ و محدودیت
        A->>P: ثبت تصمیم، فرض و معیار پذیرش
    end
    A-->>U: سناریو، دامنه و طرح مشخص
    alt فقط طراحی
        A->>P: مستندات سناریو و طرح
    else ساخت درخواست‌شده با تصمیم‌های روشن
        loop مراحل توافق‌شده
            A->>P: پیاده‌سازی مرحله
            A->>T: checks و تست‌های پذیرش
            T-->>A: نتیجهٔ واقعی یا محدودیت ابزار
            A->>P: اصلاح نقص تأییدشده و ثبت وضعیت
        end
    end
    A-->>U: نتیجه، راه اجرای پروژه و شکاف‌ها
```

</div>

## مرزهای قابلیت اطمینان و تغییر

نصب محلی به معنی discovery موفق در همهٔ نسخه‌های agentها نیست. اسکیل‌ها رفتار agent را هدایت می‌کنند و تضمین خروجی بی‌نقص نمی‌دهند. installerها فایل‌ها را مستقیم می‌نویسند و rollback خودکار کل نصب ندارند؛ ریسک قطع پردازش و پوشش‌نداشتن integration bootstrap در [گزارش ممیزی](audit-report.md) ثبت شده است.

PowerShell backupهای جدید را با نام کوتاه و فایل `.path` نگه می‌دارد و برای ریشهٔ بلند fallback به Temp دارد؛ Bash backup را کنار فایل نگه می‌دارد. دستورها و بازیابی در [راهنمای نصب](installation.md) و پاک‌سازی در [راهنمای پس از نصب](post-installation.md) مرجع اصلی‌اند.

## build و render مستندات

در repository، package یا تنظیمات MkDocs/Sphinx/Docusaurus، دستور build مستندات و ابزار render همراه بسته وجود ندارد. CI فعلی Markdown یا Mermaid را build/render نمی‌کند. نمودارهای Mermaid را در preview سازگار نمایش دهید و منبع همین صفحه را ویرایش کنید. در این به‌روزرسانی `mmdc` و `markdownlint` در PATH موجود نبودند؛ export تصویر و بررسی بصری انجام نشد. وجود Node/npm به‌تنهایی renderer محسوب نمی‌شود.

لینک‌ها، anchorهای محلی، fenceها و تطبیق نمودارها با جریان کد بررسی می‌شوند؛ این بررسی جای parser و render واقعی Mermaid را نمی‌گیرد. افزودن ابزار و export در آینده باید نسخه و روش اجرای قابل بازتولید داشته باشد.

</div>
