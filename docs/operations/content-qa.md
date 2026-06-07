---
title: Content QA
type: operation
status: observed
source_of_truth: observed production code
audience:
  - development
  - content
  - governance
source:
  - bentilden.com/scripts/content-qa.php
  - bentilden.com/docs/craft-authoring-standards.md
  - bentilden.com/docs/assets.md
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: active
---

# Content QA

Content QA is the bridge between the design system and the Craft control panel. The templates can provide safe fallbacks, but the site still depends on well-authored entries and clean media.

## Command

Run the QA script from the website repo:

```bash
ddev exec php scripts/content-qa.php
```

## Current Checks

The script reports:

- entries missing Areas of Interest,
- preview image fallback gaps,
- raw HTML block usage,
- root-level Photos assets,
- Photos missing native alt text,
- Photos with no element relations,
- suspicious test folders,
- Site Images missing native alt text,
- soft-deleted volume residue,
- ImageOptimize config drift,
- recipe step image field drift.

## Authoring Standards

Use three layers of author guidance:

1. Field instructions for the one-sentence rule.
2. Tab or screen guidance for workflow and common pitfalls.
3. Repository docs and QA scripts for repeatable standards.

Matrix and nested entries should be readable when collapsed. Media blocks should show thumbnails. Repeatable recipe blocks should label themselves from visible content. Raw HTML blocks should be rare and intentionally reviewed.

## Preview Image Fallback

Preview Image is an optional override. Templates should fall back in this order:

1. Preview Image
2. Recipe Main Image
3. Featured Image block image
4. Gallery block first image
5. First image found in story blocks

When that chain fails, stream/listing pages lose the visual rhythm that the design system depends on.

## Promotion Criteria

A documented pattern is not ready to become `approved` while the QA script flags unresolved issues that directly affect that pattern. For example:

- Gallery docs depend on meaningful alt text and clean media relations.
- Recipe docs depend on ingredients, steps, timing, and image fallback behavior.
- Stream page docs depend on preview image fallback coverage.
