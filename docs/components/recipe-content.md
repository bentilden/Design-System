---
title: Recipe Content
type: component
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_entry-content/recipe/default.twig
  - bentilden.com/templates/_entry-content/recipe/story.twig
  - bentilden.com/templates/_entry-content/recipe/recipe.twig
  - bentilden.com/templates/_components/recipe-info.twig
  - bentilden.com/templates/_components/icon.twig
  - bentilden.com/config/project/entryTypes/recipe--d5580cc9-9d66-469b-988e-6d4a8996364c.yaml
  - bentilden.com/config/project/fields/ingredients--8eb75052-cb0c-4c0e-a2a7-93f7347d5cd6.yaml
  - bentilden.com/config/project/fields/steps--c0209d19-1f58-4b15-9d71-1b844c1a8db5.yaml
  - bentilden.com-css/src/components/site.css
classes:
  - bt-recipe-intro-page
  - bt-recipe-label
  - bt-introduction
  - bt-infoBar
  - bt-recipe-ingredients-and-instructions
  - bt-ingredients
  - bt-instructions
  - bt-table-ingredients
  - bt-cell-quantity
  - bt-cell-ingredient
  - bt-control-nutritionInformation__table
dependencies:
  - Alpine.js
  - Alpine focus plugin
accessibility:
  reviewed: false
  notes: Current source includes dialog, trap, captions, and table captions; rendered keyboard/screen-reader behavior still needs audit.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-08
review_status: needs audit
---

# Recipe Content

Recipe content is now a first-class site pattern, not just a legacy plugin remnant. The retired recipe plugin should not be reintroduced unless it replaces the custom recipe model entirely.

## Current Views

| View | Template | Purpose |
| --- | --- | --- |
| Recipe intro | `_entry-content/recipe/default.twig` | Landing page that links to the story and/or recipe. |
| Recipe story | `_entry-content/recipe/story.twig` | Narrative story view with a recipe link. |
| Recipe detail | `_entry-content/recipe/recipe.twig` | Ingredients, instructions, times, nutrition, notes, image, and print behavior. |

Local header refinement, 2026-10-18: the centered [topic identity](article-content.md#article-icons) sits above the recipe layout. Recipe landing/detail titles and dates are restored to their existing five-column introduction/header area beside the image; the story view retains its centered prose-width header. The detail title retains its recipe URL; introduction, metadata, image, nutrition, instructions, and print controls remain in their existing body layout. Uncommitted source above runtime `0221ddc`; no deployment claimed.

## Detail Anatomy

Recipe detail pages include:

- recipe label,
- entry header and published date,
- introduction,
- main image with caption/details when present,
- servings,
- prep, active, and total time,
- nutrition modal,
- ingredients table,
- instructions list,
- optional process images for steps,
- notes,
- print action.

Recipe images use the shared responsive-image component. The main recipe image may use the shared `priority` path for likely LCP delivery; optional step images should stay lazy. Captions/details remain visible editorial metadata beneath the image.

## Information Bar

Local update, 2026-10-17: `_components/recipe-info.twig` renders a semantic list using native `entry.servings`, `entry.prepTime`, `entry.activeTime`, and `entry.totalTime` beside [Lucide icons](icons.md). `utensils` marks servings, `clock-3` marks times, `slash` separates times, `printer` marks Print, and nutrition uses `heart-pulse`, selected by the owner on 2026-10-17. The fixture marks Heart Pulse as selected and retains the other reviewed options for comparison. The nutrition dialog's Close and the story-to-recipe pot also use the shared 1.5-stroke helper.

This replaces the old `bt-servings`/`bt-times`/nutrition/print icon pseudo-elements with inline SVG and Tailwind utilities. Their original SVG files remain comparison sources for the guarded review fixture. The information bar uses a wide row when its container reaches 56 rem; narrower containers stack naturally. Nutrition and print handlers, conditional metadata, and visible native field handles are preserved. This is a local implementation, not a production release.

## Ingredients And Instructions

Ingredients and instructions sit in a responsive grid:

| Hook | Role |
| --- | --- |
| `bt-recipe-ingredients-and-instructions` | Shared recipe detail grid. |
| `bt-ingredients` | Ingredients column. |
| `bt-instructions` | Instructions column. |
| `bt-table-ingredients` | Ingredient rows. |
| `bt-cell-quantity` | Quantity and unit cell. |
| `bt-cell-ingredient` | Ingredient name cell. |

Ingredient quantities are formatted in Twig before rendering. Whole numbers remain whole numbers; quarter-step values render as fractions; and units appear in the quantity column before the ingredient name.

## Nutrition Modal

Nutrition uses Alpine state and the focus plugin:

- `nutritionModalOpen` controls visibility.
- Escape closes the modal.
- `role="dialog"`, `aria-modal="true"`, and `aria-labelledby` identify the dialog.
- `x-trap.noscroll.inert` handles focus trapping and background inertness.
- The nutrition table uses `bt-control-nutritionInformation__table` and a visually hidden caption.

Keyboard and screen-reader behavior still need rendered verification before this component can move to `approved`.

## Print

Print behavior is part of the recipe component. The CSS switches the ingredients/instructions layout to a print-friendly flow and adjusts section spacing.

The current print action is button-driven JavaScript. Keep the action visible and reachable from the recipe info bar.

## Authoring Contract

Recipe entries should include:

- title,
- summary,
- Area of Interest,
- introduction,
- main image,
- optional image per step when a process photo clarifies the instruction,
- servings and timing when known,
- at least one ingredient,
- at least one step,
- optional notes for substitutions, storage, source attribution, or context.

Use the blank unit option for unitless ingredients.

## Open Decisions

- Should the `Recipe` label become a generalized entry-type badge?
- Should nutrition information remain modal-only, or should there be an inline fallback?
- Should print output get its own rendered regression check?
- Should recipe metadata appear in stream cards or stay inside recipe detail pages?

## Related Pages

- [Craft Structure](../content-model/craft-structure.md) describes recipe fields and nested entries.
- [Assets & Media](../content-model/assets-media.md) covers main and step image delivery.
- [Accessibility](../accessibility/index.md) defines the review bar for dialogs, tables, and print.
- [Content QA](../operations/content-qa.md) and [Open Questions](../audit/open-questions.md) connect authoring checks with unresolved recipe decisions.
