<div lang="fa" dir="rtl" align="right">

# ابزارها، حافظه و ارزیابی مهارت‌ها

[English](skill-tooling.en.md) · [مهارت‌ها](skills.md) · [۳۶ سناریوی آماده](prompt-library.fa.md)

بسته اکنون ۲۱ مهارت دارد: `enterprise-audit` و ۲۰ مهارت مکمل. مهارت‌های جدید `skill-evaluation`، `bug-investigation`، `feature-delivery`، `test-engineering`، `performance-lab`، `migration-upgrade`، `ui-accessibility` و `operations-readiness` هستند. هر مهارت معیار پایان، حدود مجوز، بازیابی وضعیت و ثبت نتایج واقعی دارد. همهٔ مراحل اجباری نیستند؛ فقط مهارت مرتبط انتخاب شود.

## منبع اصلی و adapterها

متن تخصصی مهارت‌ها در `.agents/skills/`، قرارداد مشترک در `core/skill-contract.md` و پروفایل‌ها در `core/stack-profiles.md` نگهداری می‌شوند. ابزار تولید، قرارداد مشترک را در مهارت‌ها جای می‌دهد و نسخه‌های `.antigravity/skills/`، پروتکل ممیزی، adapterهای ممیزی Cursor/Copilot و کاتالوگ `core/skills.json` را همگام می‌کند. این روش فایل‌های مهارت نصب‌شده را خودکفا نگه می‌دارد. فایل اضافی adapter خودکار حذف نمی‌شود و نیازمند بررسی است.

<div dir="ltr" align="left">

```text
python tools/generate_adapters.py
python tools/generate_adapters.py --check
python tests/docs.py
```

</div>

نصب‌کننده‌ها علاوه بر `SKILL.md`، منابع متنی UTF-8 زیر `scripts/`، `references/`، `assets/` و `agents/` را در مقصد native و portable توزیع می‌کنند. منابع باینری در این قرارداد پشتیبانی نمی‌شوند. برای نصب‌های قبلی ابتدا dry-run و سپس نصب مجدد با گزینهٔ Force را مطابق [راهنمای نصب](installation.md) اجرا کنید. ساخت مهارت مجوز تغییر نصب‌های سراسری نیست.

## حافظهٔ قابل بازیابی

با Python 3.10+، ابزار `project-context/scripts/task_state.py` نسبت به محل نصب مهارت قابل اجراست. مسیر root باید پروژهٔ باز و بررسی‌شده باشد. `init` پایگاه `.ai-work/state.sqlite3` را ایجاد می‌کند؛ ثبت رکورد و تاریخچهٔ revision در یک transaction انجام می‌شود. هر تغییر revision قبلی را لازم دارد؛ تعارض یا قفل فعال باعث شکست صریح می‌شود و دادهٔ قبلی حفظ می‌شود. وقفهٔ قبل از commit موفقیت محسوب نمی‌شود.

پاسخ‌ها منبع، دامنه، وضعیت confirmed/assumed/superseded، شرایط کاربرد و fingerprint فایل‌های مرتبط دارند. پاسخ تنها وقتی قابل استفادهٔ مجدد است که تأییدشده و شرایط و فایل‌ها همچنان سازگار باشند. پاسخ task خاص به task دیگر منتقل نمی‌شود. یادداشت قبلی مجوز تازهٔ عملیات خارجی نیست و ابزار نمی‌تواند راست‌بودن ادعای «کاربر تأیید کرده» را به‌تنهایی اثبات کند.

<div dir="ltr" align="left">

```text
python <installed-project-context>/scripts/task_state.py --root <verified-project-root> init
python <installed-project-context>/scripts/task_state.py --root <verified-project-root> show --id <task-id>
python <installed-project-context>/scripts/task_state.py --root <verified-project-root> checkpoint --id <task-id> --input <redacted-task.json> --expect-revision <revision>
```

</div>

رکوردهای ابزار در SQLite منبع همان داده‌ها هستند؛ فایل‌های Markdown موجود حذف یا خودکار بازنویسی نمی‌شوند. عامل باید مشخص کند کدام را استفاده کرده و تعارض را با شواهد فعلی حل کند. بدون Python، نوشتن مجاز یا دسترسی به فایل‌ها، روش Markdown یا handoff متنی حفظ می‌شود و محدودیت گزارش می‌شود. مسیرهای linked و پایگاه متعلق به root دیگری رد می‌شوند؛ نسخهٔ ناشناخته خودکار بازنویسی نمی‌شود. [قرارداد دقیق ابزار](../.agents/skills/project-context/references/state-tool.md) شامل CLI، schema و کدهای خروج است.

ورودی باید از ابتدا بدون secrets باشد. ردکردن نام کلید حساس یا الگوی token، تضمین کشف همهٔ داده‌های حساس نیست. پایگاه و یادداشت‌ها نباید خودکار stage، منتشر یا در پاک‌سازی حذف شوند. نسخهٔ پایگاه و schema فعلی ۱ است؛ ارتقای ناسازگار نیازمند migration صریح است.

## آزمون ابزار در برابر ارزیابی agent

تست‌های استاندارد کتابخانهٔ Python، ذخیره و بازیابی بین processها، تعارض revision، دو نویسنده، قفل، rollback پس از قطع process، پاسخ قدیمی، تفکیک دامنه، نقص دادهٔ ذخیره‌شده و رد موفقیت ساختگی را بررسی می‌کنند. تست‌های harness نیز شکست runner، timeout، حفظ فایل و oracle خارج از workspace را می‌سنجند. این‌ها آزمون اجرایی ابزار هستند؛ رفتار یک مدل زبانی را اثبات نمی‌کنند.

<div dir="ltr" align="left">

```text
python -m unittest discover -s tests -p "test_*.py" -v
```

</div>

مهارت `skill-evaluation` هفت fixture رفتاری و runner قابل تنظیم دارد. بدون runner، فقط محیط‌ها آماده و نتیجه `prepared` ثبت می‌شود؛ هیچ API مدل فراخوانی نمی‌شود. برای اجرای واقعی، runner مجاز باید agent را با مهارت مورد ارزیابی اجرا و هویت agent/model و نتیجه را ثبت کند. oracle و معیارهای مورد انتظار به مدل داده نمی‌شوند. `passed`، `failed` و `blocked` از خروجی واقعی تفکیک می‌شوند؛ report موجود بازنویسی نمی‌شود.

<div dir="ltr" align="left">

```text
python <installed-skill-evaluation>/scripts/evaluate.py --output <new-report.json>
python <installed-skill-evaluation>/scripts/evaluate.py --runner-config <authorized-runner.json> --output <new-report.json>
```

</div>

این fixtureها تمام رفتار همهٔ ۲۱ مهارت را پوشش نمی‌دهند. محیط موقت sandbox امنیتی سیستم‌عامل نیست؛ runner باید قابل اعتماد و مجاز باشد. هویت اعلام‌شدهٔ runner اثبات رمزنگاری‌شده نیست و سؤال درست را صرفاً از JSON خودگزارش‌شده نمی‌توان اثبات کرد. [قرارداد ارزیابی](../.agents/skills/skill-evaluation/references/evaluation.md) جزئیات و محدودیت‌ها را مشخص می‌کند.

## پروفایل‌های تخصصی و کنترل کیفیت

پروفایل‌های React/browser، Python، .NET و relational database تنها برای stack کشف‌شده خوانده می‌شوند. نسخه‌ها و conventions پروژه بر مثال عمومی مقدم‌اند؛ ادعاهای متغیر بیرونی باید با مستندات رسمی جاری بررسی شوند. [منبع پروفایل‌ها](../core/stack-profiles.md) و منابع مربوط داخل مهارت‌ها قابل ویرایش‌اند.

CI آزمون نصب، مستندات و parity را همراه تست ابزارهای Python روی Windows/Linux/macOS اجرا می‌کند. سبزبودن تعریف job یا پاس محلی به معنی موفقیت اجرای hosted CI نیست. معیار پایان هر مهارت مستلزم شواهد واقعی همان درخواست است؛ هیچ مهارتی نبود تمام باگ‌ها، امنیت کامل یا حافظهٔ بی‌خطا را تضمین نمی‌کند.

</div>
