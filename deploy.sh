#!/bin/bash

# 에러 발생 시 즉시 중단
set -e

echo -e "\033[0;32mDeploying updates to GitHub***\033[0m"

# 커밋 메시지 설정 (인자가 없으면 현재 시간 사용)
msg="update: $(date +"%Y-%m-%dT%H:%M:%S%z")"
if [ $# -eq 1 ]; then
  msg="$1"
fi

# 1. themes/Stack 업데이트 (변경사항이 있을 때만)
cd themes/Stack
CURRENT_THEME_BRANCH=$(git branch --show-current 2>/dev/null || echo "master")
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\033[0;32mUpdating themes/Stack submodule...\033[0m"
    git add .
    git commit -m "$msg"
    git push origin "$CURRENT_THEME_BRANCH"
fi
cd ../..

# 2. Hugo 빌드
echo -e "\033[0;32mBuilding site...\033[0m"
hugo --gc --minify

# 3. public (source 브랜치) 배포
cd public
git checkout source
git add .
if [ -n "$(git status --porcelain)" ]; then
    git commit -m "$msg"
    git pull origin source --rebase
    git push origin source
fi
cd ..

# 4. content (content 브랜치) 배포
cd content
git checkout content
git add .
if [ -n "$(git status --porcelain)" ]; then
    git commit -m "$msg"
    git pull origin content --rebase
    git push origin content
fi
cd ..

# 5. 메인 저장소 (main 브랜치) 업데이트
git add .
if [ -n "$(git status --porcelain)" ]; then
    git commit -m "$msg"
    git pull origin main --rebase
    git push origin main
fi

echo -e "\033[0;32mDone! All changes pushed successfully.\033[0m"