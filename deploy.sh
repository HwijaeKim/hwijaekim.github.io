#!/usr/bin/env bash
set -euo pipefail

MAIN_BRANCH="main"
CONTENT_PATH="content"
CONTENT_BRANCH="content"
MSG="${1:-update: $(date -u +"%Y-%m-%dT%H:%M:%SZ")}"

cd "$(git rev-parse --show-toplevel)"

if [ -d "$CONTENT_PATH" ] && { [ -f "$CONTENT_PATH/.git" ] || [ -d "$CONTENT_PATH/.git" ]; }; then
  echo "[content] 브렌치 싱크"
  git -C "$CONTENT_PATH" fetch origin "$CONTENT_BRANCH"

  if [ -n "$(git -C "$CONTENT_PATH" status --porcelain)" ]; then
    git -C "$CONTENT_PATH" checkout -B "$CONTENT_BRANCH"
  elif git -C "$CONTENT_PATH" show-ref --verify --quiet "refs/heads/$CONTENT_BRANCH"; then
    git -C "$CONTENT_PATH" checkout "$CONTENT_BRANCH"
  else
    git -C "$CONTENT_PATH" checkout -B "$CONTENT_BRANCH" "origin/$CONTENT_BRANCH"
  fi

  if [ -n "$(git -C "$CONTENT_PATH" status --porcelain)" ]; then
    git -C "$CONTENT_PATH" add -A
    git -C "$CONTENT_PATH" commit -m "$MSG"
  fi

  git -C "$CONTENT_PATH" pull --rebase origin "$CONTENT_BRANCH"
  if [ "$(git -C "$CONTENT_PATH" rev-list --count "origin/$CONTENT_BRANCH..HEAD")" -gt 0 ]; then
    git -C "$CONTENT_PATH" push origin HEAD:"$CONTENT_BRANCH"
  fi
fi

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [ "$CURRENT_BRANCH" != "$MAIN_BRANCH" ]; then
  echo "다음에서 스크립트 실행: '$MAIN_BRANCH' (current: $CURRENT_BRANCH)" >&2
  exit 1
fi

echo "[main] 브렌치에 커밋 및 푸시"
git add -A
if git diff --cached --quiet; then
  echo "[main] 브렌치에 변경사항 없음"
  exit 0
fi

git commit -m "$MSG"
git pull --rebase origin "$MAIN_BRANCH"
git push origin "$MAIN_BRANCH"
echo "[완료] Github Action에서 빌드 및 배포 시작"
