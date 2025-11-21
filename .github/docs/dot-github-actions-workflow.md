github-actions-workflow.md

# GitHub Actions Workflow** 

A bit of automation added to handle GitHub Pages updates in the repo. (See annotatations for the triggers identifying when they trip and what each does.)

---

## `.github/workflows/hugo.yml`

```yaml
name: Build and Deploy Hugo site

on:
  # Trigger 1: Push to main branch
  push:
    branches:
      - main

  # Trigger 2: Manual run from GitHub UI
  workflow_dispatch:

jobs:
  build-deploy:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout repo
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          submodules: true   # ensures theme submodule is pulled

      # Step 2: Setup Hugo
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: 'latest'

      # Step 3: Build site
      - name: Build
        run: hugo --minify

      # Step 4: Deploy to GitHub Pages
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
          publish_branch: gh-pages   # <— add this line
```

---

## Trigger Documentation

- **Trigger 1: `push` to `main`**  
  - **When it trips**: Every time you commit and push changes to the `main` branch.  
  - **What it does**: Automatically rebuilds your Hugo site and redeploys it to GitHub Pages.  
  - **Use case**: Normal workflow — edit content/config locally, push to `main`, site updates live.

- **Trigger 2: `workflow_dispatch`**  
  - **When it trips**: Manually triggered from the GitHub Actions tab in your repo.  
  - **What it does**: Runs the same build/deploy pipeline on demand, even without new commits.  
  - **Use case**: Useful if you want to force a rebuild (e.g., after theme updates, config tweaks, or purging `public\`).

---

## What Each Step Does
- **Checkout repository** → pulls your repo and theme submodule.  
- **Setup Hugo** → installs the latest Hugo binary on the runner.  
- **Build site** → runs `hugo --minify`, generating static HTML into `public/`.  
- **Deploy** → publishes `public/` to the `gh-pages` branch (or directly to Pages if configured), making your site live at `https://eyeofparadox.github.io/`.

---

## Note
This workflow is for **automation**:  
- The **push trigger** — every commit to `main` invokes a rebuild.  
- The **manual trigger** — on-demand use to rebuild even without commits.  

---

With this, there is less need to follow up every commit to `public\` by hand. GitHub Actions will build and deploy automatically. 

**Recommended Option**: **Switch Pages to use the `gh-pages` branch** (instead of `main/public`). It could make this workflow operate more cleanly?