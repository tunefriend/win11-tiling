# win11-window-tiling-gnome — Debian GNOME User Manual

**Version 1.0.0 (Debian GNOME Edition)**

Windows 11-style window tiling for Debian with GNOME and the Tiling Shell extension.

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

This package is built specifically for **Debian with GNOME**. It installs and configures **Tiling Shell**, a GNOME Shell extension that brings Windows 11-style window management to Linux.

### Features

| Feature | Description |
|---------|-------------|
| Snap Assistant | Drag a window to the top of the screen to pick a layout |
| Fancy Zones | Custom tile grids per monitor and workspace |
| Edge snapping | Drag windows to screen edges to snap to halves or quarters |
| Keyboard shortcuts | Super + arrow keys to move windows between tiles |

### Package name

`win11-window-tiling-gnome`

### Upstream project

Tiling Shell: https://github.com/domferr/tilingshell

---

## 2. Requirements

- **Debian** with GNOME desktop (Debian 12+ recommended)
- **GNOME Shell 45 or newer**
- Dependencies (installed with the package):
  - `gnome-shell`
  - `gnome-shell-extensions` or `gnome-extensions`
  - `unzip`
  - `dbus` or `dbus-x11`
  - `bash`

Check your GNOME version:

```bash
gnome-shell --version
```

---

## 3. Installation

### Step 1 — Copy the package

Transfer: `win11-window-tiling-gnome_1.0.0_all.deb`

### Step 2 — Install with dpkg

```bash
sudo dpkg -i win11-window-tiling-gnome_1.0.0_all.deb
```

### Step 3 — Fix missing dependencies

```bash
sudo apt install -f
```

### Step 4 — Verify

```bash
dpkg -l win11-window-tiling-gnome
```

---

## 4. First-Time Setup

```bash
win11-tiling-setup
```

Log out and back in, then confirm **Tiling Shell** is enabled in **Extensions**.

```bash
win11-tiling-setup --status
```

---

## 5. Daily Use

### Keyboard shortcuts

| Shortcut | Action |
|----------|--------|
| Super + Left | Move to left tile |
| Super + Right | Move to right tile |
| Super + Up | Move to tile above |
| Super + Down | Move to tile below |

### Mouse

| Action | Result |
|--------|--------|
| Drag to top edge | Snap Assistant layout picker |
| Drag to side edges | Snap to halves or quarters |
| Ctrl + drag | Place in a specific tile |
| Alt + drag | Span multiple tiles |

---

## 6. Configuration

**Extensions → Tiling Shell → gear icon**

Key settings: Snap Assist, tiling system, edge snapping, keybindings, custom layouts, gaps.

```bash
gsettings set org.gnome.shell.extensions.tilingshell enable-snap-assist false
gsettings set org.gnome.shell.extensions.tilingshell inner-gaps 24
```

---

## 7. Commands

| Command | Description |
|---------|-------------|
| `win11-tiling-setup` | Install and enable Tiling Shell |
| `win11-tiling-setup --status` | Show status |
| `win11-tiling-setup --uninstall` | Remove user config |
| `gnome-extensions enable tilingshell@ferrarodomenico.com` | Enable extension manually |

---

## 8. Troubleshooting

### gnome-shell not found

```bash
sudo apt install gnome-shell gnome-shell-extensions
```

### Extension not working

```bash
gnome-extensions enable tilingshell@ferrarodomenico.com
win11-tiling-setup
```

Log out and back in.

### Super + arrow does nothing

Check Tiling Shell keybindings and **Settings → Keyboard** for conflicts.

### Wrong edition

Use `win11-window-tiling-gnome`, not `win11-window-tiling-kde` or the generic package.

---

## 9. Uninstalling

```bash
win11-tiling-setup --uninstall
sudo apt remove win11-window-tiling-gnome
```

---

## 10. Building from Source

```bash
cd debian-gnome
./build.sh
sudo dpkg -i ../win11-window-tiling-gnome_1.0.0_all.deb
sudo apt install -f
```

---

## 11. License

| Component | License |
|-----------|---------|
| Tiling Shell extension | GPL-3.0-or-later |
| Package setup scripts | MIT License |

---

## Quick Start Checklist

- [ ] Install: `sudo dpkg -i win11-window-tiling-gnome_1.0.0_all.deb`
- [ ] Fix deps: `sudo apt install -f`
- [ ] Setup: `win11-tiling-setup`
- [ ] Log out and back in
- [ ] Enable: Extensions → Tiling Shell → ON
- [ ] Test: Super + Left or drag to top edge

---

## Debian Edition Comparison

| Package | Desktop |
|---------|---------|
| `win11-window-tiling` | Generic (auto-detect) |
| `win11-window-tiling-gnome` | GNOME / Tiling Shell |
| `win11-window-tiling-kde` | KDE Plasma / KZones |