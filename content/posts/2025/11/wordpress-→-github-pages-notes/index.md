---
title: "WordPress → GitHub Pages Notes"
date: 2025-11-19
categories: 
  - "writing"
tags: 
  - "ai"
  - "blog"
  - "digital-marketing"
  - "technology"
  - "wordpress"
---

* * *

### **Export**

When you click the export button in wp-admin/tools, WordPress will create an **XML** file for you to save to your computer.

This format, which is called **WordPress eXtended RSS** or **WXR**, will contain your posts, pages, comments, custom fields, categories, and tags.

Once you’ve saved the download file, you can use the Import function in another WordPress installation to import the content from this site.

If you’re going to be using a **WordPress**\-powered site, download the **wp-content** directory and the **wp-config.php** file.

### **github.io**

**WordPress → GitHub Pages**

##### 1\. **Export WordPress Content**

- Go to your WordPress dashboard → _Tools_ → _Export_.

- Choose **“All Content”** to generate an XML file containing posts, pages, comments, custom fields, categories, and tags.

- Download the `.xml` file — this is your raw archive.

##### 2\. **Convert to Static Site Format**

- GitHub Pages works best with **Jekyll** (native support), but you can also use **Hugo** or other static site generators.

- Use a converter tool (e.g., WordPress to Jekyll Exporter plugin) to transform your XML into Markdown files + assets.

- Result: a folder structure like:Code`_posts/ _layouts/ _includes/ assets/ index.md`

##### 3\. **Create GitHub Repository**

- On GitHub, create a new repo named:Code`<your-username>.github.io`

- Example: `EyeOfParadox.github.io`

- This naming convention is required for GitHub Pages to serve your site automatically.

##### 4\. **Push Static Site Files**

- Initialize Git locally:bash`git init git remote add origin https://github.com/<username>/<username>.github.io.git git add . git commit -m "Initial blog migration" git push -u origin main`

- Your converted blog files are now version-controlled and stored in GitHub.

##### 5\. **Enable GitHub Pages**

- Go to your repo → _Settings_ → _Pages_.

- Under **Source**, select branch `main` (or `gh-pages` if you prefer a separate branch).

- Save. GitHub will build and serve your site at: Code`https://<username>.github.io`

##### 6\. **Style & Extend**

- Customize `_config.yml` for site metadata (title, description, theme).

- Add a theme (e.g., Minimal Mistakes) for polished presentation.

- Modularize posts: each Markdown file becomes a referenceable node in your conceptual architecture.

- Cross-link essays using relative paths.

### Notes

Publishing via `github.io` transforms your essays into **public articles**, accessible for interdisciplinary audiences and legacy transmission.

The **export file** facilitates the transfer from WordPress’s walled garden into an open-source library.

Each **Markdown post** becomes referenceable and linkable for future synthesis.

The **GitHub repo** itself is a living archive, providing version control, collaboration support, and so much more.
