# نصب، به‌روزرسانی و بازیابی

پیش‌نیاز: PowerShell در Windows یا Bash همراه `cat`, `mkdir`, `cp`, `mktemp` در محیط shell. از مسیر بسته اجرا کنید؛ مقصد پیش‌فرض پوشهٔ جاری است. برای پروژهٔ دیگر مسیر صریح بدهید.

## Windows

```powershell
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project' -DryRun
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project'
```

اگر اجرای script با ExecutionPolicy مسدود است، بدون تغییر policy دائمی:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project'
```

## Bash

```bash
bash ./install.sh --project-only --project '/work/my-project' --dry-run
bash ./install.sh --project-only --project '/work/my-project'
```

## انتخاب agent و skill

```powershell
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project' -Agents codex,antigravity -Skills security-audit,audit-fix-loop
./install.ps1 -GlobalOnly -Agents codex -Skills project-docs -WhatIf
./install.ps1 -GlobalOnly -Agents codex -Skills project-docs
./install.ps1 -ProjectOnly -Skills none
```

```bash
bash ./install.sh --project-only --project '/work/my-project' --agents codex,antigravity --skills security-audit,audit-fix-loop
bash ./install.sh --global-only --agents codex --skills project-docs --dry-run
bash ./install.sh --global-only --agents codex --skills project-docs
bash ./install.sh --project-only --skills none
```

`all` پیش‌فرض شامل هفت skill تکمیلی است؛ `enterprise-audit` همیشه جزو بستهٔ پایه است. `none` فقط skillهای تکمیلی را غیرفعال می‌کند. `none` با نام دیگر قابل ترکیب نیست. انتخاب skill نصب قبلی را حذف نمی‌کند. گزینهٔ project-only و global-only با هم معتبر نیستند.

| agent | پروژه | سراسری |
| --- | --- | --- |
| generic | AGENTS.md و core/skills | ندارد |
| codex | AGENTS.md و .agents/skills | .codex/skills |
| claude | CLAUDE.md و core/skills | .claude/CLAUDE.md |
| gemini | GEMINI.md و core/skills | ندارد |
| cursor | .cursor/rules | .cursor/rules در home |
| copilot | .github/instructions | .copilot/instructions در home |
| antigravity | .antigravity/skills | .antigravity/skills در home |

پروتکل پایه در `core/enterprise-audit.md` نصب می‌شود. adapterها قرارداد فایل تولید می‌کنند؛ بارگذاری خودکار در هر محصول باید در محیط همان محصول بررسی شود. installer راهنماهای انسانی docs را به پروژهٔ مقصد کپی نمی‌کند؛ آن‌ها در این بسته قرار دارند.

## ارتقا

ابتدا dry-run و diff را بررسی کنید. برای جایگزینی فایل‌های اختصاصی موجود `-Force` یا `--force` بدهید. فایل‌های دستورالعمل کاربر append می‌شوند و محتوای قبلی حفظ می‌شود. تغییر متن نسخهٔ جدید ممکن است یک بلوک تازه به آن‌ها اضافه کند؛ بلوک‌های قدیمی را پس از بررسی دستی پاک کنید.

```powershell
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project' -Force -WhatIf
./install.ps1 -ProjectOnly -ProjectPath 'C:/work/my-project' -Force
```

```bash
bash ./install.sh --project-only --project '/work/my-project' --force --dry-run
bash ./install.sh --project-only --project '/work/my-project' --force
```

## بازیابی

PowerShell backupها را در `.ai-audit-backup-<id>` زیر ProjectPath و Bash کنار فایل با پسوند `.ai-audit.bak.<id>` نگه می‌دارد. چند نسخهٔ backup یک فایل ممکن است مربوط به مراحل append همان نصب باشند؛ نسخهٔ پیش از نصب را با بررسی محتوا انتخاب کنید. حتی در global-only محل backup در PowerShell به ProjectPath وابسته است.

فایل موردنظر را پس از بررسی از backup برگردانید. فایل تازه‌ساخته‌شده backup ندارد؛ فقط همان مسیرهای تولیدشده را پس از بررسی حذف کنید. این بسته uninstall خودکار ندارد. rollback تغییرات کد یا دادهٔ پروژهٔ هدف با بازگرداندن فایل skill انجام نمی‌شود.
