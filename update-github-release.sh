#!/usr/bin/env bash
# Update the v1.0.1 release notes and repo description on GitHub.
# Requires: GH_TOKEN (classic token with repo scope) or `gh auth login`
set -euo pipefail

cd "$(dirname "$0")"

GH_USER="${1:-tunefriend}"
REPO="${GH_USER}/win11-tiling"
BODY_FILE="RELEASE_v1.0.1.md"

if [[ -z "${GH_TOKEN:-}" ]] && ! command -v gh >/dev/null 2>&1; then
  echo "Error: set GH_TOKEN or install gh and run 'gh auth login'." >&2
  exit 1
fi

check_token_scopes() {
  local headers scopes
  headers=$(curl -sSI -H "Authorization: Bearer ${GH_TOKEN}" "https://api.github.com/user")
  scopes=$(echo "$headers" | awk -F': ' 'tolower($1)=="x-oauth-scopes" {print $2}' | tr -d '\r')

  if [[ -z "$scopes" ]]; then
    echo "Error: this token has no OAuth scopes." >&2
    echo "Create a classic token with the 'repo' scope at:" >&2
    echo "  https://github.com/settings/tokens/new?scopes=repo&description=win11-tiling-release" >&2
    exit 1
  fi

  if [[ "$scopes" != *"repo"* ]]; then
    echo "Error: token scopes are '${scopes}' but 'repo' is required." >&2
    echo "Create a new classic token with 'repo' at:" >&2
    echo "  https://github.com/settings/tokens/new?scopes=repo&description=win11-tiling-release" >&2
    exit 1
  fi
}

api_patch_json() {
  local url="$1"
  local payload="$2"
  local response http_code

  response=$(curl -sS -w "\n%{http_code}" -X PATCH \
    -H "Authorization: Bearer ${GH_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    -H "Content-Type: application/json" \
    "$url" \
    -d "$payload")
  http_code="${response##*$'\n'}"
  response="${response%$'\n'*}"

  if [[ "$http_code" -lt 200 || "$http_code" -ge 300 ]]; then
    echo "GitHub API error (${http_code}) for ${url}" >&2
    echo "$response" >&2
    exit 1
  fi
}

if [[ -n "${GH_TOKEN:-}" ]]; then
  check_token_scopes
fi

echo "==> Updating repo description"
if [[ -n "${GH_TOKEN:-}" ]]; then
  api_patch_json "https://api.github.com/repos/${REPO}" "$(python3 - <<'PY'
import json
print(json.dumps({
    "description": "Windows 11-style window tiling for Linux — GNOME & KDE packages for Debian, Fedora, RHEL, and Arch.",
    "homepage": "https://github.com/tunefriend/win11-tiling/releases/latest",
}))
PY
)"
else
  gh repo edit "${REPO}" \
    --description "Windows 11-style window tiling for Linux — GNOME & KDE packages for Debian, Fedora, RHEL, and Arch." \
    --homepage "https://github.com/tunefriend/win11-tiling/releases/latest"
fi

echo "==> Updating v1.0.1 release notes"
if [[ -n "${GH_TOKEN:-}" ]]; then
  api_patch_json "https://api.github.com/repos/${REPO}/releases/tags/v1.0.1" "$(python3 - <<'PY'
import json, pathlib
body = pathlib.Path("RELEASE_v1.0.1.md").read_text()
print(json.dumps({
    "name": "Win11 Window Tiling v1.0.1",
    "body": body,
}))
PY
)"
else
  gh release edit v1.0.1 --repo "${REPO}" \
    --title "Win11 Window Tiling v1.0.1" \
    --notes-file "$BODY_FILE"
fi

echo "==> Updating tunefriend profile"
PROFILE_BIO=$'TuneFriend — stream music from a friend\u2019s Subsonic/Navidrome server on Android.\nWin11 Window Tiling — Windows 11-style snap layouts for Linux (GNOME & KDE).\nGPL-3.0.'
if [[ -n "${GH_TOKEN:-}" ]]; then
  api_patch_json "https://api.github.com/user" "$(python3 - <<'PY'
import json, os
print(json.dumps({
    "name": "tunefriend",
    "bio": os.environ["PROFILE_BIO"],
}))
PY
)"
else
  gh api user -X PATCH -f name=tunefriend -f bio="$PROFILE_BIO"
fi

echo "Done."