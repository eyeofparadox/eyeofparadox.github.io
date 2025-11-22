README.md

---
 
This README introduces **eyeofparadox.github.io** and explains how and why the archive is structured the way it is, how to keep `public` clean when rebuilding it, and what licenses are applied. 

---

# eyeofparadox.com -> eyeofparadox.github.io

I’ve been scratching out ideas since the writing bug first bit me in grade school. Somewhere in the back of my mind, I always had this notion that I was going to devote some part of my life to writing. Of course, I’ve spent much more time thinking, while trying to find time to get anything written! 

Inevitably, when the time came to start writing, I had thoughts waiting to be expressed. I used to just spill them out in a notepad and file them away. Sometime in 2007, I tripped over a link to **Helium** (long gone now) and started responding to writing prompts. After publishing my tenth article, I got an itch for something more. I wanted to keep exploring the ideas that bit me, and that really called for something more like a blog.

I started by creating [**eyeofparadox**](https://eyeofparadox.com) on WordPress, reposting my **Helium** articles. I added essays, articles, journals, and bits of work-in-progress fiction as the impulse to write kicked in--however randomly--sometimes going years between posts. Mostly, my blog was a place I could just capture my thoughts before they could escape me. I was not going to try to support myself doing it. I didn't have a particular audience in mind, and the writing served no greater purpose than *external memory* (a [**Ghost in the Shell**](https://github.com/eyeofparadox/eyeofparadox.github.io/masamune-shiro--ghost-in-the-shell--manga-anime.md) reference, for the uniniated).

The fact that it was open to the public did not escape me, but I'm the kind of person who feels, if an idea is worth putting down in writing, then it might be worth reading for some people. Most of the time, that works just fine. 

I carried that philosophy to other sites I created, including GitHub. Originally, I used GitHub for more technical things, but the benefits of using it to manage my writing archives were clear. I would also be able to take advantage of Copilot to help with indexing and cross-referencing decades worth of material more efficiently. I intend to get the static pages up on [eyeofparadox.github.io](https://eyeofparadox.github.io/) as soon as I can get Hugo to build them properly. I might need to make some manual adjustments for that.
	# , so for now the Markdown versions can be found in [**`pages`**](https://github.com/eyeofparadox/eyeofparadox.github.io/tree/main/content/pages/) and [**`posts`**](https://github.com/eyeofparadox/eyeofparadox.github.io/tree/main/content/posts/)
	
---


## Configuration

The site is configured via `hugo.toml` in the repo root. Key settings:

- **Theme**: [`github-style`](https://themes.gohugo.io/themes/github-style/) (pulled in as a Git submodule)
- **Base URL**: `https://eyeofparadox.github.io/`
- **Taxonomies**: `categories` and `tags` enabled
- **Params**: `author`, `description`, `GitHub`, and `Twitter` metadata
- **Markup**:
  - `goldmark.renderer.unsafe = true` → allows raw HTML from imported WordPress posts
  - `highlight` → enables syntax highlighting for fenced code blocks with line numbers
- **ignoreLogs**: optional suppression of raw HTML warnings for cleaner build logs

This configuration ensures WordPress-imported posts render correctly while preserving embedded HTML and providing highlighted code blocks.

---


## Workflow

### Local Preview
Run:
```powershell
hugo server -D
```
This starts a local server at `http://localhost:1313` with drafts included.

### Production Build
Run:
```powershell
hugo -D
```
This generates the static site into the `public\` folder.

### Clean Rebuilds
- Hugo overwrites files in `public\` on each build.  
- **Purging is optional** but recommended before publishing, to avoid stale artifacts from deleted or renamed content.  
- To purge:
  ```powershell
  Remove-Item -Recurse -Force .\public\
  hugo -D
  ```

### Deployment
- Push the contents of `public\` to the `main` branch of `eyeofparadox.github.io`.  
- Enable GitHub Pages in repo settings → the site will be live at:
  ```
  https://eyeofparadox.github.io/
  ```

---


## Licensing

- **Content** (posts, essays, codex shards): Creative Commons Attribution-ShareAlike 4.0 (CC BY-SA 4.0)  
- **Code scaffolding** (Hugo configs, layouts, scripts): MIT License  

See `LICENSE` in the repo root for full details.

---


20251119-1152
