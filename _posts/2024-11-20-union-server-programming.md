---
title:  "서버프로그래밍 교과목 실습응용 [블로그 express 서버]"
header:
  teaser: "/assets/images/posts_img/union-server-programming/teaser.webp"
categories:
  - Projects
  - Code
tags:
  - back-end
  - node.js
  - mongodb
  - npm
toc: true
toc_sticky: true
toc_label: "MongoDB를 이용한 express 서버"
---
<style>
  .ico {
    border-radius: 5px;
    height: 30px;
    margin-bottom: 5px;
  }
</style>
<br>
# 📝 MongoDB를 이용한 이미지 업로드를 지원하는 블로그 express 서버

| **기간**    | 2024.11 ~ 2024.12  (2-2학기)                                                                                       |
| **인원**    | 개인                                                                                         |
| **담당분야**  | 개발환경 구축, MongoDB 연결, `multer`를 이용한 이미지 업로드, 그 외 일부 `html, css`를 제외한 요소 구현     |
| **관련 링크** | <sub>학습 교재</sub><br>고영희 저 Do it! Node.js 프로그래밍 입문<br>쉽고 빠르게 달리는 백엔드 개발 / 자바스크립트+노드제이에스+익스프레스+몽고DB로 개발 순서에 따라 직접 서버 만들기! |

<br><br>

# 🔑 핵심 기술 요약
- `js, Node.js, express, MongoDB`를 이용한 기초 express 서버 제작
- `GET, POST, PUT, DELETE` 메서드를 요청하고 처리
- 요청/응답을 처리하는 미들웨어 구성
- 템플릿 엔진으로 `ejs` 연결
- `jsonwebtoken(JWT), cookie`를 이용한 비밀번호 암호화 및 토큰, 쿠키로 어드민 회원가입/로그인 관리
- `multer`를 이용한 이미지 업로드

<br><br>
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/0P2YOqhIdNU?si=8fWrtM4jE-sBGi4U" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
<br><br>

# 📌 주요 코드
## 디렉토리 구조
```bash
├── app.js
├── config
│   └── db.js
├── models
│   ├── Images.js
│   ├── Post.js
│   └── User.js
├── package-lock.json
├── package.json
├── public
│   ├── css
│   │   └── style.css
│   ├── img
│   │   ├── 000446340005_2.jpg
│   │   ├── 1.webp
│   │   ├── banner.jpg
│   │   └── logo.svg
│   └── scripts
├── routes
│   ├── admin.js
│   ├── main.js
├── uploads
└── views
    ├── about.ejs
    ├── addImage.ejs
    ├── admin
    │   ├── add.ejs
    │   ├── allPosts.ejs
    │   ├── edit.ejs
    │   └── index.ejs
    ├── index.ejs
    ├── layouts
    │   ├── admin-nologout.ejs
    │   ├── admin.ejs
    │   └── main.ejs
    └── post.ejs
```

## npm 패키지
```json
  "dependencies": {
    "bcrypt": "^5.1.1",
    "cookie-parser": "^1.4.7",
    "dotenv": "^16.4.5",
    "ejs": "^3.1.10",
    "express": "^4.21.1",
    "express-async-handler": "^1.2.0",
    "express-ejs-layouts": "^2.5.1",
    "gridfs-stream": "^1.1.1",
    "install": "^0.13.0",
    "jsonwebtoken": "^9.0.2",
    "method-override": "^3.0.0",
    "mongoose": "^8.8.1",
    "multer": "^1.4.5-lts.1",
    "nodemon": "^3.1.7",
    "npm": "^10.9.0"
  }
```

## env 설정
```
DB_CONNECT = mongodb+srv://(SECURITY).mongodb.net/myBlog
JWT_SECRET= (SECURITY)
```

## main.ejs
*메인 레이아웃을 지정*
```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= locals.title %></title>
    <meta name="description" content="My first application using Node.js, Express and MongoDB">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="container">

    <!-- 헤더 : 로고, 상단 메뉴, 로그인 -->
    <header class="header">
        <!-- 로고 -->
        <a href="/" class="header-logo">{ Geek Code }</a>

        <!-- 상단 메뉴 -->
        <nav class="header-nav">
            <ul>
                <li>
                    <a href="/home">{ Home }</a>
                </li>
                <li>
                    <a href="/about">{ About }</a>
                </li>
                <li>
                    <a href="/upload">{ Upload }</a>
                </li>
            </ul>
        </nav>

        <!-- 관리자 로그인 -->
        <div class="header-button">
            <a href="/admin">관리자 로그인</a>
        </div>
    </header>

    <!-- 메인 : 실제 내용이 들어갈 부분 -->
    <main class="main">
        <%- body %>
    </main>
</div>

</body>
</html>
```

## app.js, main.js에 선언한 모듈
```javascript
/*==========app.js==========*/
require('dotenv').config({ path: './path/to/.env' });
const express = require("express");
const expressEjsLayouts = require("express-ejs-layouts");
const connectDb = require("./config/db"); // DB 연결 함수 가져오기
const cookieParser = require("cookie-parser"); // 쿠키 파서 가져오기
const methodOverride = require("method-override")

// 이미지 업로드 관련
const multer = require('multer');
const Image = require('./models/Images');
const path = require('path');
const fs = require('fs');

const app = express();
const port = process.env.PORT || 3001 // .env에 포트가 없으면 3001번 포트로 설정



/*==========main.js==========*/
const express = require("express");
const router = express.Router();
const mainLayout = "layouts/main";
const Post = require("../models/Post");
const asynchandler = require("express-async-handler");
```

## routes/main.js >> 홈 라우트
```javascript
// "/home" 라우트
router.get(
  ["/", "/home"],  //루트경로와 /home 경로에서 GET 요청 발생시 동작
  asynchandler(async (req, res) => {  //비동기 처리
    const locals = {  //title은 각 ejs의 타이틀명을 설정
      title: "Home",
    };
      /**
       * MongoDB에서 데이터 조회 후 정렬.
       * 이때 .sort를 이용하여 최신순으로 재졍렬
       */
    const data = await Post.find().sort({ updatedAt: "desc", createdAt: "desc" });

      /**
       * mainLayout을 레이아웃 템플릿으로 사용.
       * const mainLayout = "layouts/main";
       */
    res.render("index", { locals, data, layout: mainLayout });
  })
);
```

<br><br>

# 🖥️ 사용 기술
<img class="ico" src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/npm-CB3837?style=for-the-badge&logo=npm&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/MongoDB-4EA94B?style=for-the-badge&logo=mongodb&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/ejs-%23B4CA65.svg?style=for-the-badge&logo=ejs&logoColor=black">
<img class="ico" src="https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB">
<img class="ico" src="https://img.shields.io/badge/NODEMON-%23323330.svg?style=for-the-badge&logo=nodemon&logoColor=%BBDEAD">
<img class="ico" src="https://img.shields.io/badge/JWT-black?style=for-the-badge&logo=JSON%20web%20tokens">


<br><br>

# ⌨️ 총평
- **Good Parts**
  - 최초로 시도한 백엔드 프로세스
  - Node.js와 npm 그리고 express서버 구축에 대한 기초를 경험
- **Bad Parts**
  - 처음 경험하는 다소 높은 난이도의 백엔드 구축으로 완전히 본인의 것으로 소화하지 못 하여 지속적인 학습 필요
  - 능동적으로 코드를 이해하고 작성하는 것에 다소 미흡함이 존재












