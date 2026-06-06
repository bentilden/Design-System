---
title: Contributing
type: guideline
status: draft
source_of_truth: documentation
audience:
  - design
  - development
owner: Ben Tilden
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: active
---

# Contributing

This design system should stay close to the live website.

## Update Workflow

1. Make or inspect the website change in `bentilden.com` or `bentilden.com-css`.
2. Identify whether the change is a foundation, component, or pattern.
3. Update the matching Markdown page.
4. Add a source reference when a documented rule maps to a specific file.
5. Run `mkdocs build --strict`.
6. Commit the docs change.

## Documentation Standards

- Document current behavior first.
- Mark future ideas as proposals.
- Use code snippets from source files when they clarify implementation.
- Prefer short guidance over long prose.
- Keep examples accessible and responsive.

## Publishing Checklist

- GitHub Pages source is set to GitHub Actions.
- Pull requests can use the CI workflow to run `mkdocs build --strict` before merge.
- `mkdocs build --strict` passes.
- The workflow runs successfully on `main`.
- The deployed URL resolves at `https://bentilden.github.io/Design-System/`.
