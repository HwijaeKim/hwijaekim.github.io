---
title:  "Jekyll 기반의 GitHub블로그 제작"
header:
  teaser: "/assets/images/posts_img/jekyll/teaser.webp"
categories:
  - Projects
  - Code
tags:
  - jekyll
  - github
toc: true
toc_sticky: true
toc_label: "Jekyll GitHub블로그"
---
<style>
  .ico {
    border-radius: 5px;
    height: 30px;
    margin-bottom: 5px;
  }
</style>
<br>
# 📝 포트폴리오 제작 플렛폼으로 선정한 Jekyll GitHub블로그

| **기간**    | 2024.09 ~                                                                                       |
| **인원**    | 개인                                                                                         |
| **담당분야**  | macOS, Windows 환경에서 Jekyll 환경 구축 및 테마 커스텀과 콘텐츠 삽입                                   |
| **관련 링크** | <a href="https://hwijaekim.github.io" target="_blank">https://hwijaekim.github.io</a> |

   <br><br>

# 🔑 핵심 기술 요약
- Jekyll을 설치하고 환경을 구축, 전체적인 워크플로우 숙지
- Markdown 문법 숙지
- GitHub 버전관리 시작
- 테마를 직접 커스텀

<br><br>

# 📌 주요 코드
## Markdown
```markdown
# h1
## h2
### h3
#### h4
##### h5
###### h6
*기울임꼴*
**굵게**
***굵은기울임꼴***
![이미지](/img/img.jpg)
| 기간                	| 내용                              	| 기관                          	| 구분           	|
|:-------------------:	|:--------------------:            	|:---------------------------:  |:----------:	    |
| 2021.09 - 2023.03    	| 육군 제 1보병사단 병장 만기전역     	| 국방부                        	| 병역   	        |
| 2021.01           	| 1종 보통 운전면허     	            | 경찰청(운전면허시험관리단)    	| 면허              	|
| 2019.09           	| 컴퓨터그래픽스운용기능사 	            | 한국산업인력공단               	| 자격              	|
# 🔑 핵심 기술 요약
- Jekyll을 설치하고 환경을 구축, 전체적인 워크플로우 숙지
- Markdown 문법 숙지
- GitHub 버전관리 시작
- 테마를 직접 커스텀
  [LinkedIn](https://www.linkedin.com/in/hwijaekim/)
```

## 홈 화면 게시물 커스텀
기존 홈 화면 최근 게시물을 Project 카테고리명을 가진 게시글들이 표시되도록 변경
```html
<h1>🖊️ 환영합니다: 포트폴리오</h1>

<div class="grid__wrapper">
  <!-- Jekyll문법은 Markdown 코드블럭에서도 무시되어 작동하는 문제가 있어 작동하지 않도록 의도적으로 슬래시를 삽입함 -->
    {/% assign posts = site.categories.Projects %}
    {/% for post in posts %}
    {/% include archive-single3.html type="list" %}
    {/% endfor %}
</div>
```

## 카테고리 생성
**<sub>navigation.yml</sub>**
```yaml
main:
  - title: "이력서/자기소개서"
    url: /about
  - title: "최근 게시물"
    url: /recent-posts

sidebar-category:
  - title: "Union Portfolio"
    children:
       - title: "Projects"
         url: "/categories/projects"
         category: "Projects"
       - title: "Code"
         url: "/categories/code"
         category: "Code"
       - title: "Design"
         url: "/categories/design"
         category: "Design"

  - title: "Development"
    children:
       - title: "Research"
         url: "/categories/research"
         category: "Research"
```

<br><br>

# 🖥️ 사용 기술
<sub><i>모든 Jekyll 포함 기술 중 직접 사용한 항목만 나열</i></sub><br>
<img class="ico" src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/markdown-%23000000.svg?style=for-the-badge&logo=markdown&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/GIT-E44C30?style=for-the-badge&logo=git&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/npm-CB3837?style=for-the-badge&logo=npm&logoColor=white">
<img class="ico" src="https://img.shields.io/badge/yaml-%23ffffff.svg?style=for-the-badge&logo=yaml&logoColor=151515">

<br><br>

# ⌨️ 총평
- Good Parts
  - 개발자 포트폴리오로 매우 적합한 플랫폼을 선정
  - Jekyll을 설치하고 공부하며 전체적인 워크플로우와 그 안에서 새롭게 배운 것들이 많음(Markdown, Git, 버전관리 등)
  - 초기셋팅 후 유지보수가 용이하도록 커스텀 및 장식(CSS)
  - 새로운 것들을 배우며 흥미도 상승

- Bad Parts
  - SCSS, Jekyll문법, yaml 등 아직 제대로 숙지하지 못 한 요소들이 존재