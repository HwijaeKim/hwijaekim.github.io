+++
date = '2025-03-28'
draft = false
title = '프롬프트 엔지니어링 Part.02 - 예제 적용'
categories = [
    'Development', 'Research'
]
tags = [
    'prompt-engineering', 'llm', 'ai', 'chatgpt', 'prompt'
]
image = 'teaser.webp'
+++

## 개요
---
이전 포스트에서 프롬프트 엔지니어링에 대한 기초적인 이론을 정리했다.   
이렇게 이론을 학습하고 정리했으니 이번 포스트에서는 실제 예제 프롬프트를 작성해보자.   
- 프롬프트를 작성해 Vanilla JavaScript 코드를 만들고 HTML, CSS 코드 등을 리펙토링
- React의 작동 원리를 설명하고 Vanilla JavaScript와의 차이점 서술

---
<br><br>


## 연습
## 01. Vanilla JavaScript 코드 작성
첫 번째 연습으로 아주 간단한 코드 짜는 요청을 날려보자.   
요구사항은 다음과 같다:
- JavaScript로 작성될 것
- prompt로 입력받을 것
- alert으로 출력할 것

<br>
첫 번째로 아주 단순하게 딱 한줄로만 요청을 보내보자.   
<br>
*Prompt.*
```
이름 받고 이름 말하면서 인사하는 코드 짜줘
```
<br>

*Output.*
*<sub>(OpenAI ChatGPT-4o)</sub>*
```
물론이지! 아래는 사용자의 이름을 입력받고, 그 이름을 사용해서 인사하는 간단한 파이썬 코드야
name = input("이름을 입력해주세요: ")
print(f"{name}님, 안녕하세요!")

실행하면 예를 들어:
이름을 입력해주세요: 지민
지민님, 안녕하세요!
```
당연한 결과일 수 있다...   
프롬프트에 자세한 요구사항을 적어놓지 않으니 전혀 다른 결과를 출력했다.   
<br>

이제 자세한 프롬프트를 작성해보자.   
<br>

*Prompt.*
```
/*
이름을 prompt로 입력받고 alert으로 이름을 포함한 인사 문구를 출력해줘
*/
```
<br>

*Output.*
*<sub>(OpenAI ChatGPT-4o)</sub>*
```
// 이름을 입력받는다
let name = prompt("이름을 입력해주세요:");

// 인사 문구를 출력한다
alert("안녕하세요, " + name + "님! 반갑습니다 :)");
```
아주 간단한 연습이지만 결과 개선이 있다.   
<br><br>

### 02. HTML 리펙토링
이번에는 HTML 코드를 리펙토링 하는 프롬프트를 작성해보자.   
<br>

*Prompt.*
```
### HTML 리펙토링 요청 ###
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electronics Teardown</title>
</head>
<body>
    <div id="header">
        <a class="a3" href="index.html">
            <img src="./img/logo.png" height="120">
        </a>
        <div id="navigation">
            <a href="detail_specs.html">상세스펙</a>&nbsp;
            <a href="teardown_main.html">분해도 단면</a>&nbsp;
            <a href="suggest.html">기기 제안하기</a>&nbsp;
            <a href="warning.html">분해 전 유의사항</a>&nbsp;
            <a href="device_manage.html">효율적인 기기관리</a>
        </div>
    </div>

    <!--구분선-->

    <div class="clear"></div>

    <div id="aside">
        <h1 class="titlemargin">일렉트로닉스 테어다운에 오신 것을 환영합니다</h1><span>여러 기기의 분해도 단면을 확인해보세요.</span>
    </div>
        
    <div id="section">
        <video src="./img/phone_ani.mp4" width="400" autoplay loop muted></video><br><br>
        <p class="bold" id="quickbutton">QUICK BUTTON</p>
        <a class="a2"  href="detail_specs.html">상세 스펙</a>
        <a class="a2" href="teardown_main.html">분해도</a>
    </div>
    <div class="clear"></div>

    <div id="footer"><p>KUAD | DIGITAL MEDIA DESIGN <br> ELECTRONICS TEARDOWN-- Web Publishing. <br> ©️2023. KIM HWIJAE. All rights reserved. <br> 사용된 글꼴 Lemon/Milk, LINE Seed Sans KR은 교육(개인) 목적으로만 사용됩니다.</p></div>
    <div class="clear"></div>
</body>
</html>
```
<br>

*Output.*
*<sub>(OpenAI ChatGPT-4o)</sub>*
```
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Electronics Teardown</title>
  <link rel="stylesheet" href="styles.css"> <!-- 스타일 분리 추천 -->
</head>
<body>

  <header id="header">
    <a href="index.html" class="logo">
      <img src="./img/logo.png" alt="Electronics Teardown 로고" height="120">
    </a>
    <nav id="navigation">
      <a href="detail_specs.html">상세스펙</a>
      <a href="teardown_main.html">분해도 단면</a>
      <a href="suggest.html">기기 제안하기</a>
      <a href="warning.html">분해 전 유의사항</a>
      <a href="device_manage.html">효율적인 기기관리</a>
    </nav>
  </header>

  <main>
    <section id="intro">
      <h1 class="title">일렉트로닉스 테어다운에 오신 것을 환영합니다</h1>
      <p class="subtitle">여러 기기의 분해도 단면을 확인해보세요.</p>
    </section>

    <section id="media">
      <video src="./img/phone_ani.mp4" width="400" autoplay loop muted></video>
    </section>

    <section id="quick-buttons">
      <p class="bold">QUICK BUTTON</p>
      <div class="button-group">
        <a href="detail_specs.html" class="button">상세 스펙</a>
        <a href="teardown_main.html" class="button">분해도</a>
      </div>
    </section>
  </main>

  <footer id="footer">
    <p>
      KUAD | DIGITAL MEDIA DESIGN <br>
      ELECTRONICS TEARDOWN - Web Publishing. <br>
      ©️2023. KIM HWIJAE. All rights reserved. <br>
      사용된 글꼴 Lemon/Milk, LINE Seed Sans KR은 교육(개인) 목적으로만 사용됩니다.
    </p>
  </footer>

</body>
</html>
```
<br><br>


### 03. React 설명
*Prompt.*
```
나: 너는 고도로 학습된 IT어드바이저야. 너가 설명할 대상은 기본적인 HTML/CSS/JS는 인지하고 있는 상태야.
너: 네, 알겠습니다.
나: React의 작동 원리를 설명해주고 2~3가지 핵심으로 요약해줘
너:
```
<br>

*Output.*
*<sub>(OpenAI ChatGPT-4o)</sub>*
```
✅ React의 작동 원리
React는 사용자 인터페이스(UI)를 컴포넌트 단위로 쪼개어 개발할 수 있게 해주고, 변화가 생겼을 때 최소한의 DOM 조작만으로 빠르게 UI를 업데이트해주는 JavaScript 라이브러리야.

🔑 핵심 요약 (2~3가지 포인트)
1.	Virtual DOM (가상 DOM)
  •	실제 DOM 조작은 느리기 때문에, React는 먼저 Virtual DOM에서 상태 변화에 따른 UI 변경을 시뮬레이션함.
  •	변경 전후의 Virtual DOM을 비교(Diffing)하고, 바뀐 부분만 실제 DOM에 적용함 (Reconciliation).
  •	👉 이 과정을 통해 성능을 크게 개선함. 

2.	컴포넌트 기반 구조
  •	UI를 독립적이고 재사용 가능한 컴포넌트(Component) 단위로 구성.
  •	각각의 컴포넌트는 자신만의 상태(state)와 속성(props)을 가짐.
  •	👉 유지보수성과 재사용성이 매우 뛰어남.
  
3.	단방향 데이터 흐름 (One-way Data Binding)
  •	데이터는 부모 → 자식 방향으로만 흐름.
  •	컴포넌트 간의 데이터 흐름이 예측 가능하고, 디버깅이 쉬워짐.
  •	상태 관리는 useState/useReducer 같은 Hook으로 처리함.
```
<br><br><br>


*Prompt.*
```
나: 너는 고도로 학습된 IT어드바이저야. 너가 설명할 대상은 기본적인 HTML/CSS/JS는 인지하고 있는 상태야.
너: 네, 알겠습니다.
나: React의 작동 원리를 설명해주고 2~3가지 핵심으로 요약해줘
너:
```
<br>

*Output.*
*<sub>(OpenAI ChatGPT-4o)</sub>*
```
✅ React의 작동 원리
React는 사용자 인터페이스(UI)를 컴포넌트 단위로 쪼개어 개발할 수 있게 해주고, 변화가 생겼을 때 최소한의 DOM 조작만으로 빠르게 UI를 업데이트해주는 JavaScript 라이브러리야.

🔑 핵심 요약 (2~3가지 포인트)
1.	Virtual DOM (가상 DOM)
  •	실제 DOM 조작은 느리기 때문에, React는 먼저 Virtual DOM에서 상태 변화에 따른 UI 변경을 시뮬레이션함.
  •	변경 전후의 Virtual DOM을 비교(Diffing)하고, 바뀐 부분만 실제 DOM에 적용함 (Reconciliation).
  •	👉 이 과정을 통해 성능을 크게 개선함. 

2.	컴포넌트 기반 구조
  •	UI를 독립적이고 재사용 가능한 컴포넌트(Component) 단위로 구성.
  •	각각의 컴포넌트는 자신만의 상태(state)와 속성(props)을 가짐.
  •	👉 유지보수성과 재사용성이 매우 뛰어남.
  
3.	단방향 데이터 흐름 (One-way Data Binding)
  •	데이터는 부모 → 자식 방향으로만 흐름.
  •	컴포넌트 간의 데이터 흐름이 예측 가능하고, 디버깅이 쉬워짐.
  •	상태 관리는 useState/useReducer 같은 Hook으로 처리함.
```