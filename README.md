README.md

---

**abstract**  
This README explains to future readers how and why the archive is structured the way it is, and how to keep `public\` clean when rebuildind it. 

---

# eyeofparadox.wordpress.com -> github.com/eyeofparadox/echo.wordpress.blog

I’ve been scratching out ideas since the writing bug first bit me in grade school. Somewhere in the back of my mind I always had this notion that I was going to devote some part of my life to writing. Of course, I’ve spent much more time thinking, while trying to find time to get anything written! 

Inevitably, when the time came to start writing, I had thoughts waiting to be expressed. I used to just spill them out in a notepad and file them away. Sometime in 2007 tripped over a link to Helium (long gone now) and started responding to writing prompts.After publishing my tenth article, I got an itch for something more. I wanted to be able to continue to explore the ideas that bit me, and that really called for something more like a blog.

I started by reposting my Helium articles. I added posts as the impulse to write kicked in, very randomly; sometimes going years between posts. Mostly, my blog was a place I could capture my thoughts. I was not going to try to support myself doing it. I didn't have a particular audience in mind, and the writing served no greater purpose than external memory.

The fact that it was open to the public did not escape me, but I'm the kind of person who feels, if an idea is worth putting down in writing, then it might be worth reading for some people. Most of the time, that works just fine. 

I carried that philosophy to other sites I created, including Git-Hub. Originally, I used GitHub for more technical things, but the benefits for managing my writing archives were clear. I woul also be able to take advantage of Copilot to help with indezing and cross-referencing decades worth of material more efficiently.

---

## Re: Blog-Publishing License

For blogs, the most appropriate license is usually **Creative Commons Attribution-ShareAlike 4.0 (CC BY-SA 4.0)**. It allows others to share and adapt your work, as long as they credit you and license derivatives under the same terms. 


Perfect — here’s a **README.md section** you can drop into your repo. It explains your Hugo config choices (theme, markup settings, syntax highlighting) and also documents the workflow for clean rebuilds, including when to purge `public\`.  

---

## Features



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
```

---

**Next:** a **`.gitignore` tuned for Hugo projects** (ignoring `public\`, cache, and OS cruft) so the repo stays clean.