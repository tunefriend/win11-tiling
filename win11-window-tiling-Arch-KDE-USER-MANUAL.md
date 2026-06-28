# win11-window-tiling — Arch Linux KDE Plasma User Manual

**Version 1.0.0 (Arch Linux KDE Plasma Edition)**

Windows 11-style window tiling for Arch Linux with KDE Plasma and KZones.

---

## Table of Contents

1. [Overview](#1-overview)
2. [Requirements](#2-requirements)
3. [Installation](#3-installation)
4. [First-Time Setup](#4-first-time-setup)
5. [Daily Use](#5-daily-use)
6. [Configuration](#6-configuration)
7. [Commands](#7-commands)
8. [Troubleshooting](#8-troubleshooting)
9. [Uninstalling](#9-uninstalling)
10. [Building from Source](#10-building-from-source)
11. [License](#11-license)

---

## 1. Overview

This package is built specifically for **Arch Linux with KDE Plasma**. It installs and configures **KZones**, a KWin script that brings Windows 11-style zone snapping to KDE.

### Features

| Feature | Description |
|---------|-------------|
| Zone snapping | Drag windows to screen edges to snap into zones |
| Fancy Zones style | Customizable zone layouts per monitor |
| Keyboard shortcuts | Super + arrow keys matching Windows 11 |
| Quarter tiling | Super + Shift + arrows for corner tiles |

### Package name

`win11-window-tiling-kde`

### Upstream project

KZones: https://github.com/gerritdevriese/kzones

---

## 2. Requirements

- **Arch Linux** with KDE Plasma (Plasma 6)
- **KWin** window manager
- Dependencies (installed automatically):
  - `plasma-workspace`
  - `kwin`
  - `dbus`
  - `bash`

---

## 3. Installation

### Step 1 — Copy the package to your Arch machine

Transfer the file:

`win11-window-tiling-kde-1.0.0-1-any.pkg.tar.zst`

(or `.pkg.tar.gz` if cross-built)

### Step 2 — Install with pacman

```bash
sudo pacman -U win11-window-tiling-kde-1.0.0-1-any.pkg.tar.zst
```

### Step 3 — Verify installation

```bash
pacman -Q win11-window-tiling-kde
```

Expected output: `win11-window-tiling-kde 1.0.0-1`

---

## 4. First-Time Setup

### Run setup

```bash
win11-tiling-setup
```

This copies KZones to your user profile, loads it in KWin, and configures Super+Arrow shortcuts.

### Log out and back in

### Verify

```bash
win11-tiling-setup --status
```

Check **System Settings → Window Management → KWin Scripts** for KZones.

---

## 5. Daily Use

### Keyboard shortcuts

| Shortcut | Action |
|----------|--------|
| Super + Left | Tile to left half |
| Super + Right | Tile to right half |
| Super + Up | Maximize |
| Super + Down | Minimize |
| Super + Shift + Left | Top-left quarter |
| Super + Shift + Right | Top-right quarter |
| Super + Shift + Down | Bottom-left quarter |
| Super + Shift + Up | Bottom-right quarter |

### Mouse

Drag windows to screen edges to snap into KZones.

### Command-line tiling

```bash
win11-tile left
win11-tile right
win11-tile top-left
win11-tile maximize
```

---

## 6. Configuration

### KZones zone layouts

**System Settings → Window Management → KWin Scripts → KZones → Configure**

### Keyboard shortcuts

**System Settings → Shortcuts → KWin** — search for **Window Quick Tile** actions.

---

## 7. Commands

| Command | Description |
|---------|-------------|
| `win11-tiling-setup` | Install and enable KZones |
| `win11-tiling-setup --status` | Show configuration status |
| `win11-tiling-setup --uninstall` | Remove KZones from user profile |
| `win11-tile <position>` | Manually tile the active window |

### win11-tile positions

`left`, `right`, `top`, `bottom`, `top-left`, `top-right`, `bottom-left`, `bottom-right`, `maximize`, `restore`

---

## 8. Troubleshooting

### KWin not found

```bash
sudo pacman -S plasma-workspace kwin
```

### Zones or shortcuts not working

```bash
win11-tiling-setup
```

Log out and back in. Check **System Settings → Shortcuts** for Meta key conflicts.

### Load KZones manually

```bash
qdbus6 org.kde.KWin /Scripting org.kde.kwin.Scripting.loadScript \
  ~/.local/share/kwin/scripts/kzones.kwinscript kzones
qdbus6 org.kde.KWin /Scripting org.kde.kwin.Scripting.runScript kzones
```

Use `qdbus` instead of `qdbus6` on older setups.

### Wrong edition installed

Use `win11-window-tiling-kde`, not `win11-window-tiling-gnome`.

---

## 9. Uninstalling

```bash
win11-tiling-setup --uninstall
sudo pacman -R win11-window-tiling-kde
```

Log out and back in.

---

## 10. Building from Source

On Arch Linux:

```bash
sudo pacman -S base-devel
cd arch-kde
./build.sh
sudo pacman -U win11-window-tiling-kde-1.0.0-1-any.pkg.tar.zst
```

---

## 11. License

| Component | License |
|-----------|---------|
| KZones KWin script | GPL-3.0 |
| Package setup scripts | MIT License |

---

## Quick Start Checklist

- [ ] Install: `sudo pacman -U win11-window-tiling-kde-1.0.0-1-any.pkg.tar.zst`
- [ ] Setup: `win11-tiling-setup`
- [ ] Log out and back in
- [ ] Verify: `win11-tiling-setup --status`
- [ ] Enable: KWin Scripts → KZones
- [ ] Test: Super + Left, or drag window to screen edge