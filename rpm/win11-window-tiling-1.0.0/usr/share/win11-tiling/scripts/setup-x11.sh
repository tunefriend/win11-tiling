#!/bin/bash
# Configure X11 fallback tiling with xbindkeys (Super+Arrow like Windows 11).

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/win11-tiling"
AUTOSTART_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/autostart"

mkdir -p "$CONFIG_DIR" "$AUTOSTART_DIR"

cp /usr/share/win11-tiling/defaults/xbindkeysrc "$CONFIG_DIR/xbindkeysrc"
cp /usr/share/win11-tiling/defaults/win11-tiling-x11.desktop "$AUTOSTART_DIR/win11-tiling-x11.desktop"

if command -v xbindkeys >/dev/null 2>&1; then
    pkill -x xbindkeys 2>/dev/null || true
    xbindkeys -f "$CONFIG_DIR/xbindkeysrc" &
    echo "X11: xbindkeys started with Windows 11 tiling hotkeys."
else
    echo "X11: Config installed. Install xbindkeys and run:"
    echo "      xbindkeys -f $CONFIG_DIR/xbindkeysrc"
fi

echo "X11: Super+Left/Right/Up/Down for half-screen and maximize tiling."