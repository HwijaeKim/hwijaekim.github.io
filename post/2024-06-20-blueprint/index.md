+++
date = '2024-06-20'
draft = false
title = '제 30회 커뮤니케이션디자인국제공모전 동상 수상작 [청사진]'
description = '계원예술대학교'
categories = [
    'Projects',
    'Code',
]
tags = [
    'web-publishing', 'html/css/js', 'figma', '공모전'
]
image = 'teaser.webp'
+++
<style>
  .ico {
    border-radius: 5px;
    height: 30px;
    margin-bottom: 5px;
  }
</style>
<br>

## 📝 학교 밖 청소년들의 미래를 준비하기 위한 솔루션

| 구분 | 내용 |
| :--- | :--- |
| **기간** | 2024.03 ~ 2024.06 (2-1학기) |
| **인원** | 기획 1, 디자인 1, **개발 1** |
| **담당분야** | 팀장 및 서비스 비디오 촬영,<br>웹 콘텐츠 소스 제작 및 HTML/CSS/JS를 이용한 웹 제작 및 GitHub 배포 |
| **관련 링크** | [https://hwijaekim.github.io/blueprint2024](https://hwijaekim.github.io/blueprint2024) |

   <br><br>


## 🔑 핵심 기술 요약
- HTML/CSS/JS 세 가지를 이용하여 처음으로 제작한 웹 사이트 <br>
- 웹 표준을 준수하여 제작
- Web Fonts를 적용하여 웹 사이트를 더욱 완성도 있게 배포
- `Vanilla JavaScript`를 적극적으로 활용한 프로젝트이며 `Ovserver`를 이용하여 `Viewport`에 감지될 시 CSS `active`클래스를 토글하여 애니메이션을 구현. <br>
- `Typeit.js` 외부 라이브러리를 사용하여 타이핑 애니메이션 구현.

<br><br>

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/Lnxbw6FSc_I?si=LyU-lvSpD1P7YVNH" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

<br><br>

## 📌 주요 코드
### Web Fonts 및 <head> 정리
```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>청사진</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="./sources/site_icon.png">
<!--    CSS선언-->
    <link rel="stylesheet" href="./style/index_style.css">
    <link rel="stylesheet" href="./style/index_keyframe_media.css">

<!--    외부JS라이브러리 선언 >>TypeIt 비영리목적 무료-->
    <script src="https://unpkg.com/typeit@8.7.1/dist/index.umd.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/dixonandmoe/rellax@master/rellax.min.js"></script>

    <!--    WebFonts 선언-->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
</head>
```

### `Typeit.js` 라이브러리 사용
```javascript
//인트로 타이핑 애니메이션
new TypeIt(".intro_type", {
    lifeLike: false,
    loop: true,
    speed: 0
})
    .type("ㅂ")
    .pause(60)
    .delete(1)
    .type("부")
    .pause(149)
    .delete(1)
    .type("불")
    .pause(102)
    .delete(1)
    .type("부")
    .pause(3)
    .type("러")
    /*=====중간생략=====*/
    .delete(1)
    .type("하")
    .pause(498)
    .delete(1)
    .type("ㅎ")
    .pause(86)
    .delete(1)
    .pause(74)
    .delete(1)
    .pause(87)
    .delete(1)
    .pause(1000)
    .go();
```

### 스크롤을 통해 배경 이미지가 커지는 상호작용
```javascript
window.addEventListener('scroll', () => {
    let scrollTop = window.scrollY; //Y축 스크롤 값 저장
    let body_bg = document.querySelector('.main_img'); //배경으로 사용될 div 변수
    let newSize = scrollTop * 0.05 - 500;  //1920*1080기준 Y값 위치에 따라 이미지 크기가 조절될 수 있도록 값 조절(Y11000 기준)
    console.log(scrollTop); //Dev Only

    // Y축 10000이 되면 body_bg 스타일 background-image 추가
    if(scrollTop > 10000) {
        body_bg.style.cssText = 'background-image: url("./sources/bg_2.jpg"); filter: brightness(.45); opacity: 1; backdrop-filter: blur(10px);'
    }
    // Y축 11000이 되면 bakcgroundsize조정
    if( scrollTop > 11000) {
        body_bg.style.backgroundSize = 80 + newSize + '%';
    }
    // Y축 17000이 되면 background 흰색으로 복귀
    if(scrollTop > 17000) {
        body_bg.style.background = "white";
        body_bg.style.filter = "brightness(1)";
    }
});
```

<br><br>

## 🖥️ 사용 기술
<img class="ico" src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white">

<br><br>

## ⌨️ 총평
- Good Parts
  - HTML/CSS/JS를 모두 사용한 첫 프로젝트
  - 웹 표준을 준수한 개발
  - 외부 라이브러리를 학습하여 적용

- Bad Parts
  - 스크롤을 통해 배경 이미지가 커지는 상호작용 코드를 1920x1080기준 절대값으로 하드코딩 하였기 때문에 다른 해상도에서는 높은 확률로 의도하지 않은 결과를 초래
  - 시간관리 부족으로 일부 영역에서 통 이미지로 삽입함