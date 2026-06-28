## Win11 Window Tiling v1.0.1

Windows 11-style window tiling for Linux — GNOME and KDE, on Debian, Fedora, RHEL, and Arch.

### What's included

- Pre-built packages for **8 distro/desktop combos** (`.deb`, `.rpm`, Arch `.pkg.tar.gz`)
- **Auto-detect** Debian package for mixed GNOME/KDE setups
- Per-edition user manuals (Markdown + RTF) plus a quick-start **PDF**
- Full source build trees for every edition
- **Win11-tiling_1.0.1.zip** — all-in-one download

### Install

1. Download the package for your distro below (or grab **Win11-tiling_1.0.1.zip**)
2. Install it (`dpkg -i`, `dnf install`, or `pacman -U`)
3. Run `win11-tiling-setup`
4. Log out and back in

**Debian GNOME quick start:**

```bash
sudo dpkg -i win11-window-tiling-gnome_1.0.0_all.deb
sudo apt-get install -f
win11-tiling-setup
```

### Features

- Snap layouts and Fancy Zones (GNOME via Tiling Shell)
- Super + Arrow keyboard shortcuts
- Edge snapping for halves and quarters
- KDE edition with KZones

GPL-3.0-or-later