---
title: Foundations
type: foundation
status: draft
source_of_truth: observed production code
audience:
  - design
  - development
source:
  - bentilden.com-css/src/bentilden.css
  - bentilden.com-css/src/elements/type.css
  - bentilden.com-css/src/elements/grid.css
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Foundations

Foundations describe the smallest reusable decisions in the system: color, typography, spacing, and layout.

The current site is not a large tokenized product interface. It is closer to an editorial system with a handful of reliable ingredients:

- Slate neutrals for page structure, borders, metadata, and strong contrast.
- Orange accents in mobile active states.
- Helvetica Now families for text, display, and microcopy.
- A responsive 4/8/12 column grid with fixed maximum widths.
- Generous vertical rhythm around article content.
- Tailwind 4 CSS-first theme tokens declared in `src/bentilden.css`.

Use these pages as the baseline before creating new components.
