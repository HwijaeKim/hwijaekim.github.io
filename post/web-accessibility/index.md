+++
date = '2025-02-20'
draft = false
title = '웹 접근성'
categories = [
    'Development',
    'Research',
]
tags = [
    'w3c',
    'web accessibility'
]
image = 'teaser.webp'
+++

# 웹 접근성이란
장애인이나 고령자들이 웹 사이트에서 제공하는 정보를 비장애인과 동등하게 접근하고 이용할 수 있도록 보장하는 것
<br>
국제 웹 표준기구(W3C)에서 제정한 표준안, 총 33개의 항목으로 평가한다.

<br>

## 웹 접근성 준수 고려사항
### 시각
실명, 색각 이상, 다양한 형태의 저시력을 포함한 장애
<br>

### 이동성
특정 조건으로 인한 근육 속도 저하, 손으 쓰기 어렵거나 힘든 상태
<br>

### 청각
영상, 음성 콘텐츠에 자막, 원고, 수화등의 대체수단 부재로 인한 인식불가능 상태
<br>

### 인지
문제해결과 논리 능력, 집중력, 기억력에 문제(난독증, 난산증 등)
<br>




## 사용되는 보조기술
- 스크린 리더
- 화면 확대 도구
- 음성 인식
- 키보드 오버레이


---
<br>

# 기본적인 웹 접근성 준수 가이드
## 적절한 마크업 시맨틱 태그 사용
- `<header>, <nav>., <main>, <section>, <article>, <footer>`와 같이 스크린 리더가 각 섹션의 역할을 인식할 수 있도록 적절한 시맨틱 태그를 사용해야 한다.
- 제목태그 사용 `<h1> ~ <h6>`

<br>
---
<br>


# 중요하게 알아야 할 웹 접근성 항목
## 텍스트 외 콘텐츠에 대체 텍스트를 제공하여 이해할 수 있도록 해야 한다.
- 테이블, 이미지 등에 대한 대체 텍스트를 꼭 명시하여야 함.   
(주석, `font-size: 0;` 등은 스크린 리더도 인식하지 못 하기 떄문에 의미가 없음. CSS를 이용하여 지우기 `clip:rect()` 등)
<br>

- `img`태그 사용 시 반드시 `alt` 속성을 사용하여 어떤 이미지인지 인식할 수 있도록 대체 텍스트를 제공해야 함.   
- 의미가 없는 장식용 이미지에는 `alt=""` 속성을 사용하여 빈 문자열로 설정해야 함.
- 간혹 많은 양의 대체 텍스트를 제공해야 하는 경우에는 IR(Image Replacement)기법을 이용하여 마크업에서 대체 텍스트 작성 후 CSS를 통해 숨김.
```css
.blind {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
}
```
단, `visibility: hidden;, opacity: 0;, font-size: 0;` 등은 스크린 리더가 인식하지 못하기 때문에 사용하면 안됨.   
 ,`<img>`태그는 이미 이미지라는 의미를 갖고 있기 떄문에 대체 텍스트 내 '이미지' 단어 사용은 중복임.

- QR코드의 경우 `alt` 속성으로 해당 링크 주소까지 필수로 제공해야 함.
- `longdesc` 속성은 HTML5부터 사용하지 않음.



<br>

## 모든 기능은 키보드 조작만으로 사용할 수 있어야 한다.
- 테이블에 대한 정보(이름, 유형, 분류, 내용, 날짜 등)를 `<caption>` 태그에 명시 후 경우에 따라 안 보이게 처리.
- 단순 데이터용 테이블에는 `<th>` 요소를 제목 셀로 사용할 때 `scope="row"(행), scope="col"(열)` 속성을 사용하여 행과 열의 관계를 명시해야 함.

<br>

## 콘텐츠는 색에 관계 없이 인식될 수 있어야 함.
- 탭 메뉴 등에서 글꼴 색상만 변화하는 경우 일부 색약 사용자가 구분하기 어럽기 때문에 추가적인 표시 방법을 제공해야 함.
- 텍스트와 배경간 명도 대비는 4.5:1 이상이어야 함.   
[명도대비 계산 링크 바로가기(클릭)](https://sitero.co.kr/contrast)
![명도대비 부적합, +10쿠폰 박스의 텍스트, 배경간 명도대비가 2.917:1로 부적합 수준이다. 배경색은 연한 보라색, 텍스트는 흰색이다.](colorX.webp)
<br>
![명도대비 적합, +10%쿠폰박스의 텍스트, 배경간 명도대비가 11.607:1로 적합 수준이다. 배경은 진한 보라색, 텍스트는 흰색이다.](colorO.webp)

<br><br>


---

<br><br>

# 실제 사이트를 검사하며 새롭게 습득

## 버튼에 대한 용도 설명 `aria-label`
간혹 아이콘만으로 이루어진 버튼에 추가 설명이 제공되지 않는 경우가 있음.   
![찜하기, 재입고 알림 아이콘 버튼의 설명이 제공되지 않아 스크린 리더에서 공란으로 표시됨](button_captionX.webp)   
이 경우 스크린 리더에서 어떤 버튼인지 사용자에게 제공할 수 없음.
<br><br>
다음과 같이 `aria-label` 속성을 사용하여 버튼의 용도를 설명해야 함.
```html
<button class="btn" type="button" aria-label="찜하기">
<button class="btn" type="button" aria-label="재입고 알림">
```
![마크업에 aria-label 속성을 추가하여 이제는 스크린 리더에서 버튼의 용도를 제공해줌](button_captionO.webp)   

<br><br>

## `<div>, <ul>, <li>` 태그 등이 특정 기능을 한다면 `role` 속성을 사용하여 명시
특정 기능을 하는 요소라면 `role="tab"` 등과 같이 기능을 명시해야 함.

<br><br>

## ARIA




<br><br>
**참고링크**   
[https://velog.io/@leejpsd/CSS-IR-%EA%B8%B0%EB%B2%95](https://velog.io/@leejpsd/CSS-IR-%EA%B8%B0%EB%B2%95)   
[https://tech.kakaopay.com/post/accessibility-stories-for-everyone/#%ED%91%9C](https://tech.kakaopay.com/post/accessibility-stories-for-everyone/#%ED%91%9C)