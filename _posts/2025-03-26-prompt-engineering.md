---
title:  "프롬프트 엔지니어링 Part.01"
header:
  teaser: "/assets/images/posts_img/prompt_engineering/teaser.webp"
categories:
  - Research
tags:
  - prompt-engineering
  - llm
  - ai
  - chatgpt
  - prompt
toc: true
toc_sticky: true
toc_label: "프롬프트 엔지니어링 Part.01"
---
<br>

# 개요
회사에 퍼블리셔로 입사 후 AI에이전트(ChatGPT, Claude 등)를 사용하는 빈도가 급격히 증가했다.   
물론 이전에도 자주 사용했지만 특히 더 사용하게 되는 것 같다는 생각이 들었다.   
이전부터 AI에게 질문을 날리는 것에 대해 크게 생각하지 않고 생각하는 대로 적어 질문을 날리곤 했고, 지금도 마찬가지다.   
<br>
그러다보니 원하는 답변을 빠른 시간 내 얻는데 문제가 생기는 경우가 종종 발생했고, 그럴 때마다 조건을 하나하나 추가하면서 추가질문을 던졌다.   
이것이 반복되다보니 총 답변 양도 길어지고 그래서 결론적으로 내가 어떤 질문을 했는지, 어디의 어느 코드가 내가 원하는 코드인지 헷갈리는 경우가 많아졌다.  
대형언어모델(LLM)에게 질문을 하는 이유가 빠른 시간 내 원하는 해결책, 답변을 얻는 것인데 그 장점이 약간 사라지는 것이다. (물론 인터넷 검색보다는 빠른 경우가 대부분이긴 하다.)   
아무튼 나는 LLM에 질문을 던질 때 더 확실하고 정확한 값을 적은 프롬프트로 얻기 위해 **프롬프트 엔지니어링**에 대해 공부해 보기로 했다.   
<br>
이 문서는 프롬프트 엔지니어링에 대한 기본적인 개념과 원리를 이해하고, 실제 프롬프트를 작성하는 방법을 정리한다.

<br>
---
<br>


# 참고문서
- [promptingguide.ai](https://www.promptingguide.ai/kr)

<br>
---
<br>

# 