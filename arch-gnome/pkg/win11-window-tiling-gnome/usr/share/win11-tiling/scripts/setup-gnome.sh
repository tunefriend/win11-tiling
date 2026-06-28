#!/bin/bash
# Install and enable Tiling Shell GNOME extension.

set -euo pipefail

SHARE_DIR="/usr/share/win11-tiling"
EXT_UUID="tilingshell@ferrarodomenico.com"
EXT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/gnome-shell/extensions/${EXT_UUID}"

if ! command -v gnome-shell >/dev/null 2>&1; then
    echo "ERROR: gnome-shell not found. Install gnome-shell first." >&2
    exit 1
fi

GNOME_VERSION="$(gnome-shell --version 2>/dev/null | grep -oE '[0-9]+' | head -1 || echo "0")"
if [ "$GNOME_VERSION" -ge 45 ] 2>/dev/null; then
    ZIP="${SHARE_DIR}/gnome/tilingshell-modern.zip"
else
    ZIP="${SHARE_DIR}/gnome/tilingshell-legacy.zip"
fi

mkdir -p "$(dirname "$EXT_DIR")"
rm -rf "$EXT_DIR"
mkdir -p "$EXT_DIR"
unzip -qo "$ZIP" -d "$EXT_DIR"

if command -v gnome-extensions >/dev/null 2>&1; then
    gnome-extensions enable "$EXT_UUID" 2>/dev/null || true
fi

echo "GNOME: Tiling Shell extension installed to $EXT_DIR"
echo "GNOME: Log out and back in, then verify the extension is enabled."
echo "GNOME: Settings are in Extensions > Tiling Shell."