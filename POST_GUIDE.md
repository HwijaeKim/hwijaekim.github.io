# 포스트 생성 가이드

이 문서는 Hugo 블로그에서 포스트를 생성하는 규칙과 가이드라인을 설명합니다.

## 디렉토리 구조

포스트는 다음 구조로 생성합니다:

```
content/post/[포스트-이름]/index.md
```

예시:
- `content/post/markdown-syntax/index.md`
- `content/post/my-new-post/index.md`

## Front Matter (메타데이터)

포스트는 TOML 형식(`+++`)의 Front Matter로 시작해야 합니다.

### 필수 필드

- `title`: 포스트 제목
- `date`: 작성일 (형식: "YYYY-MM-DD" 또는 "YYYY-MM-DD HH:MM:SS")

### 선택 필드

- `author`: 작성자 (기본값: "Hugo Authors")
- `description`: 포스트 설명/요약
- `tags`: 태그 배열
- `categories`: 카테고리 배열
- `series`: 시리즈 이름 (배열)
- `aliases`: 별칭 URL (배열)
- `image`: 대표 이미지 파일명 (같은 디렉토리에 위치)
- `draft`: 초안 여부 (true/false, 기본값: false)

### Front Matter 예시

```toml
+++
author = "Hugo Authors"
title = "포스트 제목"
date = "2024-01-15"
description = "포스트에 대한 간단한 설명"
tags = [
    "tag1",
    "tag2",
]
categories = [
    "카테고리1",
]
series = ["시리즈 이름"]
aliases = ["old-url"]
image = "featured-image.jpg"
draft = false
+++
```

## 이미지 사용

1. 이미지 파일을 포스트 디렉토리와 같은 위치에 저장합니다.
2. Front Matter의 `image` 필드에 파일명만 지정합니다.

예시:
```
content/post/my-post/
  ├── index.md
  └── featured-image.jpg
```

Front Matter:
```toml
image = "featured-image.jpg"
```

## 본문 작성

### 요약(Summary) 설정

포스트 목록에 표시될 요약을 설정하려면 본문 시작 부분에 `<!--more-->` 태그를 추가합니다.

```markdown
이 부분은 목록에서 요약으로 표시됩니다.
<!--more-->
이 부분은 포스트 상세 페이지에서만 표시됩니다.
```

### Markdown 문법

표준 Markdown 문법을 사용할 수 있으며, Hugo의 Shortcode도 사용 가능합니다.

## Permalink 규칙

`hugo.yaml` 설정에 따라 포스트 URL은 다음 형식을 따릅니다:

```
/p/:slug/
```

`:slug`는 파일명(디렉토리명)에서 자동 생성됩니다.

## 포스트 생성 예시

### 1. 디렉토리 생성

```bash
mkdir -p content/post/my-new-post
```

### 2. index.md 파일 생성

```markdown
+++
title = "새로운 포스트"
date = "2024-01-15"
description = "이것은 새로운 포스트입니다"
tags = ["hugo", "blog"]
categories = ["기술"]
draft = false
+++

포스트 내용의 시작 부분입니다.
<!--more-->

## 본문 제목

여기에 포스트의 본문 내용을 작성합니다.
```

### 3. 이미지 추가 (선택사항)

```bash
# 이미지 파일을 같은 디렉토리에 복사
cp /path/to/image.jpg content/post/my-new-post/
```

그리고 Front Matter에 추가:
```toml
image = "image.jpg"
```

## Archetype 사용

Hugo의 archetype을 사용하여 기본 템플릿으로 포스트를 생성할 수 있습니다:

```bash
hugo new post/my-new-post/index.md
```

현재 archetype 템플릿 (`archetypes/default.md`):
```toml
+++
date = '{{ .Date }}'
draft = true
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
+++
```

## 주의사항

1. **파일명**: 디렉토리명과 파일명은 URL slug로 사용되므로 영문과 하이픈(`-`)을 사용하는 것을 권장합니다.
2. **날짜 형식**: ISO 8601 형식 (`YYYY-MM-DD`)을 사용합니다.
3. **이미지 경로**: 이미지는 상대 경로로 참조하며, 포스트 디렉토리 내에 위치해야 합니다.
4. **초안 관리**: 작성 중인 포스트는 `draft = true`로 설정하여 배포되지 않도록 합니다.

## 참고

- Hugo 공식 문서: https://gohugo.io/content-management/
- Stack 테마 문서: https://stack.jimmycai.com/
