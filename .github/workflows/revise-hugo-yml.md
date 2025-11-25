**I am having issues with the current build action. It seems to be using hugo standard when built on github. If it's possible to force it to use hugo extended, then we need to revise the action script accordingly.**

You’re exactly right — GitHub Actions defaults to the standard Hugo binary unless you explicitly tell it to use the extended build. Since your forked Tailwind theme relies on image processing ($src.Resize), you need Hugo Extended on CI/CD.

Update - minimal workflow revision that ensures the extended binary is used:

``` yaml
name: Build and Deploy Hugo site

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.152.2'
          extended: true   # <<< this forces Hugo Extended

      - name: Build
        run: hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public

```

**There are features in the original build script we'll want to retain.** 

Current:

``` yaml
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
          publish_branch: gh-pages
          force_orphan: true   # ensures gh-pages is wiped before publishing
          user_name: github-actions[bot]
          user_email: 41898282+github-actions[bot]@users.noreply.github.com

```

Got it — you want to merge the extended Hugo fix into your existing workflow while keeping the extra features (manual trigger, submodule checkout, gh‑pages branch handling, orphan reset, bot identity).

Here’s the revised workflow that combines both:

``` yaml
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
      # Step 1: Checkout repo (with submodules)
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          submodules: true   # ensures theme submodule is pulled

      # Step 2: Setup Hugo (force Extended)
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.152.2'   # pin to the version you tested locally
          extended: true            # 👈 ensures Hugo Extended is used

      # Step 3: Build site
      - name: Build
        run: hugo --minify

      # Step 4: Deploy to GitHub Pages
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
          publish_branch: gh-pages
          force_orphan: true   # ensures gh-pages is wiped before publishing
          user_name: github-actions[bot]
          user_email: 41898282+github-actions[bot]@users.noreply.github.com

```
