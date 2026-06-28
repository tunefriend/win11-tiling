# Win11 Window Tiling

Windows 11-style window tiling for Linux — snap windows with Super+Arrow, drag-to-zone layouts, and the same feel you know from Windows.

**Latest release:** [v1.0.1](https://github.com/tunefriend/win11-tiling/releases/latest)

## Install

1. Download the package for your distro and desktop from [Releases](https://github.com/tunefriend/win11-tiling/releases/latest) (or pick a file below)
2. Install the package
3. Run `win11-tiling-setup`
4. Log out and back in

### Quick install (Debian / Ubuntu, GNOME)

```bash
sudo dpkg -i win11-window-tiling-gnome_1.0.0_all.deb
sudo apt-get install -f
win11-tiling-setup
```

## Share with friends

Send them the [latest release](https://github.com/tunefriend/win11-tiling/releases/latest) — the **Win11-tiling_1.0.1.zip** archive has everything (packages, manuals, and build trees).

Not sure which package? Use the auto-detect `.deb` on Debian/Ubuntu: `win11-window-tiling_1.0.0_all.deb`

## Downloads

| Distro | Desktop | Package |
|--------|---------|---------|
| Debian / Ubuntu | GNOME | `win11-window-tiling-gnome_1.0.0_all.deb` |
| Debian / Ubuntu | KDE | `win11-window-tiling-kde_1.0.0_all.deb` |
| Debian / Ubuntu | Auto-detect | `win11-window-tiling_1.0.0_all.deb` |
| Fedora | Workstation (GNOME) | `win11-window-tiling-1.0.0-1.fc41.noarch.rpm` |
| Fedora | KDE | `win11-window-tiling-1.0.0-1.fc41kde.noarch.rpm` |
| RHEL / Alma / Rocky | GNOME | `win11-window-tiling-1.0.0-1.noarch.rpm` |
| Arch Linux | GNOME | `win11-window-tiling-gnome-1.0.0-1-any.pkg.tar.gz` |
| Arch Linux | KDE | `win11-window-tiling-kde-1.0.0-1-any.pkg.tar.gz` |

## Features

- **Snap layouts** — drag a window to the top of the screen to pick a tile grid (GNOME)
- **Super + Arrow keys** — move windows between zones
- **Edge snapping** — drag to screen edges for halves and quarters
- **GNOME and KDE** — separate packages tuned for each desktop
- **Multi-distro** — Debian, Fedora, RHEL, and Arch builds included

## User manuals

- `win11-window-tiling-USER-MANUAL.pdf` — quick-start overview
- `win11-window-tiling-Debian-GNOME-USER-MANUAL.md`
- `win11-window-tiling-Debian-KDE-USER-MANUAL.md`
- `win11-window-tiling-Fedora-Workstation-USER-MANUAL.md`
- `win11-window-tiling-Fedora-KDE-USER-MANUAL.md`
- `win11-window-tiling-Arch-GNOME-USER-MANUAL.md`
- `win11-window-tiling-Arch-KDE-USER-MANUAL.md`

## Build from source

Source trees and build scripts:

- `debian-gnome/` / `debian-kde/`
- `fedora-workstation/` / `fedora-kde/`
- `rpm/`
- `arch-gnome/` / `arch-kde/`

## Upstream

GNOME edition uses [Tiling Shell](https://github.com/domferr/tilingshell) by domferr.

## License

GNU General Public License v3.0 or later — see [LICENSE](LICENSE).