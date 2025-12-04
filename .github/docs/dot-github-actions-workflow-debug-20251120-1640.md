dot-github-actions-workflow-debug-20251120-1640.md

```
Add documentation and workflow for Hugo site deployment #2 
Jobs Run details 
Triggered via push 1 minute ago 
@eyeofparadox
eyeofparadox 
pushed 5afb293 
main 

Status 
Failure 
Total duration 21s 

Artifacts – 

Annotations 
1 error 
build-deploy 
Action failed with "The process '/usr/bin/git' failed with exit code 128"
```
That error message — The process '/usr/bin/git' failed with exit code 128 — is coming from the deploy step of your workflow. It means the action tried to run a Git command (to push the built site into gh-pages) but failed. Let’s break down the likely causes and fixes:

# Common Causes of Exit Code 128 in peaceiris/actions-gh-pages
1. Branch doesn’t exist yet
- If gh-pages hasn’t been created, the action may fail when trying to push.
- **Fix**: add `publish_branch: gh-pages` and `force_orphan: true` so it can create a clean branch automatically.

2. No commit history / detached HEAD
- The action checks out your repo in a detached state. If it tries to commit without `force_orphan`, Git can complain.
- **Fix**: `force_orphan: true` ensures it starts fresh each deploy.

3. Missing user identity

- Git requires a `username/email` to make commits. Normally `peaceiris/actions-gh-pages` sets these automatically, but if misconfigured, you’ll see `exit 128`.

## Checked and corrected **Settings** > **Pages** > **Build and deployment**

**Was**: GitHub Actions

**To**: Deploy from branch

['gh-pages'], [`/ (root)`] 

**Ran**: Build and Deploy Hugo site  
Filter workflow runs

``` hugo.yml
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
```

### 2 workflow runs
This workflow has a `workflow_dispatch` event trigger.

## Build and Deploy Hugo site #3: Manually run by eyeofparadox  
- main	
- 9 minutes ago
- 17s

## Details

### Build and Deploy Hugo site
- Add documentation and workflow for Hugo site deployment #2

Jobs
---
Run details
- Triggered via push 17 minutes ago
- @eyeofparadoxeyeofparadox
- pushed 5afb293
- main
- Status
- Failure
- Total duration
- 21s

Artifacts
–--
- ...

Annotations  
---
- 1 error
- build-deploy
- Action failed with "The process '/usr/bin/git' failed with exit code 128"

### [build-deploy]
- failed 18 minutes ago in 17s
- Search logs
- 3s

```
Setup job
---
Current runner version: '2.329.0'
Runner Image Provisioner
Operating System
Runner Image
GITHUB_TOKEN Permissions
Secret source: Actions
Prepare workflow directory
Prepare all required actions
Getting action download info
Download action repository 'actions/checkout@v4' (SHA:34e114876b0b11c390a56381ad16ebd13914f8d5)
Download action repository 'peaceiris/actions-hugo@v2' (SHA:16361eb4acea8698b220b76c0d4e84e1fd22c61d)
Download action repository 'peaceiris/actions-gh-pages@v3' (SHA:373f7f263a76c20808c831209c920827a82a2847)
Complete job name: build-deploy
7s

Checkout repository
---
Run actions/checkout@v4
Syncing repository: eyeofparadox/eyeofparadox.github.io
Getting Git version info
Temporarily overriding HOME='/home/runner/work/_temp/316d9c18-6b68-42c9-a212-e1f04a4dd6cc' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/eyeofparadox.github.io/eyeofparadox.github.io
Deleting the contents of '/home/runner/work/eyeofparadox.github.io/eyeofparadox.github.io'
Initializing the repository
Disabling automatic garbage collection
Setting up auth
Fetching the repository
Determining the checkout info
/usr/bin/git sparse-checkout disable
/usr/bin/git config --local --unset-all extensions.worktreeConfig
Checking out the ref
Setting up auth for fetching submodules
Fetching submodules
Persisting credentials for submodules
/usr/bin/git log -1 --format=%H
5afb293fde2dc58676735f24e109653b87864a0f
1s

Setup Hugo
---
Run peaceiris/actions-hugo@v2
Hugo version: 0.152.2
/usr/bin/tar xz --warning=no-unknown-keyword --overwrite -C /home/runner/actions_hugo/_temp -f /home/runner/work/_temp/3904d891-3801-4dce-b6ec-0c2547b43db6
/home/runner/actions_hugo/bin/hugo version
hugo v0.152.2-6abdacad3f3fe944ea42177844469139e81feda6 linux/amd64 BuildDate=2025-10-24T15:31:49Z VendorInfo=gohugoio
1s

Build
---
Run hugo --minify
Start building sites … 
hugo v0.152.2-6abdacad3f3fe944ea42177844469139e81feda6 linux/amd64 BuildDate=2025-10-24T15:31:49Z VendorInfo=gohugoio


                  │ EN  
──────────────────┼─────
 Pages            │ 439 
 Paginator pages  │  42 
 Non-page files   │ 151 
 Static files     │ 864 
 Processed images │   0 
 Aliases          │ 170 
 Cleaned          │   0 

Total in 1163 ms
3s

Deploy
---
Run peaceiris/actions-gh-pages@v3
[INFO] Usage https://github.com/peaceiris/actions-gh-pages#readme
Dump inputs
Setup auth token
Prepare publishing assets
Setup Git config
Create a commit
Push the commit or tag
  /usr/bin/git push origin --force gh-pages
  remote: Permission to eyeofparadox/eyeofparadox.github.io.git denied to github-actions[bot].
  fatal: unable to access 'https://github.com/eyeofparadox/eyeofparadox.github.io.git/': The requested URL returned error: 403
  Error: Action failed with "The process '/usr/bin/git' failed with exit code 128"
0s

Post Checkout repository
---
Post job cleanup.
/usr/bin/git version
git version 2.51.2
Temporarily overriding HOME='/home/runner/work/_temp/76212373-a3a7-4423-956d-baaebb92ddf1' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/eyeofparadox.github.io/eyeofparadox.github.io
/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
Entering 'themes/github-style'
/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
http.https://github.com/.extraheader
/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
Entering 'themes/github-style'
http.https://github.com/.extraheader
/usr/bin/git config --local --name-only --get-regexp ^includeIf\.gitdir:
/usr/bin/git submodule foreach --recursive git config --local --show-origin --name-only --get-regexp remote.origin.url
Entering 'themes/github-style'
file:/home/runner/work/eyeofparadox.github.io/eyeofparadox.github.io/.git/modules/themes/github-style/config	remote.origin.url
/usr/bin/git config --file /home/runner/work/eyeofparadox.github.io/eyeofparadox.github.io/.git/modules/themes/github-style/config --name-only --get-regexp ^includeIf\.gitdir:
0s

Complete job
---
Cleaning up orphan processes
```

**Got it — the logs tell the whole story now**. The Hugo build itself succeeded (439 pages generated in ~1s), but the **deploy step failed with a 403 permission error**:

```
remote: Permission to eyeofparadox/eyeofparadox.github.io.git denied to github-actions[bot].
fatal: unable to access 'https://github.com/eyeofparadox/eyeofparadox.github.io.git/': The requested URL returned error: 403
```

---

## What That Means
- The workflow is trying to push the built site into the `gh-pages` branch.  
- It’s authenticating with the default `GITHUB_TOKEN`.  
- But the token doesn’t have **write access** to your repo (only read).  
- That’s why you see `denied to github-actions[bot]`.

---

## How to Fix

### 1. Check `GITHUB_TOKEN` permissions
- Go to your repo: **Settings → Actions → General**.  
- Scroll to **Workflow permissions**.  
- Make sure **“Read and write permissions”** is selected.  
- Right now it’s likely set to “Read repository contents permission” only.  
- Save changes.

### 2. Update workflow (optional identity)
Add explicit identity so commits are clean:

```yaml
- name: Deploy to GitHub Pages
  uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./public
    publish_branch: gh-pages
    force_orphan: true
    user_name: github-actions[bot]
    user_email: 41898282+github-actions[bot]@users.noreply.github.com
```

### 3. Trigger again
- Push to `main` or run manually.  
- This time, the deploy step should succeed and populate `gh-pages` with your built HTML.

---

## Codex Resonance Note
Right now, the messenger glyph (`github-actions[bot]`) is knocking at the archive door but doesn’t have the key. Granting “read and write” permissions gives it the authority to inscribe the finished manuscripts into the `gh-pages` branch.

---

**Next step**: flip the **Workflow permissions** setting to “Read and write” in repo settings, then rerun the workflow. 