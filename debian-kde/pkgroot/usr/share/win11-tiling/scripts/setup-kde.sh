#!/bin/bash
# Install KZones KWin script and configure Windows 11 keyboard shortcuts.

set -euo pipefail

SHARE_DIR="/usr/share/win11-tiling"
KWIN_SCRIPT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/kwin/scripts"

if ! command -v kwin_wayland >/dev/null 2>&1 && ! command -v kwin_x11 >/dev/null 2>&1; then
    echo "ERROR: KWin not found. Install plasma-workspace first." >&2
    exit 1
fi

KCONFIG=kwriteconfig6
QDBUS=qdbus6
if ! command -v kwriteconfig6 >/dev/null 2>&1; then
    KCONFIG=kwriteconfig5
    QDBUS=qdbus
fi

mkdir -p "$KWIN_SCRIPT_DIR"
cp "${SHARE_DIR}/kde/kzones.kwinscript" "${KWIN_SCRIPT_DIR}/kzones.kwinscript"

# Enable KZones via KWin scripting API.
if command -v "$QDBUS" >/dev/null 2>&1; then
    "$QDBUS" org.kde.KWin /Scripting org.kde.kwin.Scripting.unloadScript kzones 2>/dev/null || true
    "$QDBUS" org.kde.KWin /Scripting org.kde.kwin.Scripting.loadScript \
        "${KWIN_SCRIPT_DIR}/kzones.kwinscript" kzones 2>/dev/null || true
    "$QDBUS" org.kde.KWin /Scripting org.kde.kwin.Scripting.runScript kzones 2>/dev/null || true
fi

# Windows 11-style Super+Arrow shortcuts for quick tiling.
configure_shortcut() {
    local action="$1"
    local keys="$2"
    "$KCONFIG" --file kglobalshortcutsrc --group kwin --key "$action" "$action" "none,$keys,none" 2>/dev/null || true
}

configure_shortcut "Window Quick Tile Left" "Meta+Left"
configure_shortcut "Window Quick Tile Right" "Meta+Right"
configure_shortcut "Window Maximize" "Meta+Up"
configure_shortcut "Window Minimize" "Meta+Down"
configure_shortcut "Window Quick Tile Top Left" "Meta+Shift+Left"
configure_shortcut "Window Quick Tile Top Right" "Meta+Shift+Right"
configure_shortcut "Window Quick Tile Bottom Left" "Meta+Shift+Down"
configure_shortcut "Window Quick Tile Bottom Right" "Meta+Shift+Up"

# Reload KWin shortcuts.
if command -v "$QDBUS" >/dev/null 2>&1; then
    "$QDBUS" org.kde.kglobalaccel /component/kwin org.kde.kglobalaccel.Component.reloadConfig 2>/dev/null || true
    "$QDBUS" org.kde.KWin /KWin org.kde.KWin.reconfigure 2>/dev/null || true
fi

echo "KDE: KZones KWin script installed and enabled."
echo "KDE: Windows 11 shortcuts configured (Super+Arrow keys)."
echo "KDE: Drag windows to screen edges for zone snapping."
echo "KDE: Open System Settings > Window Management > KWin Scripts to adjust KZones."