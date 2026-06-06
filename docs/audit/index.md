---
title: Audit
type: audit
status: draft
source_of_truth: audit finding
audience:
  - design
  - development
  - governance
owner: Ben Tilden
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
- what is legacy or needs refactoring,
- what needs a design decision.

## Current Audit Pass

The first deep audit pass reviewed:

| Area | Scope |
| --- | --- |
| Templates | 47 Twig templates under `bentilden.com/templates`. |
| Craft project config | 93 files under `bentilden.com/config/project`. |
| CSS source | Tailwind entrypoint, type, grid, button, and article icon CSS. |
| Rendered pages | 25 page/viewport checks across dev and prod. |
| Viewports | Desktop `1440x1200`, mobile `390x1200`. |

## High-Level Findings

1. The strongest reusable system is the article stream: repeated `bt-article` blocks stacked on Slate gradient bands.
2. Photography and gallery presentation dominate the rendered surface area.
3. The current CSS source is very small; many visible behaviors are composed directly in Twig with Tailwind utilities.
4. Recipe pages still use older Foundation-era classes such as `grid-x`, `cell`, `medium-*`, `reveal`, `show-for-print`, and `hide-for-print`.
5. Rendered pages did not show horizontal overflow in the audited desktop or mobile viewports.
6. Image alt text is the largest visible accessibility gap in the sample.
7. The mobile navigation dialog has ARIA dialog metadata, but the icon-only menu button needs an accessible name.
8. Contact is visually adjacent to the system but not integrated into the `bt-article` component model.

## Local Artifacts

The render audit wrote temporary screenshots and JSON to:

```text
/private/tmp/bentilden-design-system-audit
```

Those artifacts are not committed to this repo.
