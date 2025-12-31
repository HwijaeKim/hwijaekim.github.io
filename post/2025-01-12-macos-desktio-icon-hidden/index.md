+++
date = '2025-01-12'
draft = false
title = 'macOS에서 데스크톱 아이콘 가리기'
categories = [
    '뻘짓'
]
tags = [
    'node.js', 'npm', 'vite', 'react'
]
image = 'teaser.png'
+++

터미널 실행   
```bash
defaults write com.apple.finder CreateDesktop -bool FALSE; killall Finder
```


복귀
```bash
defaults write com.apple.finder CreateDesktop -bool TRUE; killall Finder
```
<br><br>

터미널 없이 손쉽게 가려주는 유틸리티도 있지만 유료