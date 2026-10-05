<div lang="fa" dir="rtl" align="right">

# گزارش پیاده‌سازی و بازبینی مهارت‌ها — ۲۰۲۶-۱۰-۰۵

[English](skill-suite-review.en.md) · [ابزارها](skill-tooling.fa.md) · [۳۶ سناریو](prompt-library.fa.md)

دامنه: working tree فعلی، ۲۱ مهارت و منابعشان، قراردادها و adapterهای تولیدشده، نصب‌کننده‌های PowerShell/Bash، bootstrapهای Git، تست‌ها، CI و مستندات مرتبط. اصلاحات قبلی کاربر و وضعیت staging حفظ شدند؛ commit، push، Release یا نصب واقعی سراسری انجام نشد. نسخهٔ `VERSION` تغییر نکرد؛ قابلیت‌های جدید در بخش منتشرنشدهٔ changelog ثبت شدند.

پیاده‌سازی شامل هشت مهارت تخصصی جدید، معیار پایان مهارت‌ها، حافظهٔ تراکنشی و schema نسخه‌دار، ثبت پاسخ با منبع/دامنه/شرایط/fingerprint، تولید adapterها از منبع اصلی، منابع تخصصی چهار stack، نصب منابع اجرایی، fixture/runner ارزیابی و checks جدید CI است. این گزارش اجرای ابزارها را از اجرای agent واقعی جدا می‌کند.

## فهرست یافته‌های رفع‌شده

طبقهٔ همهٔ موارد زیر `Proven defect` است. محل‌ها به اصلاح فعلی اشاره دارند؛ نقص‌ها در نسخه‌های میانی همین کار بررسی یا بازتولید و سپس رفع شدند. هیچ ریسک نظری به‌عنوان نقص قطعی شمارش نشده است.

| ID | شدت | سناریو/اثر | محل اصلاح | تأیید |
| --- | --- | --- | --- | --- |
| U1 | MEDIUM | payload نامعتبر ذخیره‌شده می‌توانست بدون اعتبارسنجی به‌عنوان وضعیت معتبر خوانده شود. | `project-context/scripts/task_state.py:195` | `test_invalid_saved_payload_is_not_reused` |
| U2 | LOW | شرایط lookup غیرساختاریافته به‌جای خطای ورودی، نتیجهٔ stale می‌داد. | `project-context/scripts/task_state.py:249` | `test_invalid_conditions_rejected` |
| U3 | MEDIUM | حفظ یک فایل و ادعای product_changed=false، ایجاد فایل محصول غیرمجاز در review را کشف نمی‌کرد. | `skill-evaluation/scripts/evaluate.py:47` | `test_readonly_case_catches_unreported_new_product_file` |
| U4 | MEDIUM | init می‌توانست پایگاه SQLite ناشناخته را با metadata این ابزار تطبیق دهد. | `project-context/scripts/task_state.py:146` | `test_init_does_not_adopt_unrecognized_existing_database` |
| U5 | MEDIUM | parent linked خروجی generator می‌توانست مقصد را از مسیر مورد نظر منحرف کند. | `tools/generate_adapters.py:21` | `test_linked_output_parent_cannot_escape_repository` |
| U6 | LOW | مسیر پروفایل ممیزی در نصب portable توزیع نشده بود. | `install.ps1:101` و توزیع `core/references` در Bash | آزمون hash پروفایل portable در هر دو suite نصب |
| U7 | MEDIUM | show رکورد فارسی روی خروجی ASCII/Windows legacy با UnicodeEncodeError شکست می‌خورد؛ قبل از اصلاح exit=1 بازتولید شد. | `project-context/scripts/task_state.py:307` | `test_unicode_state_can_be_read_on_ascii_console` |
| U8 | LOW | نصب Bash، CR نهایی منبع CRLF را حذف می‌کرد؛ hash منبع و نصب متفاوت می‌شد. | `install.sh:97`، حالت verbatim برای resource | آزمون CRLF/no-final-newline و نصب تکراری |
| U9 | MEDIUM | شرط complete، پایان درست کار read-only با یافتهٔ گزارش‌شدهٔ باز را هم رد می‌کرد. | mode و checks.required در validator و schema | `test_review_completion_preserves_open_findings_and_optional_blocked_checks`؛ تطبیق ۷۲ ترکیب schema/runtime |
| U10 | LOW | ورودی JSON با UTF-8 نامعتبر به‌جای خطای کنترل‌شده traceback می‌داد. | `project-context/scripts/task_state.py:309` | `test_invalid_input_encoding_fails_cleanly_without_mutation` |

`project-context/scripts/...` و `skill-evaluation/scripts/...` در جدول نسبت به `.agents/skills/` هستند. تست‌ها در [test_task_state.py](../tests/test_task_state.py)، [test_evaluation.py](../tests/test_evaluation.py) و [test_adapters.py](../tests/test_adapters.py) قرار دارند.

## نتیجهٔ checks

| بررسی | نتیجه |
| --- | --- |
| Python unittest | ۳۳ تست موفق، شامل process/concurrency/rollback، پاسخ‌ها، scope و oracle |
| JSON Schema | schema معتبر Draft 2020-12؛ ۷۲ ترکیب mode/check/finding با validator اجرایی یکسان |
| generator parity | موفق؛ تمام مهارت‌ها و منابع adapter تطبیق دارند |
| مستندات | موفق؛ کاتالوگ، گزینه‌های installer، زبان‌ها، منابع، لینک‌ها و بلوک‌ها بررسی شدند |
| quick_validate | ۴۲ فایل مهارت معتبر؛ ابزار رسمی محلی، با وابستگی موقت و جدا |
| PowerShell installer | suite کامل موفق، شامل تطابق منابع و اجرای helper نصب‌شده |
| Bash installer | suite کامل Git Bash موفق، شامل حفظ CRLF/no-final-newline و نصب تکراری |
| آماده‌سازی ارزیابی agent | ۷ fixture با status=prepared؛ مدل واقعی اجرا نشده است |

سه مرحلهٔ بازبینی انجام شد: پیاده‌سازی و بررسی قراردادها؛ آزمون شکست/بازیابی و اصلاح نقص‌های ابزار؛ بازبینی دامنه/منابع/portability و checks نهایی. خروجی‌های ردشدن عمدی مانند STALE و linked-path در تست‌های منفی، شکست suite محسوب نمی‌شوند. checks نهایی موفق بودند؛ در دامنهٔ بررسی‌شده نقص قابل اقدام تازه‌ای پیدا نشد.

## ریسک‌ها و محدودیت پوشش

- آزمون ابزار و ساخت fixture، رفتار همهٔ مدل‌ها یا discovery واقعی همهٔ محصولات را اثبات نمی‌کند. runner واقعی برای ارزیابی مدل تنظیم نشده؛ همهٔ ۲۱ مهارت سناریوی مدل اجراشده ندارند.
- hosted CI و اجرای native Linux/macOS در این محیط اجرا نشده‌اند. Bash با Git Bash روی Windows بررسی می‌شود؛ matrix مربوط در CI تعریف شده است.
- rendering بصری Markdown/Mermaid، screen-reader و integration واقعی UI بررسی نشده‌اند. متن، لینک و ساختار کنترل شده است.
- دو ریسک تاریخی [گزارش قبلی](audit-report.md) همچنان تفکیک می‌شوند: نصب کل بسته تراکنش سراسری ندارد و integration bootstrap از Git پوشش مستقلی ندارد. در این نوبت خرابی واقعی تازه‌ای برای آن‌ها بازتولید نشد؛ ریسک یا شکاف آزمون‌اند.
- SQLite دادهٔ تراکنشی و revision را حفظ می‌کند؛ راست‌بودن پاسخ کاربر، نبود همهٔ secrets یا صحت ادعای تست را به‌تنهایی ثابت نمی‌کند. یادداشت‌ها مجوز عملیات جدید نیستند و فایل‌های قابل دسترسی برای بازیابی لازم‌اند.

وضعیت فعلی: اصلاحات تأییدشده رفع شده‌اند؛ نتیجهٔ checks نهایی و محدودیت‌های بالا ملاک بررسی‌اند. این گزارش تضمین نبود تمام اشکالات ممکن نیست.

</div>
