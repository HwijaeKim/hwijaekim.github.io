+++
date = '2025-11-29'
draft = true
title = 'Synology Docker를 이용한 Code-Server'
categories = [
    'Synology'
]
tags = [
    'nas', 'synology', 'docker', 'code-server'
]
image = 'teaser.webp'
+++

## 개요
최근 iPad를 구입하고 웹 개발 등에 활용해보고 싶어 여러 IDE 앱을 알아보고 실제로 사용해본 결과,
예상은 했지만 데스트콥 클래스의 IDE를 찾는 것은 불가능에 가까웠다.
   
그래도 찾은 앱 중 가장 유용했던 것은 유료 앱인 Code App인데 로컬에서 구동할 수 있는 가장 강력한 IDE같았다.   
사실 웹 이외의 언어 등에는 조예가 깊지 않아 확실하고 객관적인 판단은 물론 아니겠지만 
기본적인 HTML, CSS, JS는 VSCode와 비슷한 경험을 제공했다.

![iPad에서 구동 중인 Code App 화면](1.PNG)
상기 이미지는 React 프로젝트를 클론했지만 사실 작동하지 않는다.   
node.js가 내장되어 있긴 하지만 구버전 등의 문제로 터미널에서 npm 명령어가 제대로 작동하지 않았다.

<br>

## Synology를 선택한 이유
사용자의 시놀로지 모델은 DS1515+로 10년이 지난 구형 모델이다.   
CPU는 Intel Atom에 기본 RAM 용량은 DDR3 2GB로 VSCode를 구동하기에는 상다히 벅찰 수 있는 사양이다.   
그럼에도 Synology를 선택한 이유는

### 운영체제(DSM)와 Docker
Synology 운영체제는 리눅스를 기반으로 구동되며 기본 패키지로 Docker를 제공한다.   
리눅스 환경을 많이 접해보지 않았던 나는 손쉽게 구축할 수 있었다.
![시놀로지 NAS 컨테이너 매니저(Docker)에서 실행 중인 code-server 컨테이너의 개요 및 리소스 상태 확인 화면](3.png)


### 서버 환경 통합과 보안
필자는 Synology를 메인 홈 서버로 사용 중이라 최대한 이를 활용해보고 싶었다.
Github Actions