#!/usr/bin/env bash

set -Eeuo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

MAIN_BRANCH="main"
CONTENT_PATH="content"
CONTENT_BRANCH="content"
THEME_PATH="themes/Stack"
THEME_BRANCH="master"

msg="update: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
if [ $# -ge 1 ] && [ -n "${1:-}" ]; then
  msg="$1"
fi

log() {
  echo -e "${GREEN}$*${NC}"
}

warn() {
  echo -e "${YELLOW}$*${NC}"
}

die() {
  echo -e "${RED}$*${NC}" >&2
  exit 1
}

trap 'die "오류 발생 (line $LINENO). 배포를 중단합니다."' ERR

ensure_repo() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "Git 저장소에서 실행하세요."
  cd "$(git rev-parse --show-toplevel)"
}

ensure_submodules() {
  log "서브모듈 동기화 및 초기화..."
  git submodule sync --recursive
  git submodule update --init --recursive
}

checkout_tracking_branch() {
  local path="$1"
  local branch="$2"

  git -C "$path" rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "$path 는 Git 저장소가 아닙니다."
  git -C "$path" fetch origin "$branch"

  # detached HEAD + 로컬 수정 상태에서도 안전하게 브랜치로 복귀합니다.
  if [ -n "$(git -C "$path" status --porcelain)" ]; then
    git -C "$path" checkout -B "$branch"
  elif git -C "$path" show-ref --verify --quiet "refs/heads/$branch"; then
    git -C "$path" checkout "$branch"
  else
    git -C "$path" checkout -B "$branch" "origin/$branch"
  fi

  git -C "$path" branch --set-upstream-to "origin/$branch" "$branch" >/dev/null 2>&1 || true
}

sync_commit_push_submodule() {
  local path="$1"
  local branch="$2"
  local label="$3"

  if [ -n "$(git -C "$path" status --porcelain)" ]; then
    log "$label 변경사항 커밋..."
    git -C "$path" add -A
    git -C "$path" commit -m "$msg"
  fi

  git -C "$path" pull --rebase origin "$branch"

  if [ "$(git -C "$path" rev-list --count "origin/$branch..HEAD")" -gt 0 ]; then
    log "$label 푸시..."
    git -C "$path" push origin HEAD:"$branch"
  else
    log "$label 변경사항 없음."
  fi
}

update_content_submodule() {
  if [ ! -d "$CONTENT_PATH" ]; then
    warn "content 서브모듈이 없어 건너뜁니다."
    return
  fi

  log "content 서브모듈 정렬 중..."
  checkout_tracking_branch "$CONTENT_PATH" "$CONTENT_BRANCH"
  sync_commit_push_submodule "$CONTENT_PATH" "$CONTENT_BRANCH" "content"
}

update_theme_submodule() {
  if [ ! -d "$THEME_PATH" ]; then
    warn "themes/Stack 서브모듈이 없어 건너뜁니다."
    return
  fi

  # 테마는 의도하지 않은 포인터 변경을 막기 위해, 실제 수정이 있을 때만 브랜치를 만집니다.
  if [ -z "$(git -C "$THEME_PATH" status --porcelain)" ]; then
    log "themes/Stack 변경사항 없음."
    return
  fi

  log "themes/Stack 서브모듈 정렬 중..."
  checkout_tracking_branch "$THEME_PATH" "$THEME_BRANCH"
  sync_commit_push_submodule "$THEME_PATH" "$THEME_BRANCH" "themes/Stack"
}

update_main_repo() {
  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  if [ "$current_branch" != "$MAIN_BRANCH" ]; then
    die "메인 저장소는 '$MAIN_BRANCH' 브랜치에서 실행하세요. 현재 브랜치: $current_branch"
  fi

  log "메인 저장소 업데이트 중..."
  git add -A

  if git diff --cached --quiet; then
    log "메인 저장소 변경사항 없음. 푸시를 건너뜁니다."
    return
  fi

  git commit -m "$msg"
  git pull --rebase origin "$MAIN_BRANCH"
  git push origin "$MAIN_BRANCH"
}

main() {
  log "GitHub Actions 배포 프로세스 시작..."
  ensure_repo
  ensure_submodules
  update_content_submodule
  update_theme_submodule
  update_main_repo
  log "성공! 잠시 후 GitHub Actions가 배포를 수행합니다."
}

main "$@"
