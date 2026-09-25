---
title: Open Questions
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

# Open Questions

This page captures decisions carried forward from the June 2026 audit that should be resolved before observed patterns become approved design-system guidance. Resolve an item with a dated decision, supporting evidence, and a link to the updated component or content-model page; do not silently discard a question when source behavior changes.

## Current Questions

- Which patterns should remain intentionally personal/editorial, and which should become reusable system components?
- How should dev, staging, and prod examples be labeled when content differs but templates match?
- What is the desired accessibility bar for [lightbox galleries](../components/galleries.md) and [mobile navigation](../components/navigation.md)?
- Should the design system document v1 and v2 [matrix blocks](../components/matrix-blocks.md) separately, or declare v1 blocks deprecated?
- Should [contact/form styling](../components/forms.md) be absorbed into the article system or remain a distinct utility page pattern?
- Should image alt text be required before publish, or handled as a [content QA](../operations/content-qa.md) warning?
- Should the [standalone image route](../content-model/assets-media.md#standalone-image-route) restrict assets to Photos and enforce post-asset relations after legacy asset cleanup? A partial source check on 2026-09-25 confirmed neither constraint in the inspected lookup.
- Should the mobile navigation heading labeled `Posts` remain an `h1`, or become a lower-level heading inside the dialog?
- Should malformed gallery markup be fixed before the gallery pattern can move from `observed` to `approved`?
- Should [recipe nutrition information](../components/recipe-content.md#nutrition-modal) remain modal-only, or should there be an inline fallback?
