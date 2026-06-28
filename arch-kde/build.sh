#!/bin/bash
# Build win11-window-tiling-kde package for Arch Linux.
# Run on Arch: ./build.sh

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
PKGNAME="win11-window-tiling-kde"
VERSION="1.0.0"
RELEASE="1"

cd "$ROOT"
tar czf "${PKGNAME}-${VERSION}.tar.gz" -C src .

if command -v makepkg >/dev/null 2>&1; then
    makepkg -f --noconfirm --nodeps --skipinteg
    PKG=$(ls -1 "${PKGNAME}-${VERSION}-${RELEASE}"-any.pkg.tar.* 2>/dev/null | head -1)
    if [ -n "$PKG" ] && [ -f "$PKG" ]; then
        cp "$PKG" "${ROOT}/../${PKG}"
        echo ""
        echo "Built: $ROOT/$PKG"
        echo "Copied to: ${ROOT}/../${PKG}"
        echo ""
        echo "Install on Arch Linux (KDE Plasma):"
        echo "  sudo pacman -U ${PKG}"
        echo "  win11-tiling-setup"
    fi
else
    echo "makepkg not found. Install with: sudo pacman -S base-devel"
    echo "Source tarball ready: ${PKGNAME}-${VERSION}.tar.gz"
fi