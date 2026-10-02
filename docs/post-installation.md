<div dir="rtl">

# بررسی و پاک‌سازی پس از نصب

## خواندن نتیجهٔ نصب

نمونه: `Changed=2 Skipped=108 Failed=0` یعنی دو عملیات نوشتن انجام شده، ۱۰۸ عملیات کنار گذاشته شده و خطای ثبت‌شده‌ای وجود ندارد. `Skipped` معمولاً شامل فایل‌های یکسان است، اما می‌تواند شامل فایل‌های موجودِ حفظ‌شده بدون Force یا عملیات ردشده با WhatIf هم باشد؛ پیام‌های همان اجرا را بررسی کنید. در DryRun، مقدار Changed تعداد تغییرات پیشنهادی است، نه فایل‌های نوشته‌شده. Force فایل یکسان را دوباره نمی‌نویسد.

پیام‌های `What if` و `[DRY]` پیش‌نمایش هستند. پیام `PASS: PowerShell installer regressions` موفقیت تست‌های installer را نشان می‌دهد؛ نصب در حساب واقعی یا شناسایی skillها توسط همهٔ agentها را ثابت نمی‌کند. پس از نصب، agent مقصد را دوباره باز کنید و شناسایی skill موردنظر را در همان محصول بررسی کنید.

## چه چیزهایی را می‌توان حذف کرد؟

پس از نصب موفق، checkout موقت نمایش‌داده‌شده در `[SOURCE]` و فایل دانلودشدهٔ `install-from-git.ps1` یا `install-from-git.sh` برای اجرای skillهای کپی‌شده لازم نیستند. برای نصب بعدی می‌توانید bootstrap را دوباره دانلود کنید. اگر نصب شکست خورده است، ابتدا checkout و خروجی را برای بررسی نگه دارید.

قبل از حذف، مطمئن شوید checkout موقت خودش مقصد نصب پروژه‌ای نبوده و هیچ تغییر شخصی در آن ندارید. پوشه‌های مقصد skillها را حذف نکنید؛ مسیرهای لازم در [نصب سراسری](global-installation.md) آمده‌اند. کل پوشه‌های `.agents`، `.claude`، `.cursor`، `.gemini` و مسیرهای مشابه ممکن است تنظیمات و skillهای دیگر هم داشته باشند.

### Windows / PowerShell

مسیر زیر نمونهٔ یک checkout است؛ آن را با مسیر دقیق `[SOURCE]` اجرای خودتان جایگزین کنید. ابتدا مسیر کامل و محتوا را بررسی کنید؛ سپس پیش‌نمایش حذف و در نهایت حذف واقعی را اجرا کنید. از wildcard و حذف کل Temp استفاده نکنید.

<div dir="ltr">

```powershell
$CheckoutToRemove = 'C:\Users\Taimazus\AppData\Local\Temp\universal-ai-audit-16c28a818bdd4ec4a1c053e200b9ffbc'
Get-Item -LiteralPath $CheckoutToRemove | Select-Object FullName
Get-ChildItem -LiteralPath $CheckoutToRemove -Force
Remove-Item -LiteralPath $CheckoutToRemove -Recurse -Force -WhatIf
# After checking the exact target:
Remove-Item -LiteralPath $CheckoutToRemove -Recurse -Force
```

```powershell
# Optional: only if this is the downloaded bootstrap file you no longer need.
Remove-Item -LiteralPath 'C:\Users\Taimazus\install-from-git.ps1' -WhatIf
Remove-Item -LiteralPath 'C:\Users\Taimazus\install-from-git.ps1' -Force
```

</div>

### Linux / macOS / WSL

مسیر کامل و دقیق `[SOURCE]` را جایگزین نمونه کنید و محتوای آن را پیش از حذف بررسی کنید. این دستور فقط برای checkout موقتِ تأییدشده است.

<div dir="ltr">

```bash
checkout_to_remove='/tmp/universal-ai-audit.REPLACE_WITH_ACTUAL_ID'
ls -ld -- "$checkout_to_remove"
ls -la -- "$checkout_to_remove"
# After checking the exact target:
rm -r -- "$checkout_to_remove"
# Optional: run from the directory containing the downloaded bootstrap.
rm -i -- ./install-from-git.sh
```

</div>

## backup، fixture تست و checkout توسعه

نسخه‌های backup را تا تأیید عملکرد و پایان نیاز به rollback نگه دارید. پس از آن فقط backupهای مشخص و بررسی‌شده را حذف کنید؛ حذفشان امکان بازیابی آن نسخه را از بین می‌برد. محل و روش بازیابی در [راهنمای نصب](installation.md) آمده است.

PowerShell برای مسیرهای بلند ممکن است backup را در Temp نگه دارد؛ پیام `[BACKUP]` محل دقیق را نشان می‌دهد و فایل `.path` مسیر اصلی را ثبت می‌کند. پیش از پاک‌سازی Temp، backup موردنیاز و فایل مسیرش را به محل دائمی منتقل کنید. حذف checkout نمایش‌داده‌شده در `[SOURCE]` با حذف پوشهٔ جداگانهٔ backup متفاوت است.

تست‌ها fixtureها را در پوشهٔ موقت نگه می‌دارند. پس از پایان بررسی می‌توانید فقط پوشهٔ مشخص همان اجرای تست را، با بررسی مسیر کامل و همان روش بالا، حذف کنید. این‌ها با نصب واقعی سراسری متفاوت‌اند.

checkout کاری پروژه، مانند `Desktop/universal-ai-audit`، فایل موقت نصب نیست. برای توسعه و کار با Git آن را نگه دارید. در نصب صرفاً سراسری، فایل‌های نصب‌شده به checkout منبع وابسته نیستند؛ حذف checkout منبع نیاز به دانلود مجدد برای توسعه یا به‌روزرسانی محلی دارد. در نصب پروژه‌ای، فایل‌های نصب‌شده در پروژهٔ مقصد باید حفظ شوند.

## ورود به GitHub CLI

برای دریافت repository عمومی و نصب از Git، ورود با GitHub CLI لازم نیست. اگر برای مدیریت GitHub به ورود نیاز دارید، دستور صحیح `gh auth login` است؛ `gh login` معتبر نیست. اجرای `gh pr` به‌تنهایی فقط راهنما را نمایش می‌دهد و PR نمی‌سازد.

<div dir="ltr">

```powershell
gh auth login
gh auth status
```

</div>

پیام ورود موفق و Active account وضعیت احراز هویت را نشان می‌دهند؛ به معنی commit، push یا ایجاد Release نیستند. هنگام ارسال خروجی برای بررسی، token را منتشر نکنید.

</div>
