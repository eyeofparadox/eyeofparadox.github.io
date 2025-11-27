

## Install \<hugo-theme-name\> Theme in Your Hugo Site
1. **Navigate to your Hugo site folder**
    - In terminal, goto target repo: cd G:\Lab\.github\eyeofparadox.github.io
	``` powershell
	cd G:\Lab\.github\eyeofparadox.github.io
	```
2. **Add the theme as a Git submodule**
	``` powershell
	git submodule add https://github.com/<repo-name>/<hugo-theme-name> themes/<hugo-theme-name>
	```
3. **Update your `hugo.toml` (or `config.toml`)**:
    - (still in): `G:\Lab\.github\eyeofparadox.github.io\hugo.toml`
    - Add the following line:
	``` toml
	theme = "<hugo-theme-name>"
	```
4. **Test locally** 
    - (still in): `G:\Lab\.github\eyeofparadox.github.io`

	``` powershell
	hugo server -D
	```
    **error message**:
    > 
    >   > `fatal: not a git repository (or any of the parent directories): .git`
    > 
    > That means your Hugo site folder (G:\Lab\.github\eyeofparadox.github.io) hasn’t been initialized as a Git repository yet.
    > 
    > You can’t add submodules (like the theme) until the repo exists. **[Fix](#initialize-git-in-your-hugo-site)** 
5. **Visit http://localhost:1313** to **preview** the **themed** site
    - While active, changes to site content should update automatically

---

## Goto and Configure:
### G:\Lab\\.github\eyeofparadox.github.io\content\\_index.md
Hugo’s homepage is controlled by either:
- `content/_index.md` → if present, Hugo uses this as the homepage content.  
- `layouts/index.html` → if no `_index.md` exists, Hugo falls back to the theme’s template.
Create a minimal `content/_index.md` with the content you want for your landing page: This is a simple method used to draft a **starter homepage layout** that presents your latest posts automatically, so you don’t have to hand‑curate the landing page. For more info, check the Hugo documentation about YAML frontmatter in content Markdown.
> #### Quick path:
> 1. Create `content/_index.md`:
>    ```markdown
>    ---
>    title: "Welcome to Eye of Paradox"
>    description: "..."
>    ---
>    
>    ... [This is the landing page introduction. Add links, summaries, or featured posts here.]
>    ```
> 2. Commit and push to `main`.  
> 3. Workflow rebuilds → `gh-pages` → GitHub Pages serves your new homepage.
>     - This replaces the “dummy” template with your own text.

---

### G:\Lab\\.github\eyeofparadox.github.io\themes\\<hugo-theme-name\>\layouts\partials\head.html
#### Fixing Favicons
Hugo copies everything from `static/` directly into the site root. So:

1. Place your favicon files in `static/`:
   ```
   static/favicon.ico
   static/favicon-16x16.png
   static/favicon-32x32.png
   static/apple-touch-icon.png
   static/android-chrome-192x192.png
   static/android-chrome-512x512.png
   static/site.webmanifest
   ```
2. Edit your theme’s `layouts/partials/head.html` (or equivalent) to include:
   ```html
   <link rel="icon" href="/favicon.ico">
   <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
   <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
   <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
   <link rel="manifest" href="/site.webmanifest">
   ```
3. Commit and push → workflow rebuilds → favicons appear at the root of your site.

---

### G:\Lab\\.github\eyeofparadox.github.io\hugo.toml
#### Verify for Relative Link Structure
``` toml
baseURL = "https://eyeofparadox.github.io/"
# - This ensures all links are relative to your GitHub Pages domain.  
# - Without this, Hugo may generate links pointing to `/` or localhost.

title = "eyeofparadox.github.io"
theme = "<hugo-theme-name>"
# - replace <hugo-theme-name> with chosen theme repo name

languageCode = "en-us"
defaultContentLanguage = "en"
enableInlineShortcodes = true
# prevent build failures when using Hugo's Instagram shortcode due to deprecated Instagram API.
# See https://github.com/gohugoio/hugo/issues/7228#issuecomment-714490456
ignoreErrors = ["error-remote-getjson"]
enableGitInfo = true

# Optional: enable syntax highlighting
pygmentsUseClasses = true
pygmentsCodeFences = true

# Taxonomies
[taxonomies]
  category = "categories"
  tag = "tags"
  series = "series"

[privacy]
  [privacy.vimeo]
    disabled = false
    simple = true

  [privacy.x]
    disabled = false
    enableDNT = true
    simple = true

  [privacy.instagram]
    disabled = false
    simple = true

  [privacy.youtube]
    disabled = false
    privacyEnhanced = true

# Params specific to <hugo-theme-name>
[params]
  author = "David Bryan Roberson"
  url = "https://github.com/eyeofparadox"
  subtitle = "in the ashes of ideas hides the spark of understanding"
  keywords = "blog, echo, wordpress, posts, pages, essays, articles, fiction"
  contentTypeName = "posts"
  github = "eyeofparadox"	# icons/url's will come later
  wordpress = "eyeofparadox"
  github = "eyeofparadox"
  twitter = "EyeOfParadox"

  [params.header]
    logo = "logo.png"
    title = "eyeofparadox"

  [params.footer]
    since = 2007
    poweredby = true

[menu]

  [[menu.main]]
    identifier = "posts"
    name = "Posts"
    pageRef = "/posts"
    weight = 100

  [[menu.main]]
    identifier = "pages"
    name = "Pages"
    pageRef = "/pages"
    weight = 150

  [[menu.main]]
    identifier = "about"
    name = "About"
    pageRef = "/about"
    weight = 1

# Markup configuration
[markup]
  _merge = "deep"
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true

  [markup.highlight]
    codeFences = true
    guessSyntax = true
    lineNos = true

# Optional: suppress warnings if you prefer a clean build log
ignoreLogs = ['warning-goldmark-raw-html']
```

---

## 📂 Key Folders in Your Hugo Repo
- **`hugo.toml`** in **(root)** → Your site config (title, theme, taxonomies, params). This is the “style glyph” that tells Hugo how to render.  
- **`LICENSE`, `README.md`, `.gitignore`** in **(root)** → Conventional GitHub repo files, coexisting cleanly with Hugo.  
### Hugo Scaffold
- **`archetypes/`** → Templates for new content. When you run `hugo new posts/foo.md`, Hugo uses `archetypes/default.md` to prefill front matter.  
- **`content/`** → Your actual blog posts and pages in Markdown. Right now you’ve got `content/posts/alpha.md`.  
- **`layouts/`** → Custom site layouts. You can override theme defaults here if you want to tweak rendering.  
- **`static/`** → Raw assets (images, CSS, JS) that Hugo copies directly into the final site.  
- **`assets/`** → Processed assets (SCSS, pipelines). Hugo transforms these before output.  
- **`data/`** → Optional structured data (YAML/JSON/TOML) for dynamic content.  
- **`i18n/`** → Internationalization strings if you want multilingual support.
### Build Output
- **`gh-pages/`** for GitHub Actions deployment, **`main/docs/`** for branch deployment, or **`public/`** from local `hugo -D` build → The generated static site (HTML, CSS, JS). This is what you deploy to GitHub Pages.  
  - `posts/alpha/` → Your first shard rendered.  
  - `categories/`, `tags/` → Auto‑generated taxonomy pages.  
  - `css/`, `js/`, `images/` → Theme assets compiled for the site.
### Theme
- **`themes/<hugo-theme-name>/`** → The GitHub‑Style theme you pulled in as a submodule.  
  - `layouts/partials/` → Header, footer, reusable fragments.  
  - `layouts/_default/` → Default templates for posts, pages, lists.  
  - `static/css`, `static/js`, `static/images` → Theme’s bundled assets.  
  - `archetypes/` → Theme‑specific archetypes (can override defaults).  

---

Your forked theme (`eyeofparadox/<hugo-theme-name>`) is now its own repo, with your commit history diverging from the upstream (`<repo-name>/<hugo-theme-name>`). That means Hugo can now pull layouts, assets, and partials directly from your fork.
### Here’s how to make sure your site is actually using **your fork** and not the upstream:

---

#### How Hugo Resolves the Theme
- Hugo looks at the `theme` line in your `hugo.toml`:
  ```toml
  theme = "<hugo-theme-name>"
  ```
- It then loads the theme from the folder `themes/<hugo-theme-name>` in your repo.
- Since you cloned your fork into that folder, Hugo is now using **your forked version**.

---

#### Best Practices for Forked Themes
1. **Keep the submodule reference clean**  
   - Your `.gitmodules` file now points to `https://github.com/eyeofparadox/<hugo-theme-name>`.  
   - That ensures anyone cloning your site repo will also pull your fork.

2. **Customizations live in your fork**  
   - Any edits you make inside `themes/<hugo-theme-name>/layouts/` (like your updated `head.html`) are now tracked in your fork.  
   - If you want to override templates without touching the fork, you can also copy them into your site’s own `layouts/` folder — Hugo will prefer local overrides.

3. **Syncing with upstream**  
   - If you want to pull in changes from `<repo-name>/<hugo-theme-name>` later, you can add it as an upstream remote in your fork and merge selectively:
     ```bash
     cd themes/<hugo-theme-name>
     git remote add upstream https://github.com/<repo-name>/<hugo-theme-name>
     git fetch upstream
     git merge upstream/main
     ```
   - That way you keep your fork ahead but still benefit from upstream fixes.

---

## Uninstall \<hugo-theme-name\> Theme in Your Hugo Site


---

## Initialize Git in Your Hugo Site

1. **Navigate to your site folder**  
   ```powershell
   cd G:\Lab\.github\eyeofparadox.github.io
   ```

2. **Initialize Git**  
   ```powershell
   git init
   ```

   This creates the hidden `.git` directory and makes the folder a proper repository.

3. **Add the GitHub remote (your Pages repo)**  
   ```powershell
   git remote add origin https://github.com/eyeofparadox/eyeofparadox.github.io.git
   ```

   *(Replace with your actual GitHub username if different.)*

4. **Now add the theme as a submodule**  
   ```powershell
   git submodule add https://github.com/MeiK2333/<hugo-theme-name> themes/<hugo-theme-name>
   ```

   This will pull the theme into `themes/<hugo-theme-name>`.

5. **Commit the setup**  
   ```powershell
   git add .
   git commit -m "Initialize Hugo site with <hugo-theme-name> theme"
   ```

---

### Why This Matters
- Git needs to know your site folder is a repo before it can track submodules.  
- Once initialized, you can push commits to GitHub and GitHub Pages will serve your site.  
- The theme will stay linked as a submodule, so you can update it later with:  
  ```powershell
  git submodule update --remote --merge
  ```

