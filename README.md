# Portable OS on an SD Card

**[⬇️ Download the setup script](https://raw.githubusercontent.com/tareknahas85-star/portable-os-sdcard/main/02-post-install-setup.sh)** &nbsp;|&nbsp; **[⬇️ نزّل سكربت الإعداد](https://raw.githubusercontent.com/tareknahas85-star/portable-os-sdcard/main/02-post-install-setup.sh)**

---

## In English

A guide and scripts to turn a 128GB SD card into a computer you carry in your pocket.

It is a real Ubuntu system on the card, not a live or test copy. You put the card in almost any computer and it starts your own system, with your own files and programs. The desktop is light and fast, and your files are kept in a locked part of the card that nobody can open without your password.

### The files here

- [`01-Build-Guide.md`](./01-Build-Guide.md) is the full guide, step by step
- [`02-post-install-setup.sh`](./02-post-install-setup.sh) is a script you run after the install. It sets up the desktop, the network and the rest
- [`autoinstall-user-data.yaml`](./autoinstall-user-data.yaml) is a ready file that installs the system for you. **It has empty values inside** (`CHANGE_ME_HASH_NOT_PLAINTEXT` and `CHANGE_ME_TEMPORARY_PASSPHRASE`). Put your own values before you use it

### Good to know

- The card is cut into 4 parts, so the system starts on old computers and new ones too
- Your files sit in their own locked part, away from the system part. If you install the system again later, your files stay safe
- Some settings are added to make the card live longer, because SD cards get tired from too much writing

⚠️ **Before you run this on a real computer:** try it first on a test machine or an empty disk. If you pick the wrong disk by mistake, you can erase everything on it.

---

## بالعربي

دليل وسكربتات تحوّل كرت SD بحجم 128 جيجا إلى كمبيوتر تحمله في جيبك.

هو نظام أوبونتو حقيقي على الكرت، وليس نسخة تجريبية مؤقتة. تضع الكرت في أي كمبيوتر تقريباً فيقلع بنظامك أنت، بملفاتك وبرامجك. سطح المكتب خفيف وسريع، وملفاتك محفوظة في جزء مقفل من الكرت لا يستطيع أحد فتحه بدون كلمة السر.

### الملفات الموجودة هنا

- [`01-Build-Guide.md`](./01-Build-Guide.md) هو الدليل الكامل، خطوة بخطوة
- [`02-post-install-setup.sh`](./02-post-install-setup.sh) سكربت تشغّله بعد التنصيب. يجهّز لك سطح المكتب والشبكة وباقي الأمور
- [`autoinstall-user-data.yaml`](./autoinstall-user-data.yaml) ملف جاهز ينصّب لك النظام. **بداخله قيم فارغة** (`CHANGE_ME_HASH_NOT_PLAINTEXT` و `CHANGE_ME_TEMPORARY_PASSPHRASE`). ضع قيمك الخاصة قبل أن تستخدمه

### أشياء من الجيد معرفتها

- الكرت مقسوم إلى 4 أجزاء، لكي يقلع النظام على الأجهزة القديمة والحديثة معاً
- ملفاتك في جزء مقفل خاص بها، بعيداً عن جزء النظام. وإذا نصّبت النظام من جديد لاحقاً، تبقى ملفاتك سليمة
- أُضيفت بعض الإعدادات ليعيش الكرت مدة أطول، لأن كروت SD تتعب من كثرة الكتابة عليها

⚠️ **قبل أن تشغّل هذا على كمبيوتر حقيقي:** جرّبه أولاً على جهاز تجريبي أو قرص فارغ. فإذا اخترت القرص الخطأ بالغلط، قد تمسح كل ما عليه.
