---
layout: archive
permalink: categories/2025-project01
title: "2025-project01"

author_profile: true
sidebar:
  nav: "sidebar-category"
---

<div class="grid__wrapper">
{% assign posts = site.categories['2025-project01'] %}
{% for post in posts %}
{% include archive-single3.html type="list" %}
{% endfor %}
</div>