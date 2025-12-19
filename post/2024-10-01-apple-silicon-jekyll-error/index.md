+++
date = '2024-10-01'
draft = false
title = 'Apple Silicon에서의 Jekyll 오류 발생 해결'
categories = [
    'Development', 'Research'
]
tags = [
    'jekyll', 'macos', 'apple silicon'
]
image = 'teaser.webp'
+++
## Chat GPT   



<sub>*프롬프트*</sub>
><sub>macOS 터미널을 이용해서 jekyll bundle을 설치하고 있는데 eventmachine 1.2.7 설치 도중 오류가 난대. 왜 이럴까?</sub>   
<sub>-2024.09.30</sub>
   
**1. Xcode Command Line Tools 재설치**
이미 명령줄 도구를 설치했더라도 일부 구성 요소가 손상되었을 수 있으니, 다시 설치하거나 업데이트를 시도해 보세요. 
```bash
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

**2. g++와 clang 설치 확인 및 설정**
macOS에서는 기본적으로 clang을 C++ 컴파일러로 사용합니다. 그러나 환경에 따라 g++ 컴파일러를 사용하는 것이 필요할 수도 있습니다.

• 먼저, clang이나 g++이 설치되어 있는지 확인하세요
```bash
clang --version
g++ --version
```

• clang이 기본 컴파일러로 설정되어 있는지 확인하기 위해 다음 명령어를 입력해 보세요:
```bash
brew install gcc
```


<!-- ```bash
eval $(/opt/homebrew/bin/brew shellenv)
``` -->
   
<br>
---
<br>

## 웹 서칭   

**해결과정**   
터미널 내 zsh 환경변수가 꼬여 모든 명령(brew, gem, bundle, clear 등)이 작동하지 않아 환경변수 초기화 후 재시도
   

   명령이 작동하지 않는 문제는 해결 됐지만 번들링 도중 지속적으로 `an error occurred while installing eventmachine (1.2.7), and bundler cannot continue.` 오류가 발생하여 `eventmachine` 설치가 되지 않아 프로세스가 중지 되었다.

인터넷 서칭 결과 완벽한 해결책은 아니지만 `Gemfile`을 다음과 같이 수정하여 번들링을 성공했다.

<sub>*Gemfile*</sub>
```ruby
gem 'eventmachine', '1.2.5'
```
기본적으로 `eventmachine(1.2.7)` 설치 도중 오류가 발생한 것이며 1.2.5로 버전을 한 단계 낮춰 설치하도록 코드를 수정하여 문제를 해결했다.   
완벽한 해결책은 아니지만 작동에는 문제가 없어 보이며 추후 Apple Silicon Mac에서 1.2.7버전 설치를 시도해볼 것이다.