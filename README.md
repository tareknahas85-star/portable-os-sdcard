# Portable OS on SD Card

Build guide + scripts for turning a 128GB SD card into a full, bootable "laptop in your pocket": a real Ubuntu Server install (not live/persistence) that boots on any x86_64 machine (BIOS or UEFI), a lightweight Openbox desktop, and a LUKS-encrypted data partition.

## Contents

- [`01-Build-Guide.md`](./01-Build-Guide.md) — full build guide (partitioning, hybrid BIOS+UEFI boot, LUKS setup, SD card longevity tips), written in Arabic.
- [`02-post-install-setup.sh`](./02-post-install-setup.sh) — one-shot post-install script: installs Openbox + tint2 + rofi + lightdm + NetworkManager + zram, configures the desktop session.
- [`autoinstall-user-data.yaml`](./autoinstall-user-data.yaml) — cloud-init/subiquity autoinstall template for automating the install. **Contains placeholder values only** (`CHANGE_ME_HASH_NOT_PLAINTEXT`, `CHANGE_ME_TEMPORARY_PASSPHRASE`) — edit the disk `path`, the user password hash, and the LUKS passphrase before use, and rotate the LUKS key immediately after first boot.

## Highlights

- 4-partition GPT layout: `bios_grub` (1MB) + EFI System Partition (512MB) + unencrypted root (20GB, ext4) + LUKS-encrypted data partition (rest of the disk).
- Manual hybrid-boot step (`grub-install --target=i386-pc`) so the card boots on both legacy BIOS and modern UEFI machines.
- zram instead of disk swap, `noatime`, and `fstrim.timer` to protect SD card lifespan.
- Data partition is separate from the OS partition, so a reinstall/distro change never touches your encrypted data.

⚠️ **Before using the autoinstall template on real hardware:** test it on a VM or spare disk first — a wrong disk match can wipe the wrong drive.
