<div dir="rtl">

# تست و نگهداری

اجزای بسته و منبع نمودارها در [معماری](architecture.md) و ناوبری پیش‌نویس Wiki در [خانهٔ Wiki](wiki/Home.md) قرار دارند. مستندات انسانی docs و Wiki توسط installer به مقصد کپی نمی‌شوند.

برای تفسیر Changed/Skipped/Failed، حذف fixtureهای تست و checkout موقت و نگهداری backupها، [راهنمای پس از نصب](post-installation.md) را بخوانید. حذف فایل‌های موقت با حذف skillهای نصب‌شده متفاوت است.

## پاک‌سازی repository و Git

کپی قدیمی `.ai-audit/core/enterprise-audit.md` فقط وقتی قابل حذف است که محتوا با `core/enterprise-audit.md` یکسان باشد و دستورالعمل‌های فعال به مسیر جدید ارجاع دهند. پوشه‌های خالی و خروجی‌های موقتِ بررسی‌شده را می‌توان حذف کرد؛ backup دارای محتوای متفاوت را صرفاً به دلیل قدیمی‌بودن حذف نکنید.

نسخه‌های `.agents/skills` و `.antigravity/skills` برای سازگاری و تست adapterها نگه داشته می‌شوند؛ تکرار محتوا به‌تنهایی نشانهٔ زائدبودن نیست. مستندات فارسی/انگلیسی، فایل‌های مجوز، تست‌ها و تنظیمات CI نیز بخشی از بسته‌اند.

پاک‌سازی Git با ثبت حذف فایل‌های واقعاً زائد در commit و push معمولی انجام می‌شود. فایل‌های ignored محلی از قبل در Git ثبت نشده‌اند و حذفشان روی GitHub تغییری ایجاد نمی‌کند. حذف شاخه‌ها، tagها، Releaseها یا بازنویسی تاریخچه کار جداگانه‌ای است و صرفاً برای پاک‌سازی فایل‌های موقت لازم نیست.

<div dir="ltr">

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tests/install.ps1
```

</div>

<div dir="ltr">

```bash
bash -n install.sh
bash tests/install.sh
```

</div>

تست‌ها مقصد موقت می‌سازند و fixtureها را برای بررسی نگه می‌دارند. نصب global در home موقت با UserHome / --home اجرا می‌شود و به home واقعی کاربر دست نمی‌زند. همهٔ مسیرهای native، انتخاب agent/skill و نصب تکراری بررسی می‌شوند. موفقیت این تست‌ها رفتار installer را تأیید می‌کند؛ کیفیت پاسخ همهٔ مدل‌ها یا discovery واقعی محصولات مقصد را اثبات نمی‌کند.

منبع ده skill تکمیلی `.agents/skills/<name>/SKILL.md` و منبع پروتکل پایه `core/enterprise-audit.md` است. نسخهٔ enterprise-audit در مسیرهای skill باید frontmatter شامل name و description داشته باشد. adapterهای Antigravity موجود باید با منبع متناظر همگام شوند. تغییر فهرست skillها باید در هر دو installer، help، تست‌ها و راهنما منعکس شود.

برای validation رسمی از `quick_validate.py` در skill-creator نصب‌شده استفاده کنید؛ این ابزار جزو این repository نیست و Python/PyYAML می‌خواهد. آزمون رفتاری را با یک گزارش واقعی یا fixture جدا اجرا کنید: اصلاح باید نقص واقعی را رفع کند، review بدون مجوز نباید ویرایش کند، حلقه باید روی blocker نتیجهٔ ناقص بدهد، و ترکیب نباید چند حلقهٔ تو در تو بسازد.

Git محلی تغییرات را ثبت می‌کند. نسخه را در VERSION و CHANGELOG هماهنگ کنید و پیش از commit checks را اجرا کنید. remote/push و tag انتشار خودکار نیستند. برای rollback installer از backup مستقل استفاده کنید؛ برای rollback کد از commit مناسب و روش سازگار با تغییرات محلی استفاده کنید.

## بررسی مستندات

پس از تغییر، مسیرها و anchorهای نسبی، جفت‌بودن fenceها، ناوبری README/Wiki و تطبیق مثال‌ها با گزینه‌های واقعی installer را بررسی کنید. دادهٔ تست یا secrets را وارد مستندات نکنید. Release noteهای قدیمی گزارش تاریخی‌اند؛ قابلیت منتشرنشده را به آن‌ها نسبت ندهید.

منبع سه نمودار Mermaid در `docs/architecture.md` است. در این repository دستور build/render مستندات و renderer همراه بسته وجود ندارد؛ CI فعلی نیز render نمودار را انجام نمی‌دهد. در صورت استفاده از preview یا ابزار اختیاری، نتیجهٔ render و نسخهٔ ابزار را جداگانه ثبت کنید. جزئیات وضعیت بررسی در همان صفحهٔ معماری آمده است.

</div>
