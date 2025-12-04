---
title: "Chapter {{ .Name | title }}"
date: {{ .Date }}
menu:
  main:
    parent: "{{ replace .Section "-" " " | title }}"
    identifier: "{{ .Name }}"
    weight: 1
cascade:
  series: "{{ replace .Section "-" " " | title }}"
---
## Chapter {{ .Name | title }}

_This is the opening scaffold for your chapter. Begin with a synopsis, a scene, or a resonance glyph._

