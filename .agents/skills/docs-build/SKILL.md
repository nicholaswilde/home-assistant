---
name: docs-build
description: Build and serve MkDocs Material documentation locally and lint Markdown files. Trigger: /docs-build, "build docs", "serve docs", "mkdocs", "task build", "task serve".
---

# Documentation Build Skill

Build and preview MkDocs Material documentation in `docs/` using `task` and Docker.

## Protocol

1. **Build static site (`site/`)**:

   ```bash
   task build
   ```

2. **Serve live preview on `http://0.0.0.0:8000`**:

   ```bash
   task serve
   ```

3. **Lint Markdown before committing**:

   ```bash
   rtk rumdl check .
   ```

4. **Commit docs changes**:
   - Stage changed docs explicitly; include `Fixes #<number>` when closing an issue.
