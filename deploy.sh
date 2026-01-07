#!/bin/bash

# 에러 발생 시 즉시 중단
set -e

echo -e "\033[0;32mGitHub Actions 배포를 위한 프로세스가 시작됨...\033[0m"

# 커밋 메시지 설정
msg="update: $(date +"%Y-%m-%dT%H:%M:%S%z")"
if [ $# -eq 1 ]; then
  msg="$1"
fi

# ------------------------------------------------------------------
# 1. themes/Stack 업데이트 (변경사항이 있을 때만)
# ------------------------------------------------------------------
if [ -d "themes/Stack" ]; then
    cd themes/Stack
    CURRENT_THEME_BRANCH=$(git branch --show-current 2>/dev/null || echo "master")
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "\033[0;32m🎨 themes/Stack submodule 업데이트...\033[0m"
        git add .
        git commit -m "$msg"
        git push origin "$CURRENT_THEME_BRANCH"
    fi
    cd ../..
fi

# ------------------------------------------------------------------
# 2. content (content 브랜치) 업데이트
# ------------------------------------------------------------------
if [ -d "content" ]; then
    cd content
    git checkout content 2>/dev/null || git checkout main 
    
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "\033[0;32mcontent submodule 업데이트...\033[0m"
        git add .
        git commit -m "$msg"
        # 충돌 방지
        git pull origin content --rebase 2>/dev/null || git pull origin main --rebase
        git push origin HEAD
    fi
    cd ..
fi

# ------------------------------------------------------------------
# 3. 메인 저장소 업데이트 (GitHub Actions 트리거)
# ------------------------------------------------------------------
echo -e "\033[0;32m메인 소스 코드 저장 및 GitHub Actions 호출...\033[0m"
git add .
if [ -n "$(git status --porcelain)" ]; then
    git commit -m "$msg"
    git pull origin main --rebase
    git push origin main
else
    echo "메인 저장소에 변경 사항이 없어 푸시하지 않습니다."
fi

echo -e "\033[0;32m성공! 잠시 후 GitHub Actions가 배포를 수행합니다.\033[0m"