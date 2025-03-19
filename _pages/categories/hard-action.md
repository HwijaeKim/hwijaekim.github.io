---
layout: archive
permalink: categories/hard-action
title: "뻘짓"

author_profile: true
sidebar:
  nav: "sidebar-category"
---

<div class="grid__wrapper">
{% assign posts = site.categories.hard-action %}
{% for post in posts %}
{% include archive-single3.html type="list" %}
{% endfor %}
</div>