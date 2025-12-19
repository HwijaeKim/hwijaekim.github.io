+++
date = '2023-12-21'
draft = false
title = '웹퍼블리싱 교과목 기말 프로젝트 [자기PR 페이지]'
description = '계원예술대학교'
categories = [
    'Projects',
    'Code',
]
tags = [
    'web-publishing', 'html/css'
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
## 📝 Apple macOS의 UI를 콘셉트로 제작한 자기PR 페이지

| **기간**    | 2023.11 ~ 12  (1-2학기)                                                                                      |
| **인원**    | 개인                                                                                         |
| **담당분야**  | 콘텐츠 구성 및 레이아웃 배치                                 |
| **관련 링크** | <a href="https://hwijaekim.github.io/unionpt" target="_blank">https://hwijaekim.github.io/unionpt</a> |

   <br><br>

## 🔑 핵심 기술 요약
- HTML과 CSS 기초를 배운 후 이를 이용하여 최초로 제작한 웹 사이트
- GitHub 가입과 리포지토리 생성 방법을 숙지한 후 처음으로 배포
- 기초CSS를 응용하고 리서치 하여 macOS 스타일의 UI를 구성하고 메뉴를 배치
- 여러 HTML 태그를 이용하여 코드를 작성

<br><br>
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/IIg2BRouWUc?si=Y_ywyBKQOWNxdV0o" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
<br><br>

## 📌 주요 코드
### HTML5 시멘틱 태그
```html
    <footer>
        <div id="footer_left">
            <p>Project Info. <br> Web Publishing Final Project | Desktop Concept Website Design.</p>
            <br>
            <p>Contact. <br> E-MAIL | kohga6007@kaywon.ac.kr <br> INSTAGRAM | Primary: @hwijae_kim &nbsp;&nbsp; Portfolio: @hwijae_portfolio</p>
        </div>

        <div id="footer_right">
            <p>Education. <br> Kaywon University of Art & Design | Digital Media Design</p>
            <br>
            <p>Copyright. <br> ©2023. KIM HWIJAE. All Rights Reserved.</p>
        </div>
    </footer>
```

### 마우스 hover, active
```css
        .nav_a:link, .nav_a:visited {
            margin-right: 10px;
            padding: 14px 15px;
            color: white;
            text-decoration: none;
            display: inline-block;
        }
        .nav_a:hover, .nav_a:active {
            margin-right: 10px;
            padding: 14px 15px;
            color: white;
            background-color: rgba(255, 255, 255, .3);
            border-radius: 10px;
        }
```


<br><br>

## 🖥️ 사용 기술
<img class="ico" src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white">


<br><br>

## ⌨️ 총평
- **Good Parts**
  - HTML/CSS를 이용하여 UI를 작성하고 콘셉트에 맞춘 레이아웃을 구성
  - 웹 사이트 개발의 기초를 다지고 실제 프로젝트를 진행
- **Bad Parts**
  - 기초를 학습하고 처음으로 진행한 프로젝트로 CSS를 분리하지 않고 HTML 내에서 작업함
  - JavaScript 학습 전으로 포함되지 않음
  - 웹 개발 시작 초반에 진횅한 프로젝트라 다소 미흡한 요소 존재