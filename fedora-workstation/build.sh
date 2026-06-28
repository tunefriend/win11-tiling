#!/bin/bash
# Build win11-window-tiling RPM for Fedora Workstation.
# Run on Fedora: ./build.sh
# Cross-build on Debian also works if rpmbuild is installed.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
VERSION="1.0.0"
TARBALL="${ROOT}/SOURCES/win11-window-tiling-${VERSION}.tar.gz"

mkdir -p "${ROOT}/SOURCES" "${ROOT}/BUILD" "${ROOT}/RPMS" "${ROOT}/SRPMS"

tar czf "$TARBALL" -C "$ROOT" "win11-window-tiling-${VERSION}"

rpmbuild --define "_topdir ${ROOT}" \
         --define "fedora 41" \
         -ba "${ROOT}/SPECS/win11-window-tiling.spec"

RPM="${ROOT}/RPMS/noarch/win11-window-tiling-${VERSION}-1.fc41.noarch.rpm"
if [ -f "$RPM" ]; then
    cp "$RPM" "${ROOT}/../win11-window-tiling-${VERSION}-1.fc41.noarch.rpm"
    echo ""
    echo "Built: $RPM"
    echo "Copied to: ${ROOT}/../win11-window-tiling-${VERSION}-1.fc41.noarch.rpm"
    echo ""
    echo "Install on Fedora Workstation:"
    echo "  sudo dnf install ./win11-window-tiling-${VERSION}-1.fc41.noarch.rpm"
    echo "  win11-tiling-setup"
fi