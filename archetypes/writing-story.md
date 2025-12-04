---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
menu:
  main:
    parent: "Writing"
    identifier: "{{ .Name }}"
    weight: 1
    params:
      icon: '<i class="fas fa-fw fa-book-open"></i>'
      description: "Story overview and chapters."
cascade:
  series: "{{ replace .Name "-" " " | title }}"
  menu:
    main:
      parent: "{{ replace .Name "-" " " | title }}"
---
## {{ replace .Name "-" " " | title }}

_Introductory text for the story goes here. Summarize the premise, themes, or publication notes._

### Chapters
- [Chapter 1](chapter-1/index.md)
- [Chapter 2](chapter-2/index.md)
- [Chapter 3](chapter-3/index.md)

---
