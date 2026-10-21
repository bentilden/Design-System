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
  - bentilden.com/templates/_entry-content/recipe/page.twig
  - bentilden.com/templates/_entry-content/recipe/teaser.twig
  - bentilden.com/templates/_entry-content/recipe/quantity.twig
  - bentilden.com/templates/_components/segmented-control.twig
  - bentilden.com/templates/_components/recipe-info.twig
  - bentilden.com/templates/_components/entry-header.twig
  - bentilden.com/templates/_components/text-content.twig
  - bentilden.com/templates/_matrix/text.twig
  - bentilden.com/templates/_partials/entry/captionedImage.twig
  - bentilden.com/modules/recipes/Rules.php
  - bentilden.com/modules/recipes/IngredientReference.php
  - bentilden.com/modules/recipes/Schema.php
  - bentilden.com-css/src/recipe.js
  - bentilden.com-css/scripts/qa-recipes-browser.mjs
dependencies:
  - Alpine.js
  - Craft CKEditor
accessibility:
  reviewed: false
  notes: Chromium keyboard, link navigation, narrow layouts and print checked locally; screen-reader and cross-browser audit outstanding.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-10-20
review_status: needs audit
---

# Recipe Content

## Current Interface

Production release, 2026-10-20: a recipe has a shared title, date, introduction with a recipe-facts box, and main image, followed by navigation within its content. This replaces the separate introduction/story/detail experience. The older code remains historical evidence. Runtime `fa04576` is deployed with the additive recipe authoring fields applied; production currently has no saved Recipe entries, so interface verification used unsaved native elements without publishing development examples.

The [shared segmented control](navigation.md#reusable-segmented-control) selects one section at a time:

| Section | Availability | Native content |
| --- | --- | --- |
| Overview | Only when authored | Existing optional `story` blocks, labeled Overview in the Recipe editor. |
| Ingredients | Always | Ordered `ingredients` rows with quantity, unit and ingredient text. |
| Steps | Always | Ordered `steps`, optional headings, linked ingredients, instructions and inline photos. |
| Notes | Only when authored | `notes`, headed Notes & tips in the panel. |
| Nutrition | At least one authored value | Per-serving nutrition fields; authored zero values remain visible. |

Ingredients is the default. Keep short introductions in the shared header; use Overview for optional background, context and technique. A listing renders a teaser linking to the unified recipe rather than embedding its section controls.

Cooking-list introduction refinement, 2026-10-20: the teaser renders native `entry.introduction` inside a block wrapper, allowing authored rich-text paragraphs to inherit their intended styling instead of being moved outside an invalid nested paragraph. It uses normal-weight Neutral 700 text at 16/28 px on phones and 18/32 px from `md`, with 12 px between successive paragraphs and no extra first/last child margins. This matches the recipe introduction’s reading rhythm; teaser titles, dates, image layout and View recipe link retain their existing treatment. Evidence: local uncommitted `teaser.twig` and generated CSS.

The recipe navigation stays within its article, below the global site header. `compact: true` reduces the shared control's label padding on small screens while retaining its borders, selected surface, typography, focus treatment and touch-target height. Other callers retain the component's default spacing.

## Spacing And Type

Local visual refinement, 2026-10-20, using the apple crumble example: recipe metadata now lives at the end of the introduction column, rather than in a full-width information bar above navigation. The `layout: 'box'` recipe-info variant renders a bordered definition list with left-aligned values in a shared column, Neutral 300 outer/row borders matching the segmented control, and retained utensil/clock icons. The introduction-to-box gap is 24 px. Labels/values use 14 px/20 px type, medium-weight values and 20 px icons; rows have 16 px horizontal and 10 px vertical inset. A 112 px icon/label track and 16 px column gap keep values close to labels at every width; the value track uses the remaining width and allows long durations to wrap. Print recipe is a standalone action 8 px below the facts box, with its printer icon and a 44 px minimum target height. Unauthored facts omit their rows; if all facts are absent, only an unboxed Print action appears. The existing bar/compact variants remain available for other callers.

The intro/photo grid has 32 px below it before the recipe navigation row on phones, 40 px from `md`. This follows whichever intro/image column is taller; phones place the facts before the hero photo. The control-to-heading gap remains 32/40 px. The shared control's own styling and target sizes stay unchanged. Following the October 20 control correction, the recipe navigation row has no separate fill or backdrop blur, letting the article gradient show through. Two decorative 1 px Neutral 300 rules meet the centered control and extend to the article container's left/right content edges. The row retains its existing sticky position and print hiding. When all five segments are present, recipe-only label padding tightens below 400 px (1 px below 375 px, 6 px from 375–399 px) so both rules and the control fit within the article gutter; text remains 12 px and phone targets remain 44 px high. Recipes with fewer segments keep the shared component's normal compact padding.

Recipe titles use 36 px on phones, 40 px at `md` and 48 px at `lg`, with smaller date text and a 24 px gap before the introduction. Tablet intro/image columns share the available width equally; the existing five/seven split starts at `lg`. Other entry headers retain their defaults through optional `titleClass` and `dateClass` arguments.

The segmented control and the content column beneath it are horizontally centered at every width, while text remains left-aligned. All panels, including Nutrition, share a 42 rem maximum reading width. Intro, Overview, Steps and Notes use a consistent 16 px/28 px reading scale on phones and 18 px/32 px from `md`. Section headings are 24/28 px; optional step headings are 22/24 px. Following the owner's latest October 20 refinement, recipe `h2` and `h3` headings both use Bold (700), superseding the earlier h2 800 treatment. This applies to panel titles and authored rich-text headings in Overview, Notes and Step instructions, preserving their existing HTML levels. Step action headings remain `h3` at 700. Nutrition uses the label’s internal Nutrition facts title as its `h2` at 700, without a duplicate heading above the label. These explicit weights replace the display utility's 950 default. The main recipe title retains its existing treatment. The first step starts without an extra dividing rule; subsequent steps retain their separators. Existing authored Overview block types and embedded photos remain supported.

Evidence: uncommitted Twig and generated CSS, native dev rendering at 390/768/1440 px, and the focused recipe browser checks at 320/375/768/1440 px. The original local refinement did not establish a release or a screen-reader/print-pagination audit; production rollout evidence is recorded below.

## Navigation And Accessibility

Each segment is an ordinary link with `recipeView` and a content anchor. The server renders the requested section, so direct links and navigation work without JavaScript. Alpine switches panels in place, updates `aria-current`, preserves other URL parameters, and supports browser Back/Forward. Modified clicks retain normal browser behavior. These are navigation links, not an ARIA tab widget.

Panels have associated headings. Hidden panels are excluded from normal screen interaction. On an in-place switch, the control remains usable and the reader's previous position within a section is retained where possible. Every section becomes visible for printing, including when JavaScript is disabled.

## Overview

Local Overview refinement, 2026-10-20: native `entry.story` blocks retain their order and capabilities, including rich text, inline Captioned images, tables, HTML and buttons. Do not append a button linking to the separate recipe page: the segmented control already provides Ingredients and Steps navigation. The two authored demo Overview buttons were removed on 2026-10-20; Button blocks remain available for other appropriate authored links. Body text uses the shared 16/28 px phone and 18/32 px `md` scale, including HTML block text that previously inherited a smaller scale. The article drop-cap treatment is reset within Overview so the opening paragraph follows the same reading rhythm as the other recipe sections; other articles keep their drop caps.

Topic headings use Display type, with authored `h2` and `h3` at 700, 22/28 px on phones and 24/32 px from `md`, with 32 px above and 8 px to following content. Paragraphs have 16 px spacing and successive Matrix blocks have 24 px between them. First/last text edges are reset, including the nonvisual story-table template. Tables retain native horizontal-scroll behavior; their extra internal outer margins are removed so they do not introduce unexplained gaps before photos.

Photos stay within the text column, at their existing aspect ratio and authored position, with 24 px figure spacing. Captions use the same 14/20 px type and 8 px image gap as Steps; credits use 12/20 px with 4 px above them. Recipe Overview and Step image-size hints describe the actual 42 rem desktop column, avoiding the smaller source selected by the generic 65 ch article hint. The shared Text/Captioned image renderers accept an optional `imageSizes` argument; other callers retain the existing default. Native alt text, placement captions/credits, image destinations and the shared viewer are preserved. Chromium review at 320/390/768/1440 px covers both Overview examples, centered alignment, measured text/photo spacing and unchanged authored text; viewer opening, caption and Escape checks pass at 390/1440 px.

## Ingredient Rows

Local refinement, 2026-10-20: the two-column ingredient table separates quantity and unit within the measure cell. Medium-weight tabular numerals are the strongest measure cue; units use a smaller, quieter style and ingredient names retain the normal reading scale. Rows stay top-aligned so wrapped names remain associated with their measure.

Below `sm` (640 px), quantity and unit stack with a 2 px gap. The preferred measure-column width is 80 px including 16 px right padding, replacing the earlier 112 px column and leaving more room for names. Quantities/names are 16 px with 28 px line-height; units are 12 px with 18 px line-height. From `sm`, quantity and unit sit on a shared baseline with an 8 px gap, in a 144 px preferred column with 24 px right padding; units are 14 px/20 px. Quantity/name type grows to 18 px/32 px at `md`.

Rows use 12 px vertical padding on phones and 14 px from `md`, with quiet dividing rules. Unitless counts omit the unit line; quantity-free ingredients leave the measure cell empty and keep the name aligned with other rows. Quantities use the existing formatter and pluralization; no unit abbreviations, conversions or replacement fraction policy were introduced. Native `ingredient.quantity`, `ingredient.unit` and `ingredient.ingredient` remain visible in the table's Twig. Step-reference formatting retains its existing compact inline treatment.

## Step Anatomy And Authoring

A Step retains required instruction text, with these additions:

| Field | Behavior |
| --- | --- |
| `stepHeading` | Optional short heading; the step number remains when absent. |
| `stepIngredients` | Optional ordered Matrix of Step ingredient entries. Empty lists produce no ingredient header. |
| `recipeIngredient` | Required within each Step ingredient; native relation constrained to this recipe's enabled master ingredient rows. |
| `stepIngredientQuantity` | Optional amount in the master ingredient's unit. Blank inherits its full quantity. |
| `text` | Existing contextual handle for global CKEditor field `text2`; now supports native Captioned image entries between paragraphs. |
| `image` | Existing contextual handle for global asset field `image2`; retained as a legacy trailing-image fallback. |

Save the recipe's master ingredient list before adding references. Ingredient names and units come from that list, so edits are reflected in the step header. For divided ingredients, author the recipe's full amount once and use per-step amounts, such as 40 g sugar in the filling and 60 g in the topping. The model rejects references to another recipe or disabled/removed ingredients, duplicate references within a step, and nonpositive or excessive per-step amounts. It does not calculate a recipe-wide allocation total.

A step can include multiple Captioned images in reading order, with placement-specific captions and credits through the existing image editor and shared viewer. New process images should use the Instructions editor's Image button. Existing separate step images continue to render after the instructions.

Local Steps refinement later on 2026-10-20 groups the 12 px step number and action heading in one header, with 6 px between them. Action headings are 22 px/28 px line-height on phones and 24 px/32 px from `md`. A step without an authored heading uses a 16 px medium-weight number and has no empty heading space.

The header has 20 px below it. Optional ingredient references use 14 px/24 px type, a quiet label and a thin inset rule; another 20 px separates the list from the method. Instructions retain the shared 16/28 px phone and 18/32 px larger-screen reading scale. First/last child margins are reset within a flow-root so rich-text edge margins do not change that grouping. Step separators retain more space than the within-step gaps.

Process photos remain full-column and appear in authored order between paragraphs, with 24 px around a figure. An 8 px image-to-caption gap, 14 px/20 px captions and 12 px/20 px credits distinguish image metadata from the method. Credit follows caption by 4 px. Native Captioned image placements expose `data-image-caption` and `data-image-credit` for this scoped treatment; Overview now shares this caption/credit scale; other article captions retain their existing treatment. The legacy trailing Step image uses the same photo spacing and metadata scale. Image links and the shared viewer retain their existing behavior.

The Recipe's existing required title, summary, Area of Interest, introduction and main image remain. At least one ingredient and one step are required. Servings, times, Overview, notes and nutrition are optional. Use the blank unit for unitless counts or quantity-free serving suggestions.

## Notes

Local Notes refinement, 2026-10-20: Notes & tips retains the shared panel heading and 42 rem reading width. Authored topic headings retain the Display face and 22 px/28 px phone, 24 px/32 px `md` scale, below the panel title in size. Their native `h2` and `h3` levels use 700, as do Step action headings. Deeper authored headings use smaller sizes. Original heading elements and rich-text content remain intact.

An 8 px gap connects a heading to its following text or list. Topic headings have 32 px above them on phones and 40 px from `md`; consecutive paragraphs have 16 px between them. Paragraphs retain the shared 16/28 px and 18/32 px reading scale. Lists have 16 px outer spacing and 4 px item margins. A flow-root with first/last child margin resets makes the panel's edge spacing predictable, including when Notes begins with a paragraph. Links remain underlined, with a small underline offset, and long words can wrap within the column.

The treatment is scoped to the native `entry.notes` output. Notes remains optional; its content, CMS model, emphasis and link destinations are unchanged. Chromium review covers both authored Notes examples at 320/390/768/1440 px, exact rich-text preservation, measured spacing/type, print visibility and absent-Notes fallback. Production verification is recorded below; this does not establish a full print/accessibility audit.

## Nutrition

Nutrition is a normal recipe section, replacing the local modal. Its only heading is Nutrition facts inside the label; this `h2` supplies the section’s `aria-labelledby` target. The separate outer Nutrition heading is omitted. An energy definition list and captioned nutrient table display authored values per serving with the existing units. Values are editorial inputs, not calculated nutrition analysis. Partial information is allowed; missing rows are omitted and authored zeroes are retained.

Local packaging refinement and width update, 2026-10-20: the Nutrition facts panel has no separate background fill, allowing the article gradient to show through, and fills the same centered 42 rem reading column as the other views, with a 16 px corner radius and a 6 px Neutral 300 outer border. Insets are 20 px on phones, 24 px from `sm`. Below `sm` (640 px), the summary and nutrient rows stack with a 16 px gap. From `sm`, the panel uses two columns in a 0.85/1.15 ratio with a 32 px gap: title, serving context and energy on the left; nutrient rows on the right. A fine Neutral 300 vertical rule with 24 px inset separates them. This composition uses the wider space without spreading nutrient names far from their values.

The label title remains Bold (700) Display, 28/32 px on phones and 32/36 px from `sm`, with normal letter spacing and a deliberate two-line title in the split layout. Per serving is a quiet 12/16 px uppercase Micro label with 8 px above it. A 2 px Neutral 300 header rule and 16 px lower padding anchor the summary. The energy definition list retains Calories and Calories from fat only when authored. Calories uses an 18/24 px medium name beside a 36/40 px medium Display value on phones; from `sm`, its name is 14/20 px above a left-aligned 48 px value with an 8 px gap. The summary has 24 px above energy and 20 px between energy rows at these wider sizes.

The nutrient table stays semantic and captioned. Ordinary rows use 14/24 px type and 8 px vertical padding, with fine Neutral 300 dividers and matching top rules at Total fat, Total carbohydrate and Protein. In the split layout from `sm`, the first nutrient row has no top rule; stacked phone layouts retain their existing leading rule. The final row has no closing bar. Main nutrient names and tabular values use medium weight; supporting names use normal weight and a quieter Neutral 600. Saturated/trans fats indent under an authored Total fat row; fiber/total sugars indent under authored Total carbohydrate. Added sugars indent another level when Total sugars exists. Units use quieter 12/16 px type with a 4 px gap, and values remain right-aligned. The existing conditional hierarchy is retained for partial information. If no nutrients are authored, the table, split columns and vertical divider are omitted; absent energy omits its definition list. The recipe's h2/h3 weights are both 700; their sizes and spacing retain the hierarchy.

This is a visual treatment of the existing editorial fields. The twelve available nutrient rows, labels, units, authored numbers, empty-field omission and zero handling remain; no serving weights, daily-value percentages or calculated nutrition are synthesized. Chromium checks at 320/390/640/768/1440 px confirm shared-column alignment, responsive fit, all twelve preserved demo values and print visibility. The wider recipe suite covers optional-section fallback and navigation.

Border-color refinement, 2026-10-20: all Nutrition outer and internal borders now match the shared segmented control’s Neutral 300, as do the introduction facts box and its row dividers. Thickness, spacing and layout are retained. See the [border and divider rules](../foundations/color.md#border-and-divider-rules) for the reusable roles.

## Metadata, Images And Print

The introduction facts box retains servings and prep/active/total times. Print recipe is a separate action beneath the box, outside the facts definition list and border. Facts remain visible when printing; the action is hidden. Without JavaScript the authored facts still render, while browser printing remains available through the browser command. Nutrition is reached through the segmented control. Main images use the shared responsive-image component and priority loading; step images remain lazy. Captions and credits stay with their images.

Print reveals all authored sections, hides section navigation and action controls, and omits the hero and process photos. A complete print typography/pagination audit remains outstanding. Browser printing remains available without JavaScript; the enhanced Print button appears after Alpine initializes.

## Quantity Formatting

The existing Twig quarter-rounding formatter is retained in `quantity.twig` for both the master list and step references. Stored thirds/eighths can still display imprecisely. A more appropriate quantity policy requires separate editorial research; this interface change does not establish one.

## Compatibility And Verification

The root entry URL now renders the interface. Existing `/cooking/<slug>/recipe` and `/cooking/<slug>/story` destinations render it with Ingredients and Overview selected respectively; a missing Overview still returns 404 on the old story route. Recipe SEO setup points these views at the root entry URL. Native draft-aware elements are used directly in Twig.

Evidence: local runtime `174f9f9` and frontend `0e18382`, 2026-10-20; the source files listed above and native Craft layouts were inspected. `scripts/recipe-qa.php` checks ownership, quantity validation, draft-aware identity resolution, picker constraints and schema state. `npm run qa:recipes` checks the three local examples at 320/375/768/1440 px, section availability, ordinary keyboard links, browser history, no-JavaScript navigation, print, inline image ordering and legacy routes. These checks do not establish Safari, screen-reader or physical-printer behavior.

## Related Pages

- [Craft Structure](../content-model/craft-structure.md) describes fields and nested entries.
- [Assets & Media](../content-model/assets-media.md) covers image delivery.
- [Accessibility](../accessibility/index.md) defines the review bar.
- [Content QA](../operations/content-qa.md) covers general authoring checks.

Scoped commit handoff, 2026-10-20: runtime `174f9f9` and frontend `0e18382` preserve the unified interface and the final refinements described here. The generated assets were built from recipe-only staged sources; unrelated working edits were excluded. All 44 recipe section/viewport checks plus history, keyboard, print, no-JavaScript, inline-image and legacy-route checks passed against these assets. Shared root/story/photo browser checks and 13 native recipe model checks passed. These commits remained local at that handoff; the production rollout is recorded below.

Nutrition follow-up committed locally on 2026-10-20 in runtime `fa04576`: the label follows the article background and its internal Nutrition facts h2 is the sole section heading. Responsive, print, no-JavaScript and accessible-name checks passed before rollout; production verification is recorded below.


## Production Release Verification

Released 2026-10-20: runtime `fa04576836d72c0ff1f229b304f55877266d7674`, frontend `cae5e6f1f1eeefe051bb7618b27fa3a37d640e27`, Envoyer release `20261021001444`. All 33 changed runtime files match the release commit. A fresh Craft process confirms the four new fields, Step ingredient type/reference class, expected Step layout, optional Overview label and native inline-image configuration, with no pending Project Config. Existing production content fingerprints are unchanged.

Production has no Recipe entries. Unsaved native full/minimal fixtures were rendered by production Twig and exercised with the actual public CSS/JavaScript through browser-local routes at 320/390/768/1440 px. Section navigation/history, metadata/Print separation, divided step references, absent-section fallback, all twelve nutrients including a zero, the single internal heading, transparent surface, print and no-JavaScript behavior pass. These are renderer/asset checks, not tests of a published recipe URL or an interactive CMS save. Root/story/photo browser checks and deployed content/asset/route/header QA pass. Safari, screen readers and physical print pagination remain outside this review.
