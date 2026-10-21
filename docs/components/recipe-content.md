---
title: Recipe Content
type: component
status: observed
source_of_truth: observed dev code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_entry-content/recipe/page.twig
  - bentilden.com/templates/_entry-content/recipe/teaser.twig
  - bentilden.com/templates/_entry-content/recipe/quantity.twig
  - bentilden.com/templates/_components/segmented-control.twig
  - bentilden.com/templates/_components/scroll-separation.twig
  - bentilden.com/templates/_components/recipe-info.twig
  - bentilden.com/templates/_components/recipe-duration.twig
  - bentilden.com/templates/_components/entry-header.twig
  - bentilden.com/templates/_components/text-content.twig
  - bentilden.com/templates/_matrix/text.twig
  - bentilden.com/templates/_partials/entry/captionedImage.twig
  - bentilden.com/modules/recipes/Rules.php
  - bentilden.com/modules/recipes/Quantity.php
  - bentilden.com/modules/recipes/RecipeVariable.php
  - bentilden.com/modules/recipes/IngredientReference.php
  - bentilden.com/modules/recipes/Schema.php
  - bentilden.com-css/src/recipe.js
  - bentilden.com-css/src/scroll-separation.js
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

For the approved table-style definitions and guidance on reuse, see [Tables](tables.md). Editorial, Measurement and Reference roles preserve the different treatments in Overview, Ingredients and Steps; the Nutrition label remains its own component, and metadata is a separate facts inset. The owner approved these roles, shared rules and context-selection model on 2026-10-21.

Production follow-up, 2026-10-21: runtime `b266d3c` / frontend `2f80ae5` deploy the step ingredient tables, Nutrition refinements and shared [Scroll Separation](../patterns/scroll-separation.md) treatment. Earlier local-only records below retain their original review scope. Deployed source/public asset hashes match, and production assets pass native recipe fixtures at six widths. Demo recipes remain on dev; no production recipe entries or schema changes were introduced.

Local implementation, 2026-10-20: a recipe has a shared title, date, introduction with a recipe-facts box, and main image, followed by navigation within its content. This replaces the separate introduction/story/detail experience in the local checkout. The older code remains historical evidence, not the current dev interface. No production release is established by this review.

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

Historical metadata refinement, 2026-10-20, superseded by the inset below: recipe metadata now lives at the end of the introduction column, rather than in a full-width information bar above navigation. The `layout: 'box'` recipe-info variant renders a bordered definition list with left-aligned values in a shared column, Neutral 300 outer/row borders matching the segmented control, and retained utensil/clock icons. The introduction-to-box gap is 24 px. Labels/values use 14 px/20 px type, medium-weight values and 20 px icons; rows have 16 px horizontal and 10 px vertical inset. A 112 px icon/label track and 16 px column gap keep values close to labels at every width; the value track uses the remaining width and allows long durations to wrap. Print recipe is a standalone action 8 px below the facts box, with its printer icon and a 44 px minimum target height. Unauthored facts omit their rows; if all facts are absent, only an unboxed Print action appears. The existing bar/compact variants remain available for other callers.

Approved metadata inset, implemented locally on 2026-10-21 in runtime `fb9d959`: the same `layout: 'box'` variant now uses a borderless Neutral 200/50 surface with 20 px corners (18 px up to 420 px). The inset fits its content on desktop; on phones it fills available introduction width up to 350 px. Padding is 28 px horizontally / 23 px vertically, reducing to 20/21 px on phones. The serving count uses 36 px in the wide three-column layout and retains 88 px in the narrower stacked layout. Two/three-digit counts scale down to fit. Neutral 300 vertical dividers separate present groups, without a trailing divider. There are no row rules.

Historical contextual color trial, 2026-10-21: the initial inset and near-black values competed with the introduction. A Neutral 100 surface and Neutral 500 numeral were tested on dev, then superseded by the owner-approved compact version below.

Approved compact follow-up, 2026-10-21, implemented locally: restore the earlier Neutral 200/50 surface and Neutral 300 divider, and lighten the serving numeral to Neutral 500 at 86% opacity (approximately #858585 over the inset). This scoped text-opacity treatment matches the approved mockup without adding a color token. Large total-time numerals on desktop and phones match the serving numeral at Neutral 500/86%; compact Prep/Active values, labels and units remain Neutral 600. Icons remain Neutral 500. The stacked serving label/value gap is 5 px and its leading is 0.86. In the wide layout, both primary values use a 3 px label gap and 1.1 leading to share one text baseline, and compact timing details start 12 px after the total in the stacked layout; the wide layout places them in their own column. The approved mockup’s compact geometry was verified before the subsequent numeral-size and gap refinements below. The split dark-panel alternative was not selected.

Total time leads the right group at 36 px (27 px on phones), with 1.1 line height, followed by compact Prep and Active facts at 14/20 px (13/20 px on phones), with 6 px between their rows. Label text, numeric values and units share a baseline; the clock SVG is positioned outside the text baseline calculation and centered against the label line. Native whole-minute fields render as compact hour/minute groups through `_components/recipe-duration.twig`; full spoken wording remains available to assistive technology. Zero remainders omit an unnecessary minute group. These are display changes only; CMS values and field handles remain native.

Single timing fact refinement, 2026-10-21, committed locally in runtime `53b0ee6`: when only one of `prepTime` or `activeTime` is authored, show it as a primary fact with the full Prep time / Active time label above its value. Match Total time’s clock, 3 px label gap, 36 px/600 normal-tracking numerals (27 px up to 420 px), muted numeric color, quieter units and prominent hour/minute group spacing. In the wide layout it aligns at the top and shares the primary numeric baseline; narrower layouts stack it beneath Total time when present. With both fields authored, retain the compact two-row Prep/Active group. Without Total time, the same single/paired rule applies. Native fields, omission behavior and separate Print action remain intact. This is a local dev commit; no production deployment is established by this check.

Numeral tracking correction, 2026-10-21: servings and total-time numerals use normal letter spacing at every width. The preceding negative tracking (−0.065 em for servings and −0.035 em for total time) remained from oversized-numeral trials and visibly crowded multi-digit counts such as 15. Both are now explicitly `tracking-normal`; size, weight, color and the shared desktop baseline retain their current treatments.

Divider spacing follow-up, 2026-10-21: use 24 px of spacing on each side of the vertical divider above 420 px; phones retain 16 px on each side. The stacked serving label/value margin is 5 px after the owner’s subsequent 2 px increase; the wide layout uses 3 px to align with Total time.

Size/spacing follow-up, 2026-10-21: the stacked-layout serving count remains 88 px after the earlier reduction from 96 px; the wide layout below uses 36 px. The total-time hour/minute group gap is now 6 px desktop / 4 px phone. Smaller multi-digit serving treatments and the compact Prep/Active duration formatting retain their preceding behavior.

Wide metadata composition, 2026-10-21: the recipe-info wrapper is an inline-size container. At an available introduction width of 29 rem (464 px) or more, the inset uses three columns in reading order: Servings, Total time, then the grouped Prep/Active facts. The timing wrapper becomes `display: contents` so the native definition lists participate directly in the outer grid. The serving numeral uses 36 px, matching the total-time numerals, regardless of digit count in this wide layout. Both values use matching 1.1 leading and 3 px top margins so their text baselines align, while time typography and colors retain their preceding treatment. The compact facts center vertically in their column with no top margin. Each preceding group has a Neutral 300 divider only when another authored group follows, with 24 px on each side. Narrower introduction columns retain the two-column stacked arrangement, including the existing phone presentation. This responds to the actual intro width rather than the browser width alone, avoiding cramped tablet columns. Native fields, spoken duration text and Print remain intact.

Local verification checks all three demos at six widths, layout transitions at eight viewport widths from 320–1920 px, and unsaved missing-group / long-duration / multi-digit fixtures. Prep/Active text baselines remain exact and there is no page overflow. The existing 44 recipe section/viewport checks and required local release QA pass. Runtime `fb9d959` captures this dev implementation; it has not been deployed to production.

The introduction-to-inset gap stays 24 px. Print recipe remains a separate action 10 px below, retaining a 44 px minimum target. Missing facts omit their groups and any orphan divider; a fact-free recipe has no inset. The legacy bar/compact variants remain unchanged. Local Chromium checks cover all three demos at 320/375/390/640/768/1440 px, including exact Prep/Active text baselines, centered icons, standalone Print, and no overflow. Unsaved native fixtures additionally cover absent groups, exact hours, larger servings and longer durations. No production release or screen-reader audit is established by these local checks.

The intro/photo grid has 32 px below it before the recipe navigation row on phones, 40 px from `md`. This follows whichever intro/image column is taller; phones place the facts before the hero photo. The control-to-heading gap remains 32/40 px. The shared control's own styling and target sizes stay unchanged. The recipe navigation has no full-height fill or backdrop blur; its upper-half cover matches the page canvas as described below. Two decorative 1 px Neutral 300 rules meet the centered control and extend to the article container's left/right content edges. The row retains its existing sticky position and print hiding. When all five segments are present, recipe-only label padding tightens below 400 px (1 px below 375 px, 6 px from 375–399 px) so both rules and the control fit within the article gutter; text remains 12 px and phone targets remain 44 px high. Recipes with fewer segments keep the shared component's normal compact padding.

Local scroll correction, 2026-10-21, uncommitted above runtime `f47d90c` and frontend `de9e961`: a CSS cover fills the sticky navigation's upper half, ending at the horizontal rules' midpoint through the segmented control. Content scrolls behind this cover, while the complete control and rules remain above it. Recipe articles now use a uniform Neutral 50 canvas, matching the cover and site header, in place of the inherited white-to-Neutral-100 gradient. This avoids a visibly different navigation band. The lower half remains transparent, and reading content has its own lower stacking context so embedded elements cannot paint above the cover. Covered content cannot intercept clicks; the control and content below the rule retain their pointer targets.

This supersedes an initial JavaScript-driven clip-path implementation after the owner reported flicker during scrolling. The final cutoff uses inline Tailwind utilities only, with no scroll listeners, animation-frame measurements or reactive clipping. It also works without JavaScript. Print hides the entire navigation and cover; the full-screen photo viewer remains outside the recipe layers. Regression checks cover repeated wheel input, content hit targets above/below the rule, control visibility and print. Focused Chromium checks at 320/375/390/640/768/1440 px verify cover/rule alignment with 6× CPU slowdown and repeated wheel input, 120 sampled frames, matching canvas colors and no horizontal overflow. Photo viewing/Escape passes at 390/1440 px, and phone/desktop captures were visually reviewed. The existing 44 recipe section/viewport cases and required local release QA pass. No production deployment or cross-browser audit is included.

Shared-pattern extraction, 2026-10-21, uncommitted: recipes now opt into [Scroll Separation](../patterns/scroll-separation.md), which owns the divider, page-matching cover and shadow following the control's lower edge. The canonical geometry, two-layer values, states and reuse examples live in that pattern. `_components/scroll-separation.twig` wraps the existing segmented control; `src/scroll-separation.js` observes the content boundary and is connected to the recipe's Alpine state. Recipes retain their native links, local section/history behavior, 80/96 px sticky offsets, 20/28 px bottom margins and compact label-fit settings. The recipe page remains Neutral 50, and reading panels retain their lower stacking context and content-start marker.

The extraction preserves navigation/control/content bounds at six widths and produces byte-identical phone/desktop captures compared with the preceding contour implementation. Both shadow layers remain conditional, respect reduced motion and hide in print. Native navigation and the CSS content cover remain usable without JavaScript. The generic wrapper is opt-in; this extraction does not add recipe shadows to Places or other existing segmented controls.

Local commit handoff, 2026-10-21: runtime `b073772` and frontend `2f80ae5` capture the step-table/Nutrition refinements and shared Scroll Separation pattern. Recipe-only generated assets were built against the preceding published frontend baseline to exclude independent Places work. Existing recipe and general root/story/photo browser checks pass with those assets. These commits are local and have not been deployed.

Recipe titles use 36 px on phones, 40 px at `md` and 48 px at `lg`, with smaller date text and a 24 px gap before the introduction. Tablet intro/image columns share the available width equally; the existing five/seven split starts at `lg`. Other entry headers retain their defaults through optional `titleClass` and `dateClass` arguments.

The segmented control and the content column beneath it are horizontally centered at every width, while text remains left-aligned. All panels, including Nutrition, share a 42 rem maximum reading width. Intro, Overview, Steps and Notes use a consistent 16 px/28 px reading scale on phones and 18 px/32 px from `md`. Section headings are 24/28 px; optional step headings are 22/24 px. Following the owner's latest October 20 refinement, recipe `h2` and `h3` headings both use Bold (700), superseding the earlier h2 800 treatment. This applies to panel titles and authored rich-text headings in Overview, Notes and Step instructions, preserving their existing HTML levels. Step action headings remain `h3` at 700. Nutrition uses the label’s internal Nutrition facts title as its `h2` at 700, without a duplicate heading above the label. These explicit weights replace the display utility's 950 default. The main recipe title retains its existing treatment. The first step starts without an extra dividing rule; subsequent steps retain their separators. Existing authored Overview block types and embedded photos remain supported.

Evidence: uncommitted Twig and generated CSS, native dev rendering at 390/768/1440 px, and the focused recipe browser checks at 320/375/768/1440 px. This is a local refinement, not a release or a screen-reader/print-pagination audit.

## Navigation And Accessibility

Each segment is an ordinary link with `recipeView` and a content anchor. The server renders the requested section, so direct links and navigation work without JavaScript. Alpine switches panels in place, updates `aria-current`, preserves other URL parameters, and supports browser Back/Forward. Modified clicks retain normal browser behavior. These are navigation links, not an ARIA tab widget.

Panels have associated headings. Hidden panels are excluded from normal screen interaction. On an in-place switch, the control remains usable and the reader's previous position within a section is retained where possible. Every section becomes visible for printing, including when JavaScript is disabled.

## Overview

Local Overview refinement, 2026-10-20: native `entry.story` blocks retain their order and capabilities, including rich text, inline Captioned images, tables, HTML and buttons. Do not append a button linking to the separate recipe page: the segmented control already provides Ingredients and Steps navigation. The two authored demo Overview buttons were removed on 2026-10-20; Button blocks remain available for other appropriate authored links. Body text uses the shared 16/28 px phone and 18/32 px `md` scale, including HTML block text that previously inherited a smaller scale. The article drop-cap treatment is reset within Overview so the opening paragraph follows the same reading rhythm as the other recipe sections; other articles keep their drop caps.

Topic headings use Display type, with authored `h2` and `h3` at 700, 22/28 px on phones and 24/32 px from `md`, with 32 px above and 8 px to following content. Paragraphs have 16 px spacing and successive Matrix blocks have 24 px between them. First/last text edges are reset, including the nonvisual story-table template. Tables retain native horizontal-scroll behavior; their extra internal outer margins are removed so they do not introduce unexplained gaps before photos.

Approved editorial table refinement, 2026-10-21, committed locally in runtime `8d5eb6b`: Overview rich-text tables use the tighter Refined treatment. Body cells are 16/24 px at every width, normal weight in Neutral 700; first-column body labels use 500 in Neutral 950. Column headings use 14/20 px, weight 600, Neutral 600, with no top padding and 10 px below. Body cells have 10 px vertical padding; the final row has no bottom padding or closing rule. Column gutters are 24 px, reducing to 18 px through 480 px; the last column has no trailing gutter. Cells align at their first baseline. A Neutral 300 header rule and Neutral 200 separators between body rows retain open top/side edges. Authored/content-driven column widths, native text and table structure are preserved. Inline Tailwind selectors on the Overview wrapper keep this scoped to recipe Overview rich text; other recipe table treatments and ordinary article tables retain their styles. Native horizontal scrolling and keyboard focus still work for wide content. Local Chromium checks at 320/390/640/768/1440 px confirm the approved type/padding, final edge and responsive fit; phone/desktop captures were directly reviewed and required local release QA passes. No CMS content edits or production deployment are included.

Contextual spacing follow-up, 2026-10-21, committed locally in runtime `5e0901f`: Overview headings immediately followed by a native table figure use 20 px below the heading, superseding the general 8 px heading margin for that pairing. The spacing belongs to the surrounding layout; the tighter table cells retain their approved padding. See [Table surrounding space](tables.md#surrounding-space).

Shared Editorial renderer follow-up, 2026-10-21, committed locally in runtime `4f5f7fb`: the owner authorized ordinary article adoption. Editorial table utilities and the explicit heading/table gap now live once in `_matrix/text.twig`; the preceding recipe-only selectors were removed from the Overview wrapper. Overview retains its approved computed table/prose styles and native structure. Measurement, Step Reference and Nutrition tables render separately and remain unchanged in before/after browser comparisons. See [Tables](tables.md) for current ownership and adoption evidence.

Photos stay within the text column, at their existing aspect ratio and authored position, with 24 px figure spacing. Captions use the same 14/20 px type and 8 px image gap as Steps; credits use 12/20 px with 4 px above them. Recipe Overview and Step image-size hints describe the actual 42 rem desktop column, avoiding the smaller source selected by the generic 65 ch article hint. The shared Text/Captioned image renderers accept an optional `imageSizes` argument; other callers retain the existing default. Native alt text, placement captions/credits, image destinations and the shared viewer are preserved. Chromium review at 320/390/768/1440 px covers both Overview examples, centered alignment, measured text/photo spacing and unchanged authored text; viewer opening, caption and Escape checks pass at 390/1440 px.

## Ingredient Rows

Production alignment refinement, 2026-10-20, runtime `f47d90c`: the semantic ingredient table uses separate quantity, unit and ingredient-name cells. Quantities align right against one shared boundary; units align left 4 px beyond it, matching the nutrition table's measurement alignment. The first two columns size to the widest quantity and unit within that recipe. The name column takes the remaining space and stays aligned for every row, including unitless and quantity-free entries.

Quantity and unit share a baseline at every viewport, replacing the earlier stacked phone treatment. The unit cell has 16 px of right padding before the name on phones and 24 px from `sm` (640 px). Quantities/names retain 16/28 px type on phones and 18/32 px from `md`; units retain quieter normal-weight Neutral 500 type at 12/18 px on phones and 14/20 px from `sm`. Medium-weight tabular quantities remain the strongest measure cue. Wrapped names align with their measure's first baseline.

Rows use 12 px vertical padding on phones and 14 px from `md`, with quiet dividing rules. Local refinement, 2026-10-21: omit the final row's bottom rule, following the owner's preference for open tables without side or top borders. Unitless counts omit unit text; quantity-free ingredients leave both measure cells empty. Quantities use the shared [quantity formatting](#quantity-formatting) policy; no unit abbreviations or conversions are introduced. Native `ingredient.quantity`, `ingredient.unit` and `ingredient.ingredient` remain visible in the table's Twig. Step-reference formatting retains its existing compact inline treatment.

Chromium geometry checks across the three dev examples at 320/375/390/640/768/1440 px verify shared numeric edges and unit starts, 4 px gaps, aligned names, print visibility and no overflow/page errors. Phone/desktop captures were visually reviewed; the existing recipe browser suite and required local release QA pass. Production verification at `f47d90c` also passed six widths using unsaved native fixtures and live public assets; source and public CSS hashes match. Screen-reader pronunciation remains unaudited.

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

The header has 20 px below it. Local refinement, 2026-10-21, uncommitted above runtime `f47d90c`: optional ingredient references form a compact captioned table inside a 4 px Neutral 200 outline with 12 px corners. The visible caption is For this step, at 12/16 px in Neutral 500. The box has 12 px horizontal padding on phones, 16 px from `sm`, and 10 px vertical padding. Rows use 14/24 px quantity/name type and 6 px vertical padding with fine Neutral 200 separators. Quantities align right, units align left 4 px beyond them, and names share a third column; units are quieter 12/16 px normal-weight Neutral 500. The unit-to-name gap is 12 px on phones and 16 px from `sm`. Cells align at their first baseline, including wrapped names. Unitless/quantity-free rows retain their empty cells, while native draft-aware ownership and step amounts are unchanged. Another 20 px separates the table from the method. Instructions retain the shared 16/28 px phone and 18/32 px larger-screen reading scale. First/last child margins are reset within a flow-root so rich-text edge margins do not change that grouping. Step separators retain more space than the within-step gaps.

Process photos remain full-column and appear in authored order between paragraphs, with 24 px around a figure. An 8 px image-to-caption gap, 14 px/20 px captions and 12 px/20 px credits distinguish image metadata from the method. Credit follows caption by 4 px. Native Captioned image placements expose `data-image-caption` and `data-image-credit` for this scoped treatment; Overview now shares this caption/credit scale; other article captions retain their existing treatment. The legacy trailing Step image uses the same photo spacing and metadata scale. Image links and the shared viewer retain their existing behavior.

The Recipe's existing required title, summary, Area of Interest, introduction and main image remain. At least one ingredient and one step are required. Servings, times, Overview, notes and nutrition are optional. Use the blank unit for unitless counts or quantity-free serving suggestions.

## Notes

Local Notes refinement, 2026-10-20: Notes & tips retains the shared panel heading and 42 rem reading width. Authored topic headings retain the Display face and 22 px/28 px phone, 24 px/32 px `md` scale, below the panel title in size. Their native `h2` and `h3` levels use 700, as do Step action headings. Deeper authored headings use smaller sizes. Original heading elements and rich-text content remain intact.

An 8 px gap connects a heading to its following text or list. Topic headings have 32 px above them on phones and 40 px from `md`; consecutive paragraphs have 16 px between them. Paragraphs retain the shared 16/28 px and 18/32 px reading scale. Lists have 16 px outer spacing and 4 px item margins. A flow-root with first/last child margin resets makes the panel's edge spacing predictable, including when Notes begins with a paragraph. Links remain underlined, with a small underline offset, and long words can wrap within the column.

The treatment is scoped to the native `entry.notes` output. Notes remains optional; its content, CMS model, emphasis and link destinations are unchanged. Chromium review covers both authored Notes examples at 320/390/768/1440 px, exact rich-text preservation, measured spacing/type, print visibility and absent-Notes fallback. This is an uncommitted local refinement, not a production release or a full print/accessibility audit.

## Nutrition

Nutrition is a normal recipe section, replacing the local modal. Its only heading is Nutrition facts inside the label; this `h2` supplies the section’s `aria-labelledby` target. The separate outer Nutrition heading is omitted. An energy definition list and captioned nutrient table display authored values per serving with the existing units. Values are editorial inputs, not calculated nutrition analysis. Partial information is allowed; missing rows are omitted and authored zeroes are retained.

Packaging refinement, updated locally on 2026-10-21 above runtime `f47d90c`: the Nutrition facts panel has no separate background fill, allowing the recipe page canvas to show through, and fills the same centered 42 rem reading column as the other views, with a 16 px corner radius and a 6 px Neutral 200 outer border. The subtler outer color is an owner-requested exception to matching outer/internal rules; internal dividers retain Neutral 300. Insets are 20 px on phones, 24 px from `sm`. Below `sm` (640 px), the summary and nutrient rows stack with a 16 px gap. From `sm`, the panel uses two columns in a 0.85/1.15 ratio with a 32 px gap: title, serving context and energy on the left; nutrient rows on the right. A fine Neutral 300 vertical rule with 24 px inset separates them. This composition uses the wider space without spreading nutrient names far from their values.

The label title remains Bold (700) Display, 28 px on phones and 32 px from `sm`, both with 1.05 leading (29.4/33.6 px), with normal letter spacing and a deliberate two-line title in the split layout. Per serving is a quiet 12/16 px uppercase Micro label with 8 px above it. A 2 px Neutral 300 header rule and 16 px lower padding anchor the summary. The energy definition list retains Calories and Calories from fat only when authored. Calories uses an 18/24 px medium name beside a 36/40 px medium Display value on phones; from `sm`, its name is 14/20 px above a left-aligned 48 px value with a 4 px gap, reduced from 8 px in the October 21 refinement. The summary has 24 px above energy and 20 px between energy rows at these wider sizes.

The nutrient table stays semantic and captioned. Ordinary rows use 14/24 px type and 8 px vertical padding, with fine Neutral 300 dividers and matching top rules at Total fat, Total carbohydrate and Protein. In the split layout from `sm`, the first nutrient row has no top rule; stacked phone layouts retain their existing leading rule. The final row has no closing bar. Main nutrient names and tabular values use medium weight; supporting names use normal weight and a quieter Neutral 600. Saturated/trans fats indent under an authored Total fat row; fiber/total sugars indent under authored Total carbohydrate. Added sugars indent another level when Total sugars exists. Units use quieter 12/16 px type. In the October 20 production alignment refinement, each row has separate name, value and unit cells: values align right against a shared boundary, with units aligned left 4 px beyond it. The shared unit column fits the widest authored unit, so g and mg no longer shift the numbers. This measurement alignment was deployed at runtime `dc5e006` and remains in production `f47d90c`; the October 21 border/type changes are local only. The existing conditional hierarchy is retained for partial information. If no nutrients are authored, the table, split columns and vertical divider are omitted; absent energy omits its definition list. The recipe's h2/h3 weights are both 700; their sizes and spacing retain the hierarchy.

This is a visual treatment of the existing editorial fields. The twelve available nutrient rows, labels, units, authored numbers, empty-field omission and zero handling remain; no serving weights, daily-value percentages or calculated nutrition are synthesized. Chromium checks at 320/390/640/768/1440 px confirm shared-column alignment, responsive fit, all twelve preserved demo values and print visibility. The wider recipe suite covers optional-section fallback and navigation.

Border-color refinement, 2026-10-21: Nutrition now uses a softer Neutral 200 outer outline, retaining Neutral 300 internal rules. Step ingredient tables use Neutral 200 for outline and row separators. The introduction facts box and its row dividers retain Neutral 300. This supersedes the October 20 all-Neutral-300 Nutrition treatment on local dev only. See the [border and divider rules](../foundations/color.md#border-and-divider-rules) for the reusable roles.

Scoped October 21 verification: three recipes across 320/375/390/640/768/1440 px pass step table geometry, shared 4 px quantity/unit boundaries, 4 px Neutral 200 outlines, 12 px corners, print visibility and no overflow/page errors. Nutrition checks confirm its 6 px Neutral 200 outline, 1.05 title leading, 4 px split-layout Calories gap and all twelve authored rows. Existing recipe and required release QA pass. Local implementation only; no production deployment is included.

## Metadata, Images And Print

The introduction facts box retains servings and prep/active/total times. Print recipe is a separate action beneath the box, outside the facts definition list and border. Facts remain visible when printing; the action is hidden. Without JavaScript the authored facts still render, while browser printing remains available through the browser command. Nutrition is reached through the segmented control. Main images use the shared responsive-image component and priority loading; step images remain lazy. Captions and credits stay with their images.

Print reveals all authored sections, hides section navigation and action controls, and omits the hero and process photos. A complete print typography/pagination audit remains outstanding. Browser printing remains available without JavaScript; the enhanced Print button appears after Alpine initializes.

## Quantity Formatting

Accepted on 2026-10-20 in runtime `38782f8` and deployed in production `f47d90c`: `quantity` and `stepIngredientQuantity` are single-line Plain Text fields, accepting whole numbers, decimals, fractions and mixed numbers. Examples are `2`, `1.5`, `1/3`, and `1 1/2`. Pasted common fraction characters normalize to slash notation during validation. Units remain in their existing field; no independently authored numeric/display pair exists.

The shared PHP `Quantity` parser derives exact rational values using the existing Brick Math library. Explicit fractions remain distinct from authored decimals: `1/3` displays as `⅓`, while `0.333` displays as `0.333`. Twig `quantity.twig` reduces explicit fractions for presentation, uses common Unicode fraction characters and compact mixed numbers such as `1½`, and falls back to a legible slash fraction such as `1/16`. Whole-number results display as whole numbers. Decimal notation, including authored trailing decimal zeroes, is retained. No rounding or conversion by unit occurs.

The same formatter and unit grammar serve the ingredient list and step references. Positive amounts up to one use a singular unit; amounts above one and zero use plural units, avoiding the former “1 1/2 tablespoon” error. A blank ingredient quantity omits its measure. A blank step amount inherits the recipe quantity; an explicit step amount must be positive and no greater than the recipe amount, compared exactly. Malformed expressions, negative quantities, zero denominators, units in the quantity input and ranges are rejected by server validation. Mixed-number fractional parts must be proper. Inputs are limited to 64 characters; arithmetic expressions are not evaluated.

Verification at runtime `38782f8` and frontend `de9e961`: 43 exact parser checks, 34 native model/CP-input/Twig checks and the recipe browser suite pass; required local release QA also passes. This replaces the quarter-only policy in production. Fresh native checks confirm both Plain Text fields applied with their identities retained, no pending Project Config, exact step comparisons and preserved content. The production renderer/public assets also pass exact fractions, decimals and alignment at six widths; no recipe fixtures were saved. Ranges, compound measures, paired weight/volume fields and interactive scaling remain separate future work. Direct publisher research observed thirds/eighths at [King Arthur](https://www.kingarthurbaking.com/recipes/classic-birthday-cake-recipe), and fractional measures alongside decimal weights at [Serious Eats](https://www.seriouseats.com/honey-semifreddo-frozen-italian-dessert). NYT Cooking blocked the research tool, so its current interface remains unverified. Unicode copying and native text output are preserved; a screen-reader pronunciation audit is outstanding.

## Compatibility And Verification

The root entry URL now renders the interface. Existing `/cooking/<slug>/recipe` and `/cooking/<slug>/story` destinations render it with Ingredients and Overview selected respectively; a missing Overview still returns 404 on the old story route. Recipe SEO setup points these views at the root entry URL. Native draft-aware elements are used directly in Twig.

Evidence: local runtime `174f9f9` and frontend `0e18382`, 2026-10-20; the source files listed above and native Craft layouts were inspected. `scripts/recipe-qa.php` checks ownership, quantity validation, draft-aware identity resolution, picker constraints and schema state. `npm run qa:recipes` checks the three local examples at 320/375/768/1440 px, section availability, ordinary keyboard links, browser history, no-JavaScript navigation, print, inline image ordering and legacy routes. These checks do not establish Safari, screen-reader or physical-printer behavior.

## Related Pages

- [Craft Structure](../content-model/craft-structure.md) describes fields and nested entries.
- [Assets & Media](../content-model/assets-media.md) covers image delivery.
- [Accessibility](../accessibility/index.md) defines the review bar.
- [Content QA](../operations/content-qa.md) covers general authoring checks.

Scoped commit handoff, 2026-10-20: runtime `174f9f9` and frontend `0e18382` preserve the unified interface and the final refinements described here. The generated assets were built from recipe-only staged sources; unrelated working edits were excluded. All 44 recipe section/viewport checks plus history, keyboard, print, no-JavaScript, inline-image and legacy-route checks passed against these assets. Shared root/story/photo browser checks and 13 native recipe model checks passed. These commits remain local; no production publication is implied.

Nutrition follow-up committed locally on 2026-10-20 in runtime `fa04576`: the label follows the article background and its internal Nutrition facts h2 is the sole section heading. Responsive, print, no-JavaScript and accessible-name checks passed; no production publication is implied.


Production follow-up, 2026-10-21: runtime `4f5f7fb` is deployed and source-verified, including shared Editorial tables in regular articles and recipe Overview, the open Measurement-list edge, and the refined metadata inset with single-time handling. Public CSS bytes match the commit. Live page/browser and deployed-server QA pass; that stylesheet passes all 28 native dev route/viewport comparisons at 320/390/768/1440 px, plus keyboard scrolling, caption positioning, resize focus and print checks. Specialized recipe table styles remain intact. Production has no recipe entries; fixtures remain on dev and no production demo content was added. Earlier local-only checkpoints above are historical. Cross-browser and screen-reader audits remain outside this verification. See the [table adoption receipt](../assets/reports/article-editorial-adoption-2026-10-21.json).
