+++
date = '2024-11-21'
draft = false
title = '서버프로그래밍 교과목 기말 프로젝트 [유니픽스]'
description = '계원예술대학교'
categories = [
    'Projects', 'Code'
]
tags = [
    'back-end', 'node.js', 'mongodb', 'npm'
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
## 📝 Node.js와 MongoDB를 이용한 컴퓨터 수리 예약 사이트 [유니픽스]

| **기간**    | 2024.11 ~ 2024.12  (2-2학기)                                                                                       |
| **인원**    | 개인                                                                                         |
| **담당분야**  | 개발환경 구축, MongoDB 연결, `multer`를 이용한 이미지 업로드, 그 외 요소 구현     |
| **관련 링크** | <sub>학습 교재</sub><br>고영희 저 Do it! Node.js 프로그래밍 입문<br>쉽고 빠르게 달리는 백엔드 개발 / 자바스크립트+노드제이에스+익스프레스+몽고DB로 개발 순서에 따라 직접 서버 만들기! |

<br><br>

## 🔑 핵심 기술 요약
- `js, Node.js, express, MongoDB`를 이용한 기초 express 서버 제작
- `GET, POST, PUT, DELETE` 메서드를 요청하고 응답을 처리하는 메서드 구성
- 템플릿 엔진으로 `ejs` 연결
- `jsonwebtoken(JWT), cookie`를 이용한 비밀번호 암호화 및 토큰, 쿠키로 어드민 회원가입/로그인 관리
- 어드민 계정과 전용 페이지
- `multer`를 이용한 이미지 업로드

<br><br>
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/lcYLc4jGij4?si=4T4IaI89ezR3GTJH" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe><br><br>

## 📌 주요 코드
### npm 패키지
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

### `env` 설정
```
DB_CONNECT = mongodb+srv://(SECURITY).mongodb.net/unifixData
JWT_SECRET= (SECURITY)
```

### `app.js`, `main.js`, `admin.js` 선언한 모듈
```javascript
/*====================app.js====================*/
require('dotenv').config({ path: './path/to/.env' });
const express = require("express");
const expressEjsLayouts = require("express-ejs-layouts");
const connectDb = require("./config/db"); // DB 연결 함수 가져오기
const cookieParser = require("cookie-parser"); // 쿠키 파서 가져오기
const methodOverride = require("method-override")

// 이미지 업로드 관련
const multer = require('multer');
const Image = require('./models/Article');
const path = require('path');
const fs = require('fs');

const app = express();
const port = process.env.PORT || 3001


/*====================main.js====================*/
const express = require("express");
const router = express.Router();
const mainLayout = "layouts/main";
const Comment = require("../models/News");
const Contact = require('../models/Order');
const Article = require('../models/Article');
// const Image = require("../models/Images");
const asynchandler = require("express-async-handler");


/*====================amdin.js====================*/
const express = require("express");
const router = express.Router();
const adminLayout = "layouts/admin";
const adminLayout2 = "layouts/admin-nologout";
const asyncHandler = require("express-async-handler");
const bcrypt = require("bcrypt");
const User = require("../models/User");
const Comment = require("../models/News");

const jwt = require("jsonwebtoken");
const JWT_SECRET = process.env.JWT_SECRET;
```

### 메인(`main.js`) 라우트
```javascript
// GET
// "/home" 라우트
router.get(
  ["/", "/order"],
  asynchandler(async (req, res) => {
    const contacts = await Contact.find();
    res.render("order", { contacts: contacts, layout: mainLayout });  //미리 설정한 레이아웃 사용
  })
);

// POST
router.post(
        "/newOrder",
        asynchandler(async (req, res) => {
          const { devicename, casewhat, sangtae, name, phone, email } = req.body;
          if(!devicename || !casewhat || !sangtae || !name || !phone || !email) {
            return res.status(400).send('필수값이 입력되지 않았습니다.');
          }
          const contact = await Contact.create({
            devicename,
            casewhat,
            sangtae,
            name,
            phone,
            email,
          });
          // res.status(201).send("사용자 데이터 생성됨");
          res.redirect("/order"); //mid add
        })
)

// PUT
router.put(
  "/order/:id",
  asynchandler(async (req, res) => {
    const id = req.params.id;
    const { devicename, casewhat, sangtae, name, phone, email } = req.body;
    const contact = await Contact.findById(id);
    if(!contact) {
        res.status(404);
        throw new Error('사용자 데이터 찾을 수 없음');
    }
    // 수정
    contact.devicename = devicename;
    contact.casewhat = casewhat;
    contact.sangtae = sangtae;
    contact.name = name;
    contact.email = email;
    contact.phone = phone;
    // 저장
    contact.save();
    //mid add
    res.redirect("/order");
  })
)

// DELETE
router.delete(
  "/delete/:id",
  asynchandler(async (req, res) => {
    await Contact.deleteOne({_id: req.params.id});
    res.redirect('/order');
  })
);
```
### 어드민(`admin.js`) 인증 토큰
```javascript
// Check Login
const checkLogin = async (req, res, next) => {
  const token = req.cookies.token; // 쿠키 정보 가져오기

  // 토큰이 없다면
  if (!token) {
    return res.redirect("/admin");
  }

  // 토큰이 있다면 토큰을 확인하고 사용자 정보를 요청에 추가
  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.userId = decoded.userId; // res.userId가 아닌 req.userId에 저장
    next();
  } catch (error) {
    return res.redirect("/admin");
  }
};

// POST /admin
// 관리자 페이지 로그인
router.post(
        "/admin",
        asyncHandler(async (req, res) => {
          const { username, password } = req.body; // req.body에서 username과 password를 가져옴

          // 사용자 이름으로 사용자 찾기
          const user = await User.findOne({ username });

          // 일치하는 사용자가 없으면 에러 메시지 출력
          if (!user) {
            return res.status(401).json({ message: "일치하는 사용자가 없습니다." });
          }
          const isValidPassword = await bcrypt.compare(password, user.password);

          // 비밀번호가 일치하지 않으면 에러 메시지 출력
          if (!isValidPassword) {
            return res.status(401).json({ message: "비밀번호가 일치하지 않습니다." });
          }

          // JWT 토큰 생성
          const token = jwt.sign({ id: user._id }, JWT_SECRET);

          // JWT 토큰을 쿠키에 저장
          res.cookie("token", token, {
            httpOnly: true,
          });

          // 로그인에 성공하면 전체 게시물 목록 페이지로 이동
          res.redirect("/allPosts");
        })
);

// 회원가입
router.get('/register', (req, res) => {
  res.render('admin/register', {layout: adminLayout2});
})


router.post(
        '/register',
        asyncHandler(async (req, res) => {
          const {username, password, password2} = req.body;
          if(password === password2) {
            // bcrypt를 사용해 비밀번호를 암호화
            const hashedPassword = await bcrypt.hash(password, 10);
            console.log(hashedPassword);
            // 사용자 이름과 암호화된 비밀번호를 사용해서 새 사용자를 생성
            const user = await User.create({ username, password: hashedPassword});
            // 성공메시지 출력
            res.status(201).json({message: "Register successful", user})
          }
          else {
            res.send("Register Failed")
          }
        })
)
```
![token](token.webp)


<br><br>

## 🖥️ 사용 기술
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

## ⌨️ 총평
- **Good Parts**
  - 기본적인 라우트 프로세스를 숙지
  - `GET`, `POST`, `PUT`, `DELETE` 메서드를 요청, ejs템플릿엔진으로 렌더링
  - 스키마를 생성하고 MongoDB 데이터베이스와 연동 및 불러오기
  - `multer`를 이용한 이미지 업로드
  - 백엔드 프로세스에 대한 일부 기초적인 이해
- **Bad Parts**
  - 사이트 메인 로그인 구현 부재
  - 처음 접하는 백엔드 프로세스로 다소 미흡함 존재
  - 일부 프로세스에 대한 이해 부족으로 완전히 소화하지 못 함