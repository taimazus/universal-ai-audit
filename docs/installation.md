<div dir="rtl">

# نصب، به‌روزرسانی و بازیابی

پس از نصب، [راهنمای بررسی خروجی و پاک‌سازی](post-installation.md) را برای حذف checkout موقت و فایل bootstrap، حفظ مسیرهای ضروری و بررسی ورود GitHub CLI بخوانید.

## دریافت بسته برای اولین نصب

### نصب‌کننده‌ای که خودش از Git دریافت می‌کند

اسکریپت‌های `install-from-git.ps1` و `install-from-git.sh` یک checkout موقت می‌سازند و installer همان branch/tag را اجرا می‌کنند. Git و shell مناسب باید نصب باشند. checkout برای بررسی باقی می‌ماند. در صورت شکست clone نصب شروع نمی‌شود. DryRun نیز checkout را دریافت می‌کند، اما skillهای مقصد را تغییر نمی‌دهد. هر اجرا دریافت تازه دارد؛ برای نصب/ارتقا لازم نیست clone دستی را نگه دارید.

Windows: ابتدا bootstrap را دانلود و بررسی کنید، سپس اجرا کنید:

<div dir="ltr">

```powershell
Invoke-WebRequest 'https://raw.githubusercontent.com/taimazus/universal-ai-audit/main/install-from-git.ps1' -OutFile './install-from-git.ps1'
Get-Content './install-from-git.ps1'
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./install-from-git.ps1 -Ref main -GlobalOnly -Agents all -Skills all -DryRun
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./install-from-git.ps1 -Ref main -GlobalOnly -Agents all -Skills all -Force
```

</div>

Linux/macOS/WSL:

<div dir="ltr">

```bash
curl -fL https://raw.githubusercontent.com/taimazus/universal-ai-audit/main/install-from-git.sh -o install-from-git.sh
cat install-from-git.sh
bash install-from-git.sh --ref main -- --global-only --agents all --skills all --dry-run
bash install-from-git.sh --ref main -- --global-only --agents all --skills all --force
```

</div>

برای نسخهٔ ثابت، `main` را با tag منتشرشده، مثلاً `v1.4.0`، جایگزین کنید. برای نصب پروژه‌ای از ProjectOnly/ProjectPath یا project-only/project استفاده کنید. نسخه‌های قدیمی ممکن است برخی گزینه‌های جدید را نداشته باشند. گزینهٔ Repository/--repository فقط برای repository مورداعتماد است: installer دریافت‌شده واقعاً اجرا می‌شود. دانلود bootstrap و دریافت main الزاماً به یک commit قفل نشده‌اند؛ برای قابلیت بازتولید tag ثابت و محتوای آن را بررسی کنید.

دو روش وجود دارد: ZIP برای دریافت بدون Git، یا clone برای دریافت و به‌روزرسانی بعدی با Git. دستورها در shell سیستم خودتان اجرا می‌شوند؛ ابتدا فایل‌ها را بررسی کنید، سپس installer را اجرا کنید.

### دانلود ZIP بدون Git

در [صفحهٔ پروژه](https://github.com/taimazus/universal-ai-audit)، گزینهٔ **Code → Download ZIP** را انتخاب کنید، فایل را استخراج کنید و terminal را در پوشه‌ای که `install.ps1` و `install.sh` دارد باز کنید. سپس دستور نصب متناسب با سیستم‌عامل را از ادامهٔ این راهنما اجرا کنید.

برای نسخهٔ منتشرشدهٔ مشخص، در [Releases](https://github.com/taimazus/universal-ai-audit/releases) نسخهٔ موردنظر و **Source code (zip)** را انتخاب کنید. ZIP شاخهٔ main آخرین تغییرات شاخه را دارد؛ الزاماً همان نسخهٔ Release نیست. برای ارتقای نصب مبتنی بر ZIP، ZIP جدید را در پوشهٔ جدا استخراج و از همان پوشه دوباره نصب کنید؛ `git pull` برای ZIP کار نمی‌کند.

### دریافت مستقیم با Git در Windows

پیش‌نیاز: Git نصب و دستور `git --version` قابل اجرا باشد. دستورهای زیر را در پوشه‌ای اجرا کنید که می‌خواهید checkout بسته داخل آن ایجاد شود:

<div dir="ltr">

```powershell
git clone https://github.com/taimazus/universal-ai-audit.git
Set-Location ./universal-ai-audit
./install.ps1 -GlobalOnly -Agents all -Skills all -WhatIf
./install.ps1 -GlobalOnly -Agents all -Skills all
```

</div>

اگر ExecutionPolicy مانع اجرا شد، دو دستور آخر را به این شکل اجرا کنید؛ policy دائمی سیستم تغییر نمی‌کند:

<div dir="ltr">

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./install.ps1 -GlobalOnly -Agents all -Skills all -WhatIf
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./install.ps1 -GlobalOnly -Agents all -Skills all
```

</div>

### دریافت مستقیم با Git در Linux/macOS/WSL

<div dir="ltr">

```bash
git clone https://github.com/taimazus/universal-ai-audit.git
cd universal-ai-audit
bash ./install.sh --global-only --agents all --skills all --dry-run
bash ./install.sh --global-only --agents all --skills all
```

</div>

برای نصب پروژه‌ای، به جای global-only از project-only همراه مسیر پروژهٔ مقصد استفاده کنید. اگر installer را بدون تعیین مقصد از پوشهٔ بسته اجرا کنید، مقصد پروژه‌ای همان checkout بسته خواهد بود؛ برای نصب در پروژهٔ کاری خودتان مسیر آن را صریح بدهید.

## به‌روزرسانی مستقیم از Git و نصب نسخهٔ جدید

به‌روزرسانی checkout و به‌روزرسانی skillهای نصب‌شده دو مرحلهٔ جدا هستند. `git pull` فقط فایل‌های بسته را به‌روز می‌کند؛ سپس installer را با همان agentها و skillهای موردنیاز اجرا کنید. دستورهای زیر از داخل checkout بسته اجرا می‌شوند و نصب سراسری را ارتقا می‌دهند.

### Windows

<div dir="ltr">

```powershell
git status --short
git switch main
git pull --ff-only origin main
./install.ps1 -GlobalOnly -Agents all -Skills all -Force -WhatIf
./install.ps1 -GlobalOnly -Agents all -Skills all -Force
```

</div>

### Linux/macOS/WSL

<div dir="ltr">

```bash
git status --short
git switch main
git pull --ff-only origin main
bash ./install.sh --global-only --agents all --skills all --force --dry-run
bash ./install.sh --global-only --agents all --skills all --force
```

</div>

اگر status تغییر محلی نشان می‌دهد، قبل از ادامه آن را بررسی و با commit یا روش مناسب خودتان حفظ کنید. اگر switch یا pull شکست خورد، دستور نصب بعدی را اجرا نکنید. گزینهٔ `--ff-only` از merge ناخواسته هنگام اختلاف تاریخچه جلوگیری می‌کند؛ در صورت اختلاف، مسئله را بررسی کنید و از reset یا force برای پاک‌کردن تغییرات استفاده نکنید. Force در installer فایل‌های اختصاصی قبلی را با backup جایگزین می‌کند و با force-push در Git ارتباطی ندارد.

برای ارتقای پروژه‌ای، دو دستور نصب پایانی را با مسیر مقصد جایگزین کنید:

<div dir="ltr">

```powershell
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project' -Agents codex,claude -Skills all -Force -WhatIf
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project' -Agents codex,claude -Skills all -Force
```

```bash
bash ./install.sh --project-only --project '/work/my-project' --agents codex,claude --skills all --force --dry-run
bash ./install.sh --project-only --project '/work/my-project' --agents codex,claude --skills all --force
```

</div>

## دریافت نسخهٔ ثابت با tag

برای نمونه، دریافت نسخهٔ منتشرشدهٔ `v1.4.0` در پوشهٔ جدا:

<div dir="ltr">

```bash
git clone --branch v1.4.0 --depth 1 https://github.com/taimazus/universal-ai-audit.git universal-ai-audit-v1.4.0
```

</div>

این دستور در PowerShell نیز قابل اجراست. سپس وارد پوشهٔ `universal-ai-audit-v1.4.0` شوید و installer متناسب با سیستم‌عامل را اجرا کنید. checkout مبتنی بر tag برای نسخهٔ ثابت است و ممکن است detached HEAD داشته باشد؛ برای دنبال‌کردن main از clone معمولی استفاده کنید. شمارهٔ tag را از Releases انتخاب کنید و صرفاً VERSION را برای ارتقا ویرایش نکنید.

پیش‌نیاز: PowerShell در Windows یا Bash همراه `cat`, `mkdir`, `cp`, `mktemp` در محیط shell. از مسیر بسته اجرا کنید؛ مقصد پیش‌فرض پوشهٔ جاری است. برای پروژهٔ دیگر مسیر صریح بدهید.

## Windows

<div dir="ltr">

```powershell
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project' -DryRun
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project'
```

</div>

اگر اجرای script با ExecutionPolicy مسدود است، بدون تغییر policy دائمی:

<div dir="ltr">

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project'
```

</div>

## Bash

<div dir="ltr">

```bash
bash ./install.sh --project-only --project '/work/my-project' --dry-run
bash ./install.sh --project-only --project '/work/my-project'
```

</div>

## انتخاب agent و skill

<div dir="ltr">

```powershell
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project' -Agents codex,antigravity -Skills security-audit,audit-fix-loop
./install.ps1 -GlobalOnly -Agents codex -Skills project-docs -WhatIf
./install.ps1 -GlobalOnly -Agents codex -Skills project-docs
./install.ps1 -ProjectOnly -Skills none
```

</div>

<div dir="ltr">

```bash
bash ./install.sh --project-only --project '/work/my-project' --agents codex,antigravity --skills security-audit,audit-fix-loop
bash ./install.sh --global-only --agents codex --skills project-docs --dry-run
bash ./install.sh --global-only --agents codex --skills project-docs
bash ./install.sh --project-only --skills none
```

</div>

`all` پیش‌فرض شامل نه skill تکمیلی است؛ `enterprise-audit` همیشه جزو بستهٔ پایه است. `none` فقط skillهای تکمیلی را غیرفعال می‌کند. `none` با نام دیگر قابل ترکیب نیست. انتخاب skill نصب قبلی را حذف نمی‌کند. گزینهٔ project-only و global-only با هم معتبر نیستند.

مسیرهای native و سراسری در [جدول نصب سراسری](global-installation.md) آمده‌اند. همهٔ ده skill برای agentهای این جدول قابل نصب‌اند؛ generic قرارداد مشترک را تولید می‌کند و discovery آن وابسته به محصول است.

پروتکل پایه در `core/enterprise-audit.md` نصب می‌شود. adapterها قرارداد فایل تولید می‌کنند؛ بارگذاری خودکار در هر محصول باید در محیط همان محصول بررسی شود. installer راهنماهای انسانی docs را به پروژهٔ مقصد کپی نمی‌کند؛ آن‌ها در این بسته قرار دارند.

## ارتقا

ابتدا dry-run و diff را بررسی کنید. برای جایگزینی فایل‌های اختصاصی موجود `-Force` یا `--force` بدهید. فایل‌های دستورالعمل کاربر append می‌شوند و محتوای قبلی حفظ می‌شود. تغییر متن نسخهٔ جدید ممکن است یک بلوک تازه به آن‌ها اضافه کند؛ بلوک‌های قدیمی را پس از بررسی دستی پاک کنید.

<div dir="ltr">

```powershell
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project' -Force -WhatIf
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project' -Force
```

</div>

<div dir="ltr">

```bash
bash ./install.sh --project-only --project '/work/my-project' --force --dry-run
bash ./install.sh --project-only --project '/work/my-project' --force
```

</div>

## بازیابی

PowerShell backupها را در `.ai-audit-backup-<id>` زیر ProjectPath و Bash کنار فایل با پسوند `.ai-audit.bak.<id>` نگه می‌دارد. چند نسخهٔ backup یک فایل ممکن است مربوط به مراحل append همان نصب باشند؛ نسخهٔ پیش از نصب را با بررسی محتوا انتخاب کنید. در global-only، PowerShell محل backup را زیر UserHome قرار می‌دهد.

فایل موردنظر را پس از بررسی از backup برگردانید. فایل تازه‌ساخته‌شده backup ندارد؛ فقط همان مسیرهای تولیدشده را پس از بررسی حذف کنید. این بسته uninstall خودکار ندارد. rollback تغییرات کد یا دادهٔ پروژهٔ هدف با بازگرداندن فایل skill انجام نمی‌شود.

</div>
