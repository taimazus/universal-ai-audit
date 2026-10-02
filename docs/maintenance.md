# تست و نگهداری

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File tests/install.ps1
```

```bash
bash -n install.sh
bash tests/install.sh
```

تست‌ها مقصد موقت می‌سازند و fixtureها را برای بررسی نگه می‌دارند. نصب global در home موقت با UserHome / --home اجرا می‌شود و به home واقعی کاربر دست نمی‌زند. همهٔ مسیرهای native، انتخاب agent/skill و نصب تکراری بررسی می‌شوند. موفقیت این تست‌ها رفتار installer را تأیید می‌کند؛ کیفیت پاسخ همهٔ مدل‌ها یا discovery واقعی محصولات مقصد را اثبات نمی‌کند.

منبع هفت skill تکمیلی `.agents/skills/<name>/SKILL.md` و منبع پروتکل پایه `core/enterprise-audit.md` است. نسخهٔ enterprise-audit در مسیرهای skill باید frontmatter شامل name و description داشته باشد. adapterهای Antigravity موجود باید با منبع متناظر همگام شوند. تغییر فهرست skillها باید در هر دو installer، help، تست‌ها و راهنما منعکس شود.

برای validation رسمی از `quick_validate.py` در skill-creator نصب‌شده استفاده کنید؛ این ابزار جزو این repository نیست و Python/PyYAML می‌خواهد. آزمون رفتاری را با یک گزارش واقعی یا fixture جدا اجرا کنید: اصلاح باید نقص واقعی را رفع کند، review بدون مجوز نباید ویرایش کند، حلقه باید روی blocker نتیجهٔ ناقص بدهد، و ترکیب نباید چند حلقهٔ تو در تو بسازد.

Git محلی تغییرات را ثبت می‌کند. نسخه را در VERSION و CHANGELOG هماهنگ کنید و پیش از commit checks را اجرا کنید. remote/push و tag انتشار خودکار نیستند. برای rollback installer از backup مستقل استفاده کنید؛ برای rollback کد از commit مناسب و روش سازگار با تغییرات محلی استفاده کنید.
