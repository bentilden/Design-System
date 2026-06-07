---
title: Audit
type: audit
status: draft
source_of_truth: audit finding
audience:
  - design
  - development
  - governance
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: active
---

# Audit

This section captures the deep audit of `bentilden.com` as it is translated into a durable design system.

Audit outputs distinguish:

- what exists in source code,
- what appears in rendered pages,
- what is reusable enough to document,
- what has been fixed since the first snapshot,
- what needs a design decision,
- what needs a rendered accessibility or content QA pass.

## Current Audit Pass

The deep audit reviewed:

| Area | Scope |
| --- | --- |
| Templates | Twig templates under `bentilden.com/templates`, including global layout, entries, matrix blocks, recipe views, SVG icons, feed, contact, and category pages. |
| Craft project config | Sections, entry types, fields, routes, navigation, asset volumes, and image transforms. |
| CSS source | Tailwind 4 entrypoint, type, grid, button, article icon, and site component CSS. |
| Website docs | Asset handling and Craft authoring standards in the website repo. |
| Rendered pages | Representative page/viewport checks across dev and prod from the earlier audit pass. |

## High-Level Findings

1. The strongest reusable system is the article stream: repeated `bt-article` blocks stacked on Slate gradient bands.
2. Photography and gallery presentation dominate the rendered surface area.
3. Areas of Interest are the current taxonomy contract; older `contentType` naming is stale.
4. The current CSS source is still small, but `src/components/site.css` now captures important article, recipe, navigation, and site component styles.
5. Recipe pages now have a documented Tailwind/Alpine/`bt-*` pattern, including nutrition modal and print behavior.
6. Template-level image alt fallbacks have improved, but native asset alt coverage remains a major content cleanup task.
7. Mobile navigation controls now have accessible labels in source; focus behavior still needs rendered verification.
8. Contact is visually adjacent to the system but not integrated into the `bt-article` component model.
9. Assets, upload paths, ImageOptimize fields, and content QA need to be treated as design-system contracts.

## Local Artifacts

The earlier render audit wrote temporary screenshots and JSON to:

```text
/private/tmp/bentilden-design-system-audit
```

Those artifacts are not committed to this repo.
