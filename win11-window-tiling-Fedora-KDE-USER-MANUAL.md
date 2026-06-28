# win11-window-tiling — Fedora KDE Plasma User Manual

**Version 1.0.0 (Fedora KDE Plasma Edition)**

Windows 11-style window tiling for Fedora KDE Plasma Spin with KZones and KWin.

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

This package is built specifically for **Fedora KDE Plasma Spin**. It installs and configures **KZones**, a KWin script that brings Windows 11-style zone snapping to KDE Plasma.

### Features

| Feature | Description |
|---------|-------------|
| Zone snapping | Drag windows to screen edges to snap into predefined zones |
| Fancy Zones style | Customizable zone layouts per monitor |
| Keyboard shortcuts | Super + arrow keys matching Windows 11 |
| Quarter tiling | Super + Shift + arrows for corner tiles |

### What this edition includes

- KZones KWin script (bundled)
- `win11-tiling-setup` for one-step installation
- `win11-tile` CLI for manual window tiling
- KDE-only — no GNOME or X11 fallback components

### Upstream project

KZones: https://github.com/gerritdevriese/kzones

---

## 2. Requirements

- **Fedora KDE Plasma Spin** (Plasma 6)
- **KWin** window manager (included with Plasma)
- Packages installed automatically with the RPM:
  - `plasma-workspace`
  - `kwin`
  - `dbus`
  - `bash`

---

## 3. Installation

### Step 1 — Copy the RPM to your Fedora KDE machine

Transfer the file:

`win11-window-tiling-1.0.0-1.fc41kde.noarch.rpm`

### Step 2 — Install with dnf

```bash
sudo dnf install ./win11-window-tiling-1.0.0-1.fc41kde.noarch.rpm
```

### Step 3 — Verify installation

```bash
rpm -q win11-window-tiling
```

Expected output includes: `win11-window-tiling-1.0.0-1.fc41kde`

---

## 4. First-Time Setup

### Run setup

```bash
win11-tiling-setup
```

This command:

1. Copies the KZones script to `~/.local/share/kwin/scripts/`
2. Loads and runs KZones via KWin's scripting API
3. Configures Windows 11-style Super+Arrow shortcuts in KGlobalAccel

### Log out and back in

A fresh Plasma session ensures KWin scripts and shortcuts are fully applied.

### Verify

```bash
win11-tiling-setup --status
```

Example output:

```
Edition:          Fedora KDE Plasma
Session type:     wayland
Setup status:     configured (2026-06-28T...)
KZones script:    installed
KWin:             available
```

Also open **System Settings → Window Management → KWin Scripts** and confirm KZones is enabled.

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

- **Drag a window to a screen edge** — KZones snaps it into the matching zone.

### Command-line tiling

```bash
win11-tile left
win11-tile right
win11-tile top-left
win11-tile maximize
win11-tile restore
```

---

## 6. Configuration

### KZones zone layouts

1. Open **System Settings**
2. Go to **Window Management → KWin Scripts**
3. Select **KZones**
4. Click **Configure** to adjust zone grids, colors, and behavior

### Keyboard shortcuts

1. Open **System Settings → Shortcuts → KWin**
2. Search for **Window Quick Tile** actions
3. Adjust bindings if they conflict with other shortcuts

The setup script pre-configures `Meta` (Super) + arrow shortcuts. Changes here override the defaults.

### Multiple monitors

KZones supports per-monitor zone layouts. Configure each display in the KZones settings dialog.

---

## 7. Commands

| Command | Description |
|---------|-------------|
| `win11-tiling-setup` | Install and enable KZones |
| `win11-tiling-setup --status` | Show configuration status |
| `win11-tiling-setup --uninstall` | Remove KZones from your user profile |
| `win11-tiling-setup --help` | Show usage information |
| `win11-tile <position>` | Manually tile the active window |

### win11-tile positions

```
left, right, top, bottom
top-left, top-right, bottom-left, bottom-right
maximize (or up), restore (or down)
```

---

## 8. Troubleshooting

### Setup says "KWin not found"

```bash
sudo dnf install plasma-workspace kwin
```

### Zones or shortcuts not working

1. Verify the script is installed:
   ```bash
   ls ~/.local/share/kwin/scripts/kzones.kwinscript
   ```
2. Re-run setup:
   ```bash
   win11-tiling-setup
   ```
3. Restart KWin or log out and back in:
   ```bash
   kwin_wayland --replace &   # Wayland (use with caution)
   ```
4. Check **System Settings → Shortcuts** for conflicting Meta bindings.

### KZones not listed in KWin Scripts

Re-run setup and log out/in. If still missing, load manually:

```bash
qdbus6 org.kde.KWin /Scripting org.kde.kwin.Scripting.loadScript \
  ~/.local/share/kwin/scripts/kzones.kwinscript kzones
qdbus6 org.kde.KWin /Scripting org.kde.kwin.Scripting.runScript kzones
```

(On older setups, use `qdbus` instead of `qdbus6`.)

### Super + arrow does nothing

- Another KWin shortcut may use the same keys
- Open **System Settings → Shortcuts → KWin** and check **Window Quick Tile** entries
- Re-run `win11-tiling-setup` to restore default bindings

### Drag-to-edge snapping not working

- Confirm KZones is running in KWin Scripts
- Check zone size and activation settings in KZones configure dialog
- Ensure no other KWin script conflicts with edge detection

### Wrong edition installed

If you installed the **Fedora Workstation** (GNOME) RPM by mistake, it will not work on KDE. Use the KDE edition:

`win11-window-tiling-1.0.0-1.fc41kde.noarch.rpm`

---

## 9. Uninstalling

### Remove user configuration only

```bash
win11-tiling-setup --uninstall
```

Log out and back in.

### Remove the package entirely

```bash
win11-tiling-setup --uninstall
sudo dnf remove win11-window-tiling
```

---

## 10. Building from Source

On a Fedora machine with `rpm-build`:

```bash
sudo dnf install rpm-build
cd fedora-kde
./build.sh
```

Output RPM:

`win11-window-tiling-1.0.0-1.fc41kde.noarch.rpm`

---

## 11. License

| Component | License |
|-----------|---------|
| KZones KWin script | GPL-3.0 |
| Package setup scripts | MIT License |

Upstream: https://github.com/gerritdevriese/kzones

---

## Quick Start Checklist

- [ ] Install: `sudo dnf install ./win11-window-tiling-1.0.0-1.fc41kde.noarch.rpm`
- [ ] Setup: `win11-tiling-setup`
- [ ] Log out and back in
- [ ] Verify: `win11-tiling-setup --status`
- [ ] Enable: System Settings → KWin Scripts → KZones
- [ ] Test: Super + Left on a window, or drag a window to a screen edge

---

## Edition Comparison

| Edition | RPM release | Desktop |
|---------|-------------|---------|
| Fedora Workstation | `1.fc41` | GNOME / Tiling Shell |
| Fedora KDE Plasma | `1.fc41kde` | KDE / KZones |
| Generic | `1` | Auto-detect (all DEs) |