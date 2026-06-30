#!/usr/bin/env bash
# Update the v1.0.1 release notes and repo description on GitHub.
# Auth options (pick one):
#   1. ./setup-github-token.sh   (browser login — recommended)
#   2. export GH_TOKEN=ghp_...   (classic token WITH repo scope checked)
set -euo pipefail

cd "$(dirname "$0")"

GH_USER="${1:-tunefriend}"
REPO="${GH_USER}/win11-tiling"
BODY_FILE="RELEASE_v1.0.1.md"
PROFILE_BIO=$'TuneFriend — stream music from a friend\u2019s Subsonic/Navidrome server on Android.\nWin11 Window Tiling — Windows 11-style snap layouts for Linux (GNOME & KDE).\nGPL-3.0.'

GH_BIN=""
if command -v gh >/dev/null 2>&1; then
  GH_BIN=gh
elif [[ -x /tmp/gh_2.74.2_linux_amd64/bin/gh ]]; then
  GH_BIN=/tmp/gh_2.74.2_linux_amd64/bin/gh
fi

token_scopes() {
  curl -sSI -H "Authorization: Bearer ${GH_TOKEN}" "https://api.github.com/user" \
    | awk -F': ' 'tolower($1)=="x-oauth-scopes" {print $2}' | tr -d '\r'
}

gh_has_repo_scope() {
  [[ -n "$GH_BIN" ]] && "$GH_BIN" auth status 2>&1 | grep -q "Token scopes:.*repo"
}

print_token_help() {
  cat >&2 <<'EOF'
No working GitHub credentials found.

EASIEST — browser login (recommended):
  ./setup-github-token.sh
  ./update-github-release.sh

OR — classic personal access token:
  1. Open: https://github.com/settings/tokens/new
  2. Note: win11-tiling-release
  3. Expiration: 30 days (or your choice)
  4. CHECK THE BOX: repo   <-- required (Full control of private repositories)
  5. Click "Generate token" at the bottom
  6. Copy the ghp_... token immediately
  7. export GH_TOKEN="ghp_..."
  8. ./update-github-release.sh

If you skip step 4, the token will have "Token scopes: none" and every write fails.
EOF
}

use_gh=false
use_token=false

if [[ -n "${GH_TOKEN:-}" ]]; then
  scopes=$(token_scopes || true)
  if [[ -n "$scopes" && "$scopes" == *"repo"* ]]; then
    use_token=true
  elif [[ -z "$scopes" ]]; then
    echo "Error: GH_TOKEN has no scopes (you did not check 'repo' when creating it)." >&2
    print_token_help
    exit 1
  else
    echo "Error: GH_TOKEN scopes are '${scopes}' but 'repo' is required." >&2
    print_token_help
    exit 1
  fi
elif gh_has_repo_scope; then
  use_gh=true
else
  print_token_help
  exit 1
fi

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

echo "==> Updating repo description"
if $use_token; then
  api_patch_json "https://api.github.com/repos/${REPO}" "$(python3 - <<'PY'
import json
print(json.dumps({
    "description": "Windows 11-style window tiling for Linux — GNOME & KDE packages for Debian, Fedora, RHEL, and Arch.",
    "homepage": "https://github.com/tunefriend/win11-tiling/releases/latest",
}))
PY
)"
else
  "$GH_BIN" repo edit "${REPO}" \
    --description "Windows 11-style window tiling for Linux — GNOME & KDE packages for Debian, Fedora, RHEL, and Arch." \
    --homepage "https://github.com/tunefriend/win11-tiling/releases/latest"
fi

echo "==> Updating v1.0.1 release notes"
if $use_token; then
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
  "$GH_BIN" release edit v1.0.1 --repo "${REPO}" \
    --title "Win11 Window Tiling v1.0.1" \
    --notes-file "$BODY_FILE"
fi

echo "==> Updating tunefriend profile"
if $use_token; then
  api_patch_json "https://api.github.com/user" "$(PROFILE_BIO="$PROFILE_BIO" python3 - <<'PY'
import json, os
print(json.dumps({
    "name": "tunefriend",
    "bio": os.environ["PROFILE_BIO"],
}))
PY
)"
else
  "$GH_BIN" api user -X PATCH -f name=tunefriend -f bio="$PROFILE_BIO"
fi

echo "Done."