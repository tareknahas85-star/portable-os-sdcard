#!/usr/bin/env bash
# =============================================================================
# 02-post-install-setup.sh
# يشغّل مرة وحدة بعد أول إقلاع ناجح لنظام Ubuntu Server المثبت على الـ SD Card.
# بيركب واجهة رسومية خفيفة (Openbox) + أدوات أساسية + zram + إعدادات لحماية
# عمر الـ SD Card. شغّله بصلاحيات root:
#
#   chmod +x 02-post-install-setup.sh
#   sudo ./02-post-install-setup.sh
#
# لازم اتصال إنترنت فعّال وقت التشغيل (الأسهل: كيبل إيثرنت أول مرة).
# =============================================================================

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "شغّل هاد السكربت بصلاحيات root: sudo ./02-post-install-setup.sh" >&2
  exit 1
fi

TARGET_USER="${SUDO_USER:-$(logname 2>/dev/null || echo "")}"
if [[ -z "$TARGET_USER" ]]; then
  read -rp "اكتب اسم المستخدم العادي (مو root) يلي رح يشتغل عليه سطح المكتب: " TARGET_USER
fi
USER_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)

echo "==> تحديث النظام"
apt update
apt -y upgrade

echo "==> تنصيب واجهة Openbox والأدوات الأساسية"
apt install -y \
  openbox obconf \
  tint2 \
  pcmanfm \
  lxterminal \
  rofi \
  lightdm lightdm-gtk-greeter \
  network-manager network-manager-gnome \
  xfce4-power-manager \
  pulseaudio pavucontrol \
  polkitd pkexec lxpolkit \
  feh \
  xorg \
  fonts-dejavu \
  zram-config \
  unzip curl wget nano

echo "==> تفعيل lightdm كمدير دخول افتراضي (وتعطيل gdm3 اذا انزرع كـ dependency)"
systemctl stop gdm3 2>/dev/null || true
systemctl disable gdm3 2>/dev/null || true
systemctl mask gdm3 2>/dev/null || true
rm -f /etc/systemd/system/display-manager.service
echo "/usr/sbin/lightdm" > /etc/X11/default-display-manager
systemctl enable lightdm

echo "==> إعداد جلسة Openbox"
mkdir -p "$USER_HOME/.config/openbox"
cat > "$USER_HOME/.config/openbox/autostart" <<'EOF'
# يشتغل تلقائياً وقت بدء جلسة Openbox
tint2 &
nm-applet &
lxpolkit &
xfce4-power-manager &
pcmanfm --desktop &
EOF

mkdir -p "$USER_HOME/.config/tint2"
cat > "$USER_HOME/.config/tint2/tint2rc" <<'EOF'
# إعداد بسيط لـ tint2: taskbar + ساعة، بدون تعقيد
panel_items = TSC
taskbar_mode = single_desktop
clock_format = %H:%M
clock_font = Sans 10
EOF

echo "==> ربط مفتاح Super+D لفتح rofi (قائمة برامج) داخل Openbox"
mkdir -p "$USER_HOME/.config/openbox"
RC_FILE="/etc/xdg/openbox/rc.xml"
if [[ -f "$RC_FILE" ]] && ! grep -q "rofi -show" "$RC_FILE"; then
  cp "$RC_FILE" "$USER_HOME/.config/openbox/rc.xml"
  sed -i 's#</keyboard>#  <keybind key="W-d"><action name="Execute"><command>rofi -show drun</command></action></keybind>\n</keyboard>#' \
    "$USER_HOME/.config/openbox/rc.xml"
fi

chown -R "$TARGET_USER":"$TARGET_USER" "$USER_HOME/.config"

echo "==> ربط مجلد الداتا المشفّرة (/mnt/data) بمجلد سهل بالـ home"
if [[ -d /mnt/data ]]; then
  ln -sfn /mnt/data "$USER_HOME/Work"
  chown -h "$TARGET_USER":"$TARGET_USER" "$USER_HOME/Work"
fi

echo "==> تفعيل zram (سواب بالذاكرة بدل الكتابة عالكارت)"
systemctl enable zram-config 2>/dev/null || true

echo "==> تقليل الكتابة على الـ SD Card: noatime + fstrim"
if ! grep -q "noatime" /etc/fstab; then
  sed -i 's/\(ext4[[:space:]]*errors=remount-ro\)/\1,noatime/' /etc/fstab || true
fi
systemctl enable fstrim.timer 2>/dev/null || true

echo "==> تفعيل NetworkManager (يدير الويايفاي والإيثرنت تلقائياً على أي جهاز)"
systemctl enable NetworkManager
systemctl start NetworkManager || true

echo ""
echo "===================================================================="
echo "خلص التنصيب الأساسي. الخطوات المتبقية (يدوية، مرة وحدة):"
echo "  1) فعّل الإقلاع الهجين BIOS+UEFI — شوف القسم 4 بملف 01-Build-Guide.md"
echo "  2) غيّر كلمة سر الـ LUKS من القيمة المؤقتة:"
echo "       sudo cryptsetup luksChangeKey /dev/sdX4"
echo "  3) أعد التشغيل: sudo reboot"
echo "===================================================================="
