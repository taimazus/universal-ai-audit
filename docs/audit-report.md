<div dir="rtl">

# گزارش ممیزی و حلقهٔ رفع یافته‌ها

این گزارش snapshot پایان عملیات ممیزی و اصلاح است؛ جمله‌های مربوط به نسخه و Git وضعیت همان مرحله را ثبت می‌کنند. به‌روزرسانی بعدی نسخه به 1.5.0 و همگام‌سازی Git در [تاریخچهٔ تغییرات](../CHANGELOG.fa.md) ثبت می‌شود.

مبنای ممیزی: commit `e98b626e5247602c1bb268bbcc8a27019ccfe531` و گزارش همین گفتگو؛ فایل گزارش قبلاً وجود نداشت. دامنهٔ بازبینی نهایی: کل سطح کد، تنظیمات، اسکیل‌ها و مستندات توزیع‌شدهٔ repository. تاریخ: ۲۰۲۶-۱۰-۰۲.

هدف بسته، توزیع ده اسکیل و نصب انتخابی پروژه‌ای/سراسری است. stack: PowerShell، Bash، Git، Markdown و GitHub Actions. منابع اصلی: `core/enterprise-audit.md` و `.agents/skills`؛ installerها adapterها را در مقصد می‌نویسند. bootstrapها checkout دریافت‌شده را اجرا می‌کنند.

## فهرست یکپارچهٔ یافته‌ها

شماره‌خط‌های «شواهد اولیه» به commit مبنا تعلق دارند؛ «محل اصلاح» به فایل‌های فعلی اشاره دارد.

| ID | شدت | طبقهٔ شواهد | شواهد اولیه و سناریوی شکست | وضعیت و محل اصلاح | تأیید |
| --- | --- | --- | --- | --- | --- |
| F1 | MEDIUM | Proven defect | `install.ps1:50` و `install.ps1:52`: تبدیل مسیر کامل به نام backup؛ نصب اولیه در مسیر بلند موفق ولی ارتقا با خطای طول مسیر شکست می‌خورد. در بازتولید اولیه مسیر مقصد ۲۴۶ و نام backup ۲۷۹ کاراکتر بود. | fixed؛ `install.ps1:35` و `install.ps1:54`: شناسهٔ کوتاه، فایل `.path` برای مسیر اصلی و fallback اعلام‌شده در Temp. | `tests/install.ps1:79`: نصب و ارتقای مسیر بلند، محتوای backup، نگاشت مسیر اصلی و نصب تکراری بدون backup جدید؛ PASS. |
| F2 | LOW | Proven defect | `install.sh:72` و `install.sh:82`: Force روی فایل یکسان دوباره می‌نویسد و backup اضافه می‌سازد؛ نصب دوم در fixture نیز Changed=1 بود. | fixed؛ `install.sh:72` و `install.sh:73`: بررسی محتوا قبل از Force؛ خطای خواندن نیز ثبت می‌شود. | `tests/install.sh:23` و `tests/install.sh:80`: حفظ backup واقعی و عدم تغییر مجموعهٔ فایل‌ها پس از Force تکراری؛ PASS. |
| F3 | LOW | Proven defect | `README.md:13`: اجرای مستقیم فایل Bash با Git mode برابر 100644؛ در checkout استاندارد Unix فایل executable نیست. شواهد اولیه metadata بود، نه اجرای Linux. | fixed؛ `README.md:13` و مثال‌های نصب انتخابی: فراخوانی با bash. | مثال‌ها به bash اصلاح شدند؛ Bash syntax و تست کامل installer موفق بود. اجرای Linux واقعی در این نوبت انجام نشد. |
| F4 | LOW | Proven defect | یافتهٔ جدید چرخهٔ اول: `docs/combinations.md:52` تا خط 55 در مبنا، مثال «ده اسکیل» فقط هشت نام داشت. | fixed؛ `docs/combinations.md:53` و `docs/combinations.md:57`: هماهنگ‌کننده و ثبت محلی Git با منع انتشار اضافه شدند. | بررسی بلوک مثال در برابر نام هر ده اسکیل؛ PASS. |
| R1 | MEDIUM | Architecture/scalability risk | `install.ps1:62` و `install.sh:90` فعلی: نوشتن مستقیم مقصد، بدون تراکنش کل نصب؛ قطع پردازش یا خطای دیسک ممکن است فایل ناقص یا نصب نیمه‌کاره باقی بگذارد. | unresolved risk؛ خرابی واقعی بازتولید نشده و نقص اثبات‌شده محسوب نمی‌شود. | پیشنهاد: تزریق خطای نوشتن در fixture، بررسی سلامت نسخهٔ قبلی و rollback؛ سپس طراحی جایگزینی اتمیک و manifest نصب. |
| R2 | MEDIUM | Architecture/scalability risk | `.github/workflows/ci.yml:31`، خط 61 و خط 82: تست‌های موجود installerها را پوشش می‌دهند، نه مسیر اجرای bootstrap از Git. | unresolved risk؛ خرابی فعلی bootstrapها اثبات نشده است. | پیشنهاد: repository محلی با branch/tag؛ clone ناموفق، installer مفقود، انتقال گزینه‌ها و exit code. parser bootstrapها بررسی شد؛ integration جدید اضافه نشد. |

## چرخه‌ها و نتیجه

۱. تطبیق گزارش با کد؛ رفع F1 تا F3، افزودن regressionها و اجرای آن‌ها؛ بازبینی بعدی F4 را پیدا کرد.

۲. رفع F4 و همگام‌سازی راهنمای بازیابی و changelog منتشرنشده؛ بررسی لینک‌ها، بلوک‌های Markdown و مثال ده اسکیل.

۳. بازبینی کامل سطح توزیع‌شده و diff نهایی؛ نقص actionable جدیدی شناسایی نشد. چهار نقص تأییدشده رفع شدند؛ دو ریسک اولیه همچنان صریح و جدا ثبت شده‌اند. این نتیجه تضمین نبود تمام باگ‌های ممکن نیست.

## checks واقعی

- `powershell.exe -NoProfile -ExecutionPolicy Bypass -File tests/install.ps1`: exit 0 و PASS، شامل regression مسیر بلند.
- `bash tests/install.sh`: exit 0 و PASS، شامل تکرار Force در نصب سراسری.
- parser اسکریپت‌های PowerShell؛ `bash -n` برای installer، bootstrap و تست Bash: PASS.
- لینک‌های نسبی و جفت‌بودن fenceهای Markdown؛ برابری adapterهای `.agents` و `.antigravity` و حضور ده نام در یک مثال: PASS.
- `git diff --check`: PASS.

## محدودیت و بازیابی

اجرا روی Windows و Git Bash بود؛ macOS، Linux واقعی، discovery محصول و رفتار مدل‌ها، آخرین CI خارجی و خرابی دیسک/شبکه/نصب هم‌زمان بررسی اجرایی نشدند. fixtureها خارج از repository نگه داشته شده‌اند. backupهای قدیمی سازگار و دست‌نخورده‌اند؛ backup جدید با شناسهٔ کوتاه، محتوای اصلی و فایل مسیر متناظر بازیابی می‌شود. fallback در Temp باید پیش از پاک‌سازی Temp به محل دائمی منتقل شود.

نسخه تغییر نکرد؛ changelog در بخش منتشرنشده به‌روز شد. این کار commit، push، tag یا Release ایجاد نمی‌کند. وضعیت نهایی: نقص تأییدشدهٔ باز باقی نمانده؛ R1/R2 کار پیشنهادی آینده و محدودیت پوشش‌اند.

</div>
