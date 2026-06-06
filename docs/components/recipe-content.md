---
title: Recipe Content
type: component
status: observed
source_of_truth: legacy implementation
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_entry-content/recipe/default.twig
  - bentilden.com/templates/_entry-content/recipe/story.twig
  - bentilden.com/templates/_entry-content/recipe/recipe.twig
  - bentilden.com/config/project/entryTypes/recipe--d5580cc9-9d66-469b-988e-6d4a8996364c.yaml
  - bentilden.com/config/project/fields/ingredients--8eb75052-cb0c-4c0e-a2a7-93f7347d5cd6.yaml
  - bentilden.com/config/project/fields/steps--c0209d19-1f58-4b15-9d71-1b844c1a8db5.yaml
classes:
  - bt-recipe-intro-page
  - bt-introduction
  - bt-infoBar
  - bt-ingredients
  - bt-instructions
  - bt-table-ingredients
dependencies:
  - Foundation
  - nystudio107 recipe field
accessibility:
  reviewed: false
  notes: Print link, nutrition modal, table semantics, and image alt behavior need review.
owner: Ben Tilden
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs decision
---

# Recipe Content

Recipe content is implemented, but it is not yet aligned with the newer Tailwind article system.

## Current Views

| View | Template | Purpose |
| --- | --- | --- |
| Recipe intro | `_entry-content/recipe/default.twig` | Landing page that links to story and/or recipe. |
| Recipe story | `_entry-content/recipe/story.twig` | Narrative story view with a recipe link. |
| Recipe detail | `_entry-content/recipe/recipe.twig` | Ingredients, instructions, times, nutrition, notes, and print behavior. |

## Current Structure

Recipe detail pages include:

- introduction,
- main image,
- servings,
- prep, active, and total time,
- nutrition modal,
- ingredients table,
- instructions list,
- notes,
- print link.

## Legacy Layer

Recipe templates use Foundation-era classes and behaviors:

```html
grid-x grid-margin-x cell medium-5 medium-7 reveal close-button show-for-print hide-for-print
```

These should be treated as legacy until the system decides whether to modernize recipes into Tailwind and `bt-*` utilities.

## Accessibility Notes

- The print action uses `href="javascript:window.print()"`; consider a real button.
- The nutrition modal depends on Foundation `data-open` and `data-close`; keyboard and focus behavior need testing.
- Ingredient quantities and names are table cells; semantics should be checked for screen readers.
- Main recipe images currently render without a reliable `alt` attribute.

## Open Decisions

- Should recipe pages be modernized before they are documented as approved components?
- Should nutrition information be a modal, inline section, or disclosure?
- Should recipe print styles become part of the design system?
- Should recipe metadata be surfaced consistently in stream cards?
