#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub***\033[0m"

# themes/Stack submodule에 변경사항이 있는지 확인하고 배포
cd themes/Stack
# submodule이 특정 커밋에 고정되어 있을 수 있으므로 master/main 브랜치로 체크아웃
git checkout master 2>/dev/null || git checkout main 2>/dev/null || true

if [ -n "$(git status --porcelain)" ]; then
    echo -e "\033[0;32mDeploying themes/Stack submodule changes...\033[0m"
    git add .
    
    # 인자가 없을 경우 현재 시간을 커밋 메시지로 등록
    msg="update: $(date +"%Y-%m-%dT%H:%M:%S%z")"
    if [ $# -eq 1 ]
      then msg="$1"
    fi
    
    git commit -m "$msg"
    # 기본 브랜치로 푸시 (master 또는 main)
    CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "master")
    git push origin "$CURRENT_BRANCH"
    echo -e "\033[0;32mthemes/Stack submodule deployed\033[0m"
fi
cd ../..

# submodule 변경사항이 있었다면 메인 리포지토리에서 submodule 참조 업데이트
if [ -n "$(git diff --submodule=short themes/Stack)" ]; then
    echo -e "\033[0;32mUpdating submodule reference in main repository...\033[0m"
    git add themes/Stack
fi

# 모든 서브모듈의 변경사항을 업데이트
git submodule update --init --recursive --remote

# `hugo -t <테마명>` 명령어로 Hugo 정적 페이지 렌더링
# `--gc` 옵션은 `garbage collection` 을 의미하며 불필요한 페이지를 삭제
hugo -t Stack --gc

# `source` 브랜치로 이동
cd public
git checkout source 2>/dev/null || git checkout -b source
git add .

# 인자가 없을 경우 현재 시간을 커밋 메시지로 등록
msg="rebuild: $(date +"%Y-%m-%dT%H:%M:%S%z")"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# 빌드 결과를 `source` 브랜치에 반영
git push origin HEAD:source

# `main` 브랜치로 이동
cd ..

# `content` 브랜치로 이동
cd content
git checkout content 2>/dev/null || git checkout -b content
git add .

if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"
git push origin HEAD:content

cd ..

# 현재까지의 변경사항을 `main` 브랜치에 반영
git add .

if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin main