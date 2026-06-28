# win11-window-tiling — Arch Linux GNOME User Manual

**Version 1.0.0 (Arch Linux GNOME Edition)**

Windows 11-style window tiling for Arch Linux with GNOME and the Tiling Shell extension.

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

This package is built specifically for **Arch Linux with GNOME**. It installs and configures **Tiling Shell**, a GNOME Shell extension that brings Windows 11-style window management to Linux.

### Features

| Feature | Description |
|---------|-------------|
| Snap Assistant | Drag a window to the top of the screen to pick a layout |
| Fancy Zones | Custom tile grids per monitor and workspace |
| Edge snapping | Drag windows to screen edges to snap to halves or quarters |
| Keyboard shortcuts | Super + arrow keys to move windows between tiles |
| Window menu integration | Snap and auto-tile options in the title-bar right-click menu |

### Package name

`win11-window-tiling-gnome`

### Upstream project

Tiling Shell: https://github.com/domferr/tilingshell

---

## 2. Requirements

- **Arch Linux** with GNOME desktop
- **GNOME Shell 45 or newer** (recommended)
- Dependencies (installed automatically with the package):
  - `gnome-shell`
  - `gnome-extensions`
  - `unzip`
  - `dbus`
  - `bash`

Check your GNOME version:

```bash
gnome-shell --version
```

---

## 3. Installation

### Step 1 — Copy the package to your Arch machine

Transfer the file:

`win11-window-tiling-gnome-1.0.0-1-any.pkg.tar.zst`

(or `.pkg.tar.gz` if cross-built)

### Step 2 — Install with pacman

```bash
sudo pacman -U win11-window-tiling-gnome-1.0.0-1-any.pkg.tar.zst
```

### Step 3 — Verify installation

```bash
pacman -Q win11-window-tiling-gnome
```

Expected output: `win11-window-tiling-gnome 1.0.0-1`

---

## 4. First-Time Setup

### Run setup

```bash
win11-tiling-setup
```

This installs the Tiling Shell extension to your user profile and enables it.

### Log out and back in

GNOME Shell extensions require a fresh session.

### Verify

```bash
win11-tiling-setup --status
```

Also open **Extensions** and confirm **Tiling Shell** is toggled **ON**.

---

## 5. Daily Use

### Keyboard shortcuts

| Shortcut | Action |
|----------|--------|
| Super + Left | Move window to the tile on the left |
| Super + Right | Move window to the tile on the right |
| Super + Up | Move window to the tile above |
| Super + Down | Move window to the tile below |

### Mouse and drag

| Action | Result |
|--------|--------|
| Drag to **top edge** | Snap Assistant layout picker |
| Drag to **left/right edge** | Snap to half-screen or quarters |
| **Ctrl + drag** | Place window in a specific tile |
| **Alt + drag** | Span window across multiple tiles |

### Settings

**Extensions → Tiling Shell → gear icon**

---

## 6. Configuration

Key settings in Tiling Shell:

| Setting | Default | What it does |
|---------|---------|--------------|
| Enable snap assist | On | Layout picker at top edge |
| Enable tiling system | On | Ctrl + drag to snap into tiles |
| Active screen edges | On | Edge snapping |
| Enable move keybindings | On | Super + arrow shortcuts |
| Inner gaps | 16 px | Space between tiles |
| Enable auto tiling | Off | Auto-tile new windows |

### Command-line settings

```bash
gsettings set org.gnome.shell.extensions.tilingshell enable-snap-assist false
gsettings set org.gnome.shell.extensions.tilingshell inner-gaps 24
gsettings set org.gnome.shell.extensions.tilingshell enable-autotiling true
```

---

## 7. Commands

| Command | Description |
|---------|-------------|
| `win11-tiling-setup` | Install and enable Tiling Shell |
| `win11-tiling-setup --status` | Show configuration status |
| `win11-tiling-setup --uninstall` | Remove extension from user profile |
| `win11-tiling-setup --help` | Show usage |

### GNOME extension commands

```bash
gnome-extensions enable tilingshell@ferrarodomenico.com
gnome-extensions info tilingshell@ferrarodomenico.com
```

---

## 8. Troubleshooting

### gnome-shell not found

```bash
sudo pacman -S gnome-shell gnome-extensions
```

### Extension not working after setup

```bash
gnome-extensions enable tilingshell@ferrarodomenico.com
win11-tiling-setup
```

Log out and back in.

### Super + arrow does nothing

Check **Extensions → Tiling Shell → Keybindings** and **Settings → Keyboard** for conflicts.

### Wrong edition installed

Use `win11-window-tiling-gnome`, not `win11-window-tiling-kde`.

---

## 9. Uninstalling

```bash
win11-tiling-setup --uninstall
sudo pacman -R win11-window-tiling-gnome
```

Log out and back in after removing user config.

---

## 10. Building from Source

On Arch Linux:

```bash
sudo pacman -S base-devel
cd arch-gnome
./build.sh
sudo pacman -U win11-window-tiling-gnome-1.0.0-1-any.pkg.tar.zst
```

---

## 11. License

| Component | License |
|-----------|---------|
| Tiling Shell extension | GPL-3.0-or-later |
| Package setup scripts | MIT License |

---

## Quick Start Checklist

- [ ] Install: `sudo pacman -U win11-window-tiling-gnome-1.0.0-1-any.pkg.tar.zst`
- [ ] Setup: `win11-tiling-setup`
- [ ] Log out and back in
- [ ] Verify: `win11-tiling-setup --status`
- [ ] Enable: Extensions → Tiling Shell → ON
- [ ] Test: Super + Left, or drag window to top edge