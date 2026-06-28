#!/bin/bash
# Build win11-window-tiling RPM for Fedora KDE Plasma Spin.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
VERSION="1.0.0"
RELEASE="1.fc41kde"
TARBALL="${ROOT}/SOURCES/win11-window-tiling-${VERSION}.tar.gz"

mkdir -p "${ROOT}/SOURCES" "${ROOT}/BUILD" "${ROOT}/RPMS" "${ROOT}/SRPMS"

tar czf "$TARBALL" -C "$ROOT" "win11-window-tiling-${VERSION}"

rpmbuild --define "_topdir ${ROOT}" -ba "${ROOT}/SPECS/win11-window-tiling.spec"

RPM="${ROOT}/RPMS/noarch/win11-window-tiling-${VERSION}-${RELEASE}.noarch.rpm"
if [ -f "$RPM" ]; then
    cp "$RPM" "${ROOT}/../win11-window-tiling-${VERSION}-${RELEASE}.noarch.rpm"
    echo ""
    echo "Built: $RPM"
    echo "Copied to: ${ROOT}/../win11-window-tiling-${VERSION}-${RELEASE}.noarch.rpm"
    echo ""
    echo "Install on Fedora KDE Plasma:"
    echo "  sudo dnf install ./win11-window-tiling-${VERSION}-${RELEASE}.noarch.rpm"
    echo "  win11-tiling-setup"
fi