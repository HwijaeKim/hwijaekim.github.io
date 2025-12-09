# PowerShell 배포 스크립트

Write-Host "Deploying updates to GitHub***" -ForegroundColor Green

# 모든 서브모듈의 변경사항을 업데이트
git submodule update --init --recursive --remote

# `hugo -t <테마명>` 명령어로 Hugo 정적 페이지 렌더링
# `--gc` 옵션은 `garbage collection` 을 의미하며 불필요한 페이지를 삭제
hugo -t Stack --gc

# `public` 디렉토리로 이동
Set-Location public

git add .

# 인자가 없을 경우 현재 시간을 커밋 메시지로 등록
$msg = "rebuild: $(Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz')"
if ($args.Count -eq 1) {
    $msg = $args[0]
}
git commit -m "$msg"

# 빌드 결과를 `source` 브랜치에 반영
git push origin source

# 상위 디렉토리로 이동
Set-Location ..

# 현재까지의 변경사항을 `main` 브랜치에 반영
git add .

if ($args.Count -eq 1) {
    $msg = $args[0]
}
git commit -m "$msg"

git push origin main

