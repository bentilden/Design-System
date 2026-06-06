# Ben Tilden Design System

Markdown-first design system documentation for bentilden.com.

This repo uses [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) and publishes to GitHub Pages from the `main` branch.

## Local development

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
mkdocs serve
```

The local site will be available at `http://127.0.0.1:8000`.

## Build

```bash
mkdocs build --strict
```

## Publish

Push to `main`. The GitHub Actions workflow in `.github/workflows/deploy.yml` builds the site and deploys it to GitHub Pages.

In GitHub, set **Settings -> Pages -> Build and deployment -> Source** to **GitHub Actions**.
