---
title: Open Questions
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

# Open Questions

This page captures decisions that should be resolved before observed patterns become approved design system guidance.

## Current Questions

- Which patterns should remain intentionally personal/editorial, and which should become reusable system components?
- Should older Foundation-era recipe layout and modal classes be modernized into Tailwind-backed `bt-*` utilities?
- Should licensed Helvetica Now webfonts be included in the design system site, or should the docs continue using system fallbacks?
- How should dev, staging, and prod examples be labeled when content differs but templates match?
- What is the desired accessibility bar for lightbox galleries and mobile navigation?
- Should the design system document v1 and v2 matrix blocks separately, or declare v1 blocks deprecated?
- Should contact/form styling be absorbed into the article system or remain a distinct utility page pattern?
- Should image alt text default to asset title, caption, a required author-provided alt field, or intentionally empty alt for decorative images?
- Should the mobile navigation heading labeled `Posts` remain an `h1`, or become a lower-level heading inside the dialog?
- Should malformed gallery markup be fixed before the gallery pattern can move from `observed` to `approved`?
