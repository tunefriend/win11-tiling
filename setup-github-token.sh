#!/usr/bin/env bash
# Log into GitHub CLI with repo scope (browser flow — easiest way to get a working token).
set -euo pipefail

GH_BIN="${GH_BIN:-gh}"
if ! command -v "$GH_BIN" >/dev/null 2>&1; then
  if [[ -x /tmp/gh_2.74.2_linux_amd64/bin/gh ]]; then
    GH_BIN=/tmp/gh_2.74.2_linux_amd64/bin/gh
  else
    echo "Install GitHub CLI first: sudo apt install gh" >&2
    exit 1
  fi
fi

echo "This opens GitHub in your browser and requests 'repo' permission."
echo "After you approve, run: ./update-github-release.sh"
echo ""

"$GH_BIN" auth login -h github.com -p https -s repo -w

echo ""
"$GH_BIN" auth status