#!/bin/bash

# 에러 발생 시 즉시 중단
set -e

echo -e "\033[0;32m배포 스크립트 시작\033[0m"

# 커밋 메시지 (입력 없으면 시간으로 자동 설정)
msg="update: $(date +"%Y-%m-%d %H:%M:%S")"
if [ $# -eq 1 ]; then msg="$1"; fi

# ------------------------------------------------------------------
# 1. themes/Stack 업데이트 (Target: master)
# ------------------------------------------------------------------
if [ -d "themes/Stack" ]; then
    cd themes/Stack
    # 변경사항이 있을 때만 동작
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "\033[0;33mThemes(Stack) 업데이트 중...\033[0m"
        git add .
        git commit -m "$msg"
        
        # [핵심] Detached HEAD 상태여도 강제로 원격 master에 병합
        git push origin HEAD:master
    fi
    cd ../..
fi

# ------------------------------------------------------------------
# 2. content 업데이트 (Target: content 브랜치)
# ------------------------------------------------------------------
CONTENT_BRANCH="content" 

if [ -d "content" ]; then
    cd content
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "\033[0;33mContent 업데이트 중...\033[0m"
        git add .
        git commit -m "$msg"
        
        # [핵심] 현재 상태를 원격의 지정된 브랜치로 전송
        git push origin HEAD:$CONTENT_BRANCH
    fi
    cd ..
fi

# ------------------------------------------------------------------
# 3. 메인 저장소 업데이트
# ------------------------------------------------------------------
echo -e "\033[0;32m메인 프로젝트 배포...\033[0m"
git add .
if [ -n "$(git status --porcelain)" ]; then
    git commit -m "$msg"
    git pull origin main --rebase
    git push origin main
else
    echo "메인 저장소에 변경 사항이 없습니다."
fi

echo -e "\033[0;32m배포 스크립트 완료!\033[0m"