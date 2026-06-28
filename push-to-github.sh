#!/usr/bin/env bash
set -euo pipefail

GIT_BIN="${GIT_BIN:-git}"
if [[ -x "${HOME}/.local/git/usr/bin/git" ]]; then
  export PATH="${HOME}/.local/git/usr/bin:${PATH:-}"
  export GIT_EXEC_PATH="${HOME}/.local/git/usr/lib/git-core"
fi

cd "$(dirname "$0")"

GH_USER="${1:-tunefriend}"
REMOTE="git@github.com:${GH_USER}/win11-tiling.git"

git config user.name "tunefriend"
git config user.email "thedude.west@gmail.com"

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE"
else
  git remote add origin "$REMOTE"
fi

echo "Pushing to $REMOTE"
git push -u origin main --tags

echo ""
echo "Repo: https://github.com/${GH_USER}/win11-tiling"
echo "Release: https://github.com/${GH_USER}/win11-tiling/releases/tag/v1.0.1"