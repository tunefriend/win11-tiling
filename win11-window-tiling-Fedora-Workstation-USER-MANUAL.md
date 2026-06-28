# win11-window-tiling — Fedora Workstation User Manual

**Version 1.0.0 (Fedora Workstation Edition)**

Windows 11-style window tiling for Fedora Workstation with GNOME and the Tiling Shell extension.

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

This package is built specifically for **Fedora Workstation**, which ships with the GNOME desktop. It installs and configures **Tiling Shell**, a GNOME Shell extension that brings Windows 11-style window management to Linux.

### Features

| Feature | Description |
|---------|-------------|
| Snap Assistant | Drag a window to the top of the screen to pick a layout |
| Fancy Zones | Custom tile grids per monitor and workspace |
| Edge snapping | Drag windows to screen edges to snap to halves or quarters |
| Keyboard shortcuts | Super + arrow keys to move windows between tiles |
| Window menu integration | Snap and auto-tile options in the title-bar right-click menu |

### What this edition includes

- Tiling Shell GNOME extension (bundled)
- `win11-tiling-setup` command for one-step installation
- GNOME-only — no KDE or X11 fallback components

### Upstream project

Tiling Shell: https://github.com/domferr/tilingshell

---

## 2. Requirements

- **Fedora Workstation** (GNOME edition)
- **GNOME Shell 45 or newer** (Fedora 41+)
- Packages installed automatically with the RPM:
  - `gnome-shell`
  - `gnome-extensions`
  - `unzip`
  - `dbus`
  - `bash`

To check your GNOME version:

```bash
gnome-shell --version
```

---

## 3. Installation

### Step 1 — Copy the RPM to your Fedora machine

Transfer the file:

`win11-window-tiling-1.0.0-1.fc41.noarch.rpm`

### Step 2 — Install with dnf

Open a terminal in the folder containing the RPM, then run:

```bash
sudo dnf install ./win11-window-tiling-1.0.0-1.fc41.noarch.rpm
```

`dnf` resolves and installs required dependencies (`gnome-shell`, `gnome-extensions`, etc.) automatically.

### Step 3 — Verify installation

```bash
rpm -q win11-window-tiling
```

Expected output: `win11-window-tiling-1.0.0-1.fc41.noarch`

---

## 4. First-Time Setup

### Run setup

```bash
win11-tiling-setup
```

This command:

1. Detects your GNOME Shell version
2. Installs the Tiling Shell extension to your user profile
3. Enables the extension (if `gnome-extensions` is available)

### Log out and back in

GNOME Shell extensions require a fresh session. Log out completely, then sign back in (a reboot also works).

### Verify

```bash
win11-tiling-setup --status
```

Example output:

```
Edition:          Fedora Workstation (GNOME)
Session type:     wayland
Setup status:     configured (2026-06-28T...)
GNOME extension:  installed
Name:             Tiling Shell
State:            ENABLED
```

Also open **Extensions** (search Activities for "Extensions") and confirm **Tiling Shell** is toggled **ON**.

---

## 5. Daily Use

### Keyboard shortcuts

Focus a window, then press:

| Shortcut | Action |
|----------|--------|
| Super + Left | Move window to the tile on the left |
| Super + Right | Move window to the tile on the right |
| Super + Up | Move window to the tile above |
| Super + Down | Move window to the tile below |

### Mouse and drag

| Action | Result |
|--------|--------|
| Drag window to **top edge** | Snap Assistant opens with layout thumbnails |
| Drag to **left or right edge** | Snap to half-screen or quarters |
| **Ctrl + drag** while moving | Place window in a specific tile (tiling system) |
| **Alt + drag** while moving | Span window across multiple tiles |

### Window menu

Right-click a window's title bar for snap and auto-tile options (when enabled in extension settings).

### Alt+Tab

Tiled windows can appear grouped in the Alt+Tab switcher so you can raise related windows together.

---

## 6. Configuration

Open **Extensions → Tiling Shell → gear icon** (or search Settings for "Tiling Shell").

### Recommended settings

| Setting | Default | What it does |
|---------|---------|--------------|
| Enable snap assist | On | Layout picker when dragging to top edge |
| Enable tiling system | On | Hold Ctrl while dragging to snap into tiles |
| Active screen edges | On | Snap when dragging to left/right/top edges |
| Enable move keybindings | On | Super + arrow key shortcuts |
| Inner gaps | 16 px | Space between tiles |
| Outer gaps | 8 px | Space between layout and monitor edge |
| Enable auto tiling | Off | Auto-place new windows into the best tile |

### Custom layouts (Fancy Zones)

1. Open Tiling Shell settings → **Layouts**
2. Create or import custom tile grids
3. Assign layouts per monitor and workspace
4. Assign **Cycle layouts** keybindings in the Keybindings section

### Change keyboard shortcuts

In Tiling Shell settings → **Keybindings**, you can customize:

- Move window left/right/up/down
- Span window across tiles
- Untile window
- Focus next/previous tiled window
- Cycle layouts

### Command-line settings (optional)

```bash
# Disable snap assist
gsettings set org.gnome.shell.extensions.tilingshell enable-snap-assist false

# Increase gap between tiles
gsettings set org.gnome.shell.extensions.tilingshell inner-gaps 24

# Enable auto-tiling for new windows
gsettings set org.gnome.shell.extensions.tilingshell enable-autotiling true
```

---

## 7. Commands

| Command | Description |
|---------|-------------|
| `win11-tiling-setup` | Install and enable Tiling Shell |
| `win11-tiling-setup --status` | Show configuration status |
| `win11-tiling-setup --uninstall` | Remove extension from your user profile |
| `win11-tiling-setup --help` | Show usage information |

### GNOME extension commands (optional)

```bash
# List enabled extensions
gnome-extensions list --enabled

# Enable Tiling Shell manually
gnome-extensions enable tilingshell@ferrarodomenico.com

# Extension details
gnome-extensions info tilingshell@ferrarodomenico.com
```

---

## 8. Troubleshooting

### Setup says "gnome-shell not found"

You are not running Fedora Workstation with GNOME, or `gnome-shell` is not installed:

```bash
sudo dnf install gnome-shell gnome-extensions
```

### Extension not working after setup

1. Confirm it is enabled:
   ```bash
   gnome-extensions enable tilingshell@ferrarodomenico.com
   ```
2. Re-run setup:
   ```bash
   win11-tiling-setup
   ```
3. **Log out and back in** — required after installing any GNOME Shell extension.

### Extension shows as incompatible

Check GNOME Shell version:

```bash
gnome-shell --version
```

This package bundles Tiling Shell builds for GNOME Shell **45 through 49**. If Fedora ships a newer version not yet supported, check https://github.com/domferr/tilingshell for updates.

### Super + arrow does nothing

- Open **Extensions → Tiling Shell → Keybindings** and verify bindings are set
- Confirm **Enable keybindings** is turned on
- Check for conflicts in **Settings → Keyboard → Keyboard Shortcuts**

### Snap Assistant does not appear

- Confirm **Enable snap assist** is on in Tiling Shell settings
- Drag the window firmly to the very top edge of the screen
- Ensure no other extension is intercepting edge gestures

### dnf reports dependency errors

```bash
sudo dnf install gnome-shell gnome-extensions unzip
sudo dnf install ./win11-window-tiling-1.0.0-1.fc41.noarch.rpm
```

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

On a Fedora machine with `rpm-build` installed:

```bash
sudo dnf install rpm-build
cd fedora-workstation
./build.sh
```

Output RPM:

`win11-window-tiling-1.0.0-1.fc41.noarch.rpm`

---

## 11. License

| Component | License |
|-----------|---------|
| Tiling Shell extension | GPL-3.0-or-later |
| Package setup scripts | MIT License |

Bundled extension source: https://github.com/domferr/tilingshell

---

## Quick Start Checklist

- [ ] Install: `sudo dnf install ./win11-window-tiling-1.0.0-1.fc41.noarch.rpm`
- [ ] Setup: `win11-tiling-setup`
- [ ] Log out and back in
- [ ] Verify: `win11-tiling-setup --status`
- [ ] Enable: Extensions app → Tiling Shell → ON
- [ ] Test: Super + Left on a window, or drag a window to the top of the screen