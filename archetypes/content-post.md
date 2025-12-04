---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
menu:
  main:
    parent: "Content"
    identifier: "{{ .Name }}"
    weight: 1
    params:
      icon: '<i class="fas fa-fw fa-file-alt"></i>'
      description: "Standalone essay or post."
categories: []
tags: []
series: []
---
## {{ replace .Name "-" " " | title }}

_Opening paragraph or abstract goes here. Summarize the purpose, theme, or context of the post._

