#!/usr/bin/env bash
# Update the v1.0.1 release notes and repo description on GitHub.
# Requires: GH_TOKEN (classic token with repo scope) or `gh auth login`
set -euo pipefail

cd "$(dirname "$0")"

GH_USER="${1:-tunefriend}"
REPO="${GH_USER}/win11-tiling"
BODY_FILE="RELEASE_v1.0.1.md"

if [[ -z "${GH_TOKEN:-}" ]] && ! command -v gh >/dev/null 2>&1; then
  echo "Install gh or set GH_TOKEN to update the release page." >&2
  exit 1
fi

gh_api() {
  if [[ -n "${GH_TOKEN:-}" ]]; then
    curl -fsSL -X "$1" -H "Authorization: Bearer ${GH_TOKEN}" \
      -H "Accept: application/vnd.github+json" "$2" "${@:3}"
  else
    gh api "$2" "${@:3}"
  fi
}

echo "==> Updating repo description"
if [[ -n "${GH_TOKEN:-}" ]]; then
  curl -fsSL -X PATCH -H "Authorization: Bearer ${GH_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${REPO}" \
    -d '{"description":"Windows 11-style window tiling for Linux — GNOME & KDE packages for Debian, Fedora, RHEL, and Arch.","homepage":"https://github.com/tunefriend/win11-tiling/releases/latest"}'
else
  gh repo edit "${REPO}" \
    --description "Windows 11-style window tiling for Linux — GNOME & KDE packages for Debian, Fedora, RHEL, and Arch." \
    --homepage "https://github.com/tunefriend/win11-tiling/releases/latest"
fi

echo "==> Updating v1.0.1 release notes"
if [[ -n "${GH_TOKEN:-}" ]]; then
  BODY=$(python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))' < "$BODY_FILE")
  curl -fsSL -X PATCH -H "Authorization: Bearer ${GH_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${REPO}/releases/tags/v1.0.1" \
    -d "{\"name\":\"Win11 Window Tiling v1.0.1\",\"body\":${BODY}}"
else
  gh release edit v1.0.1 --repo "${REPO}" \
    --title "Win11 Window Tiling v1.0.1" \
    --notes-file "$BODY_FILE"
fi

echo "==> Updating tunefriend profile bio"
PROFILE_BIO=$'TuneFriend — stream music from a friend\u2019s Subsonic/Navidrome server on Android.\nWin11 Window Tiling — Windows 11-style snap layouts for Linux (GNOME & KDE).\nGPL-3.0.'
if [[ -n "${GH_TOKEN:-}" ]]; then
  curl -fsSL -X PATCH -H "Authorization: Bearer ${GH_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/user" \
    -d "$(python3 -c "import json; print(json.dumps({'name':'tunefriend','bio':'''${PROFILE_BIO}'''}))")"
else
  gh api user -X PATCH -f name=tunefriend -f bio="$PROFILE_BIO"
fi

echo "Done."