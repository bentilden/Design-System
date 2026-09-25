# Interface Field Guide

Markdown-first design system documentation for bentilden.com, maintained in the `Design System` repository.

This repo uses [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) and publishes to GitHub Pages from the `main` branch.

## Local development

```bash
./bin/serve-design-system
```

The launcher prepares `.venv` if needed and opens the guide at `http://127.0.0.1:8002/`. On macOS, you can also double-click `Open Design System.command`. Stop the server with Control-C. Override the host or port with `DESIGN_SYSTEM_HOST` or `DESIGN_SYSTEM_PORT` when needed.

## Build

```bash
.venv/bin/mkdocs build --strict
```

## Render verification

With Node.js on `PATH`, the sibling `bentilden.com-css` dependencies installed, and Playwright Chromium available, run:

```bash
NODE_PATH=../bentilden.com-css/node_modules node ./bin/verify-render
```

This builds the guide and checks representative desktop/mobile pages for layout and documentation-shell regressions. Use `--no-build` only when the generated `site/` already reflects the current docs. Screenshots default to `/private/tmp/interface-field-guide-render`; set `RENDER_SCREENSHOT_DIR` to choose another location. Temporary screenshots are working outputs; retain evidence separately when recording an audit.

See [Contributing](docs/contributing.md) for source review, metadata, and related-page maintenance. A successful build or render check does not verify the accuracy of implementation claims.

## Publish

Push to `main`. The GitHub Actions workflow in `.github/workflows/deploy.yml` builds the site and deploys it to GitHub Pages.

In GitHub, set **Settings -> Pages -> Build and deployment -> Source** to **GitHub Actions**.
