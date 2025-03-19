---
layout: archive
permalink: categories/design
title: "디자인"

author_profile: true
sidebar:
  nav: "sidebar-category"
---

<div class="grid__wrapper">
{% assign posts = site.categories.Design %}
{% for post in posts %}
{% include archive-single3.html type="list" %}
{% endfor %}
</div>
{% include paginator.html %} 