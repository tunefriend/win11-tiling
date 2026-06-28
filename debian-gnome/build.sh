#!/bin/bash
# Build win11-window-tiling-gnome .deb for Debian GNOME.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
PKGROOT="$ROOT/pkgroot"
PKG="win11-window-tiling-gnome_1.0.0_all.deb"

chmod 755 "$PKGROOT/DEBIAN/postinst" "$PKGROOT/DEBIAN/prerm"
chmod 755 "$PKGROOT/usr/bin/"*

tail -c1 "$PKGROOT/DEBIAN/control" | read -r _ || echo >> "$PKGROOT/DEBIAN/control"

rm -f "$ROOT/$PKG"
dpkg-deb --root-owner-group --build "$PKGROOT" "$ROOT/$PKG"
cp "$ROOT/$PKG" "$ROOT/../$PKG"

echo ""
echo "Built: $ROOT/$PKG"
echo "Copied to: $ROOT/../$PKG"
echo ""
echo "Install on Debian GNOME:"
echo "  sudo dpkg -i $PKG"
echo "  sudo apt install -f"
echo "  win11-tiling-setup"