safe-github-desktop-workflow-pattern.md

---

# `main`, `gh-pages` and workflows


> We sort of touched on the idea that `gh-pages` does not need to be a mirror of `main`. Or at least, you made a comment implying so. I wanted to clear that up and find out, if that is true, how does that impact things in Github Desktop as far as pull, push and merge operations, in terms of potentially destructive interference that can occur as a result.

Great question — let’s clear this up carefully, because it’s one of the most common points of confusion when people start using GitHub Pages with a `gh-pages` branch.

---

## Is `gh-pages` a mirror of `main`?
- **No, it doesn’t need to be.**  
  - `main` holds your Hugo source: `content/`, `themes/`, configs, etc.  
  - `gh-pages` holds only the *built output*: HTML, CSS, JS, images from `public/`.  
- They serve different purposes:
  - `main` = your working codex.  
  - `gh-pages` = the published vessel.  

So `gh-pages` is not a mirror of `main` — it’s more like a *deployment artifact branch*.

---

## How GitHub Desktop Sees This
GitHub Desktop treats `gh-pages` like any other branch:
- You can **check out** `gh-pages` locally, but you usually don’t need to.  
- You can **push/pull** it, but if you’re using Actions to deploy, you should avoid editing it manually.  
- **Merges between `main` and `gh-pages` are not needed** — they serve different roles. Trying to merge them would mix source and build artifacts, which is destructive.

---

## Avoiding Destructive Interference
Here’s what to watch out for:
- **Don’t merge `gh-pages` into `main`** → you’d pollute your source repo with build artifacts.  
- **Don’t merge `main` into `gh-pages` manually** → you’d overwrite the published site with raw source files.  
- **Don’t commit directly to `gh-pages`** if you’re using Actions → the workflow will overwrite it anyway.  

Instead:
- Treat `gh-pages` as a **write‑only branch** managed by your workflow.  
- Treat `main` as your **development branch** where you commit content and config.  

---

## Codex Resonance Note
Think of `main` as the **scriptorium** where you write and annotate.  
Think of `gh-pages` as the **public archive** where only finished manuscripts are displayed.  
They are related, but not mirrors — one is living source, the other is static transmission.

---

## Practical Impact in GitHub Desktop
- You’ll mostly work in `main`.  
- You’ll rarely (if ever) check out `gh-pages`.  
- Pull/push operations in Desktop should be done on `main`.  
- `gh-pages` updates automatically via Actions — you don’t need to touch it.  

---

Would you like me to sketch a **safe workflow pattern in GitHub Desktop** (step‑by‑step) so you know exactly which branch to work in, when to push, and how to avoid ever clobbering `gh-pages`?

> Please do, and include purge-cleanup for `gh-pages` to remove mirrored redundancies from my earlier setup with desktop.

Perfect — let’s lay out a **safe workflow pattern in GitHub Desktop** for working with your Hugo site, and include a **purge‑cleanup ritual** for `gh-pages` so you don’t carry over the mirrored redundancies from your earlier manual pushes.

---

## Safe Workflow Pattern in GitHub Desktop

### 1. Work only in `main`
- Always check out the `main` branch in GitHub Desktop.  
- Add/edit your Hugo content (`content/`, `layouts/`, `themes/`, etc.).  
- Commit and push changes to `main`.  
- This is your **source branch** — the living codex.

### 2. Let Actions handle `gh-pages`
- Don’t check out `gh-pages` in Desktop unless you’re inspecting.  
- Don’t merge `main` into `gh-pages` or vice versa.  
- Don’t commit directly to `gh-pages`.  
- Treat `gh-pages` as a **write‑only branch** managed by your workflow.  

### 3. Pages settings
- In **Repo Settings → Pages**, set source = `gh-pages` branch, root `/`.  
- GitHub Pages will serve whatever the workflow publishes there.  

---

## Purge‑Cleanup for `gh-pages`

Since you manually pushed source files into `gh-pages` earlier, you’ll want to clean that branch so it only contains Hugo’s built output. Here’s how:

### Option A: Clean slate (recommended)
1. In GitHub Desktop, switch to `gh-pages`.  
2. Delete all files/folders in the working directory (yes, wipe it).  
3. Commit the deletion and push.  
   - This clears out the mirrored source tree.  
4. Switch back to `main`.  
5. Trigger your workflow (push a small change or run manually).  
6. The workflow will rebuild Hugo and repopulate `gh-pages` with only `public/` contents.

### Option B: Force overwrite via workflow
- Skip manual cleanup.  
- Push a change to `main` so the workflow runs.  
- The deploy step (`peaceiris/actions-gh-pages`) will overwrite `gh-pages` with the contents of `public/`.  
- This effectively purges old files, but sometimes stray artifacts can linger if the workflow isn’t set to force‑clean.  

To guarantee cleanup, add this line to your deploy step:

```yaml
with:
  github_token: ${{ secrets.GITHUB_TOKEN }}
  publish_dir: ./public
  publish_branch: `gh-pages`
  force_orphan: true   # ensures `gh-pages` is wiped before publishing
```

This makes every deploy start from a clean branch, so no mirrored redundancies survive.

---

## Codex Resonance Note
Think of `main` as your **scribe’s desk** — where manuscripts are written.  
Think of `gh-pages` as the **public archive** — only finished scrolls belong there.  
The purge‑cleanup is the ritual burning of draft scraps, ensuring the archive holds only polished transmissions.

---

Next step: add `force_orphan: true` to your workflow, then either manually wipe `gh-pages` once or let the workflow overwrite it. After that, you’ll never need to touch `gh-pages` in Desktop again — it will stay clean and auto‑updated.  

Would you like me to show you the **exact GitHub Desktop steps for Option A (manual wipe)** so you can do the purge once and then let automation take over?

> Yes. I'll keep it as reference.

Perfect — keeping `eyeofparadox/workflows` as your **reference codex** is a smart move. That way you can archive draft YAMLs, notes, and models without risking interference with the live Hugo site repo.  

Here’s the **safe workflow pattern with purge‑cleanup** you asked for, written step‑by‑step so you can keep it as a reference:

---

## Safe Workflow Pattern in GitHub Desktop

1. **Stay in `main` for all work**  
   - Open your Hugo site repo (`eyeofparadox.github.io`) in GitHub Desktop.  
   - Always check out the `main` branch.  
   - Add/edit Hugo content (`content/`, `layouts/`, `themes/`, etc.).  
   - Commit and push changes to `main`.  
   - This is your source branch — the living manuscripts.

2. **Let Actions manage `gh-pages`**  
   - Don’t check out `gh-pages` unless you’re inspecting.  
   - Don’t merge `main` into `gh-pages` or vice versa.  
   - Don’t commit directly to `gh-pages`.  
   - Treat `gh-pages` as a **write‑only branch** managed by your workflow.

3. **Pages settings**  
   - In **Repo Settings → Pages**, set source = `gh-pages` branch, root `/`.  
   - Pages will serve whatever the workflow publishes there.

---

## Purge‑Cleanup Ritual for `gh-pages`

Since you manually pushed source files earlier, here’s how to clean it once and for all:

### Manual Wipe (Option A)
1. In GitHub Desktop, switch to the `gh-pages` branch.  
2. Select all files/folders in the working directory and delete them.  
3. Commit the deletion and push.  
   - This clears out the mirrored source tree.  
4. Switch back to `main`.  
5. Push a small change (or run the workflow manually).  
6. The workflow will rebuild Hugo and repopulate `gh-pages` with only `public/` contents.

### Automated Wipe (Option B)
- Add this to your deploy step in `hugo.yml`:

```yaml
with:
  github_token: ${{ secrets.GITHUB_TOKEN }}
  publish_dir: ./public
  publish_branch: `gh-pages`
  force_orphan: true   # ensures `gh-pages` is wiped before publishing
```

- This makes every deploy start from a clean branch, so no mirrored redundancies survive.

---

## Codex Resonance Note
Think of `main` as your **scribe’s desk** — where manuscripts are written.  
Think of `gh-pages` as the **public archive** — only finished scrolls belong there.  
The purge‑cleanup is the ritual burning of draft scraps, ensuring the archive holds only polished transmissions.

---

Once you do the purge (manual or automated), you’ll never need to touch `gh-pages` in Desktop again. It will stay clean and auto‑updated.  

Would you like me to sketch a **visual map of branch flow** (main → workflow → `gh-pages` → Pages) so you can keep it alongside your reference notes?

> Sort of like side-byside trees?

Exactly — a side‑by‑side tree view is a great way to visualize how `main` and `gh-pages` should diverge. Here’s a simplified sketch you can keep in your reference repo:

---

## Branch Flow: `main` vs `gh-pages`

### `main` (source codex)
```
eyeofparadox.github.io/
├── archetypes/
├── content/
│   ├── posts/
│   └── pages/
├── layouts/
├── static/
├── themes/
├── hugo.toml
└── .github/
    └── workflows/
        └── hugo.yml
```
- Contains Hugo source files, configs, and workflow definitions.  
- This is where you write and commit.  
- GitHub Actions runs from here.

---

### `gh-pages` (published vessel)
```
gh-pages/
├── index.html
├── 404.html
├── css/
├── js/
├── images/
├── posts/
├── categories/
├── tags/
└── sitemap.xml
```
- Contains only the **built output** from Hugo (`public/`).  
- No `content/`, `themes/`, or `.github/` here.  
- GitHub Pages serves directly from this branch.

---

## Flow Between Branches
```
(main) ──► [GitHub Actions: hugo build] ──► (gh-pages) ──► [GitHub Pages site]
```

- You work in `main`.  
- Workflow builds Hugo → outputs HTML/CSS/JS into `public/`.  
- Workflow publishes `public/` into `gh-pages`.  
- GitHub Pages serves from `gh-pages`.  

---

## Codex Resonance Note
Think of it as **two trees growing side‑by‑side**:  
- `main` is the **living manuscript tree**, full of drafts, glyphs, and source bark.  
- `gh-pages` is the **polished archive tree**, bearing only finished leaves (HTML).  
The workflow is the **bridge of resonance** that carries fruit from one tree to the other.

---

Once you’ve purged `gh-pages` and let the workflow repopulate it, your side‑by‑side trees will stay clean: one for writing, one for publishing.  


##### 20252110-1626