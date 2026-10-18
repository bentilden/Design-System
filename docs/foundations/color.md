---
title: Color
type: foundation
status: observed
source_of_truth: observed dev code
audience:
  - design
  - development
source:
  - bentilden.com/templates/_layout.twig
  - bentilden.com/templates/_components/topic-identity.twig
  - bentilden.com/templates/_matrix/text.twig
  - bentilden.com/templates/_components/global-header-nav-primary.twig
  - bentilden.com/templates/_components/global-header-nav-mobile.twig
  - bentilden.com-css/src/bentilden.css
  - bentilden.com-css/src/places-map-style.js
  - bentilden.com-css/scripts/qa-palette-browser.mjs
tokens:
  - neutral
environments:
  observed:
    - dev
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-10-18
review_status: needs audit
---

# Color

## Current Local Trial: Neutral

The owner requested a trial switch from Tailwind Slate to **Neutral** on 2026-10-18. The current local website uses Neutral for interface text, page surfaces, rules, controls, and map theming. Existing shade numbers and opacity values are retained. This visual trial is committed locally in runtime `4a339ef` and frontend `76ec360`; no production deployment or permanent palette decision is claimed. The documentation site's own theme is separate and remains unchanged.

Tailwind utilities name the actual palette (`text-neutral-600`, `bg-neutral-50`, etc.). Slate has not been remapped behind its old class names. Existing inline styling and native Craft field access remain. Frozen pre-migration icon comparison artwork retains its historical colors.

## Core Palette

The following values were read from compiled CSS tokens and converted to sRGB in local Chromium at 390 and 1440 px:

| Shade | Hex | Main role |
| --- | --- | --- |
| Neutral 50 | `#fafafa` | Content surfaces outside the post gradient |
| Neutral 100 | `#f5f5f5` | Post gradient endpoint, quiet hover fill |
| Neutral 200 | `#e5e5e5` | Page frame, topic circle, subtle dividers/selected fills |
| Neutral 300 | `#d4d4d4` | Structural boundaries and circle hover |
| Neutral 400 | `#a1a1a1` | Owner-selected light topic label and dark-footer copyright |
| Neutral 500 | `#737373` | Topic-label hover, medium details/controls |
| Neutral 600 | `#525252` | Secondary text, captions, dates |
| Neutral 700 | `#404040` | Prose, stronger hover/focus treatment |
| Neutral 900 | `#171717` | Dark footer, primary control fill |
| Neutral 950 | `#0a0a0a` | Strongest text, outline icons, current navigation |

## Usage

| Use | Current treatment |
| --- | --- |
| Page shell | Neutral 200 frame and Neutral 50 content |
| Post boundaries | Full-post white-to-Neutral-100 vertical gradient with a 1 px Neutral 200 divider only between adjacent articles |
| Topic identity | Neutral 200 circle / 300 hover; Neutral 950 thin icon; Neutral 400 label / 500 hover |
| Post dates | Owner-edited normal body text in Neutral 600; image details retain their own metadata typography |
| Prose | `prose-neutral` on the shared Story Text renderer, plus existing explicit Neutral utilities |
| Navigation | Neutral 600 links with stronger Neutral 950 current/hover states and existing underline/dot treatments |
| Footer | Neutral 900 surface; existing white primary links and Neutral 400 copyright |
| Forms | Neutral borders, text, focus, and placeholder defaults; fixture selects use shared Neutral Lucide chevrons |
| Map | `readMapPalette()` reads `--color-neutral-*`; `themeMapStyle()` maps known provider color literals while preserving filters, geometry, expressions, alpha, and zoom behavior |

Semantic colors, photographs, signature/favicons, upstream map input literals, and third-party branding retain their existing identities. The map's output palette follows Neutral; its provider-color lookup keys remain the original strings needed for matching.

## Map Palette

The [Places map](../patterns/places.md) reads its Neutral shades from compiled CSS through `readMapPalette()`. The browser converts those tokens to RGB for MapLibre, so map styling and interface styling use the same source. `themeMapStyle()` changes known color paint values while retaining provider layer filters, geometry, alpha, label rules, and zoom expressions. Unknown future provider colors remain available for deliberate review.

## Verification And Open Review

`qa:palette` samples page surfaces, header/footer, topic identity, post date, prose, forms, fixture, and generated map markers on the local site. Compiled Neutral tokens and sampled interface colors have equal RGB channels. It also checks the owner's current 10 px icon/label gap and 20/40 px date margins. The related layout suites cover responsive placement, form choices, and navigation separately.

The owner-selected **Neutral 400 topic label measures approximately 2.48:1 against Neutral 50**, below the 3:1 large-text criterion used in earlier reviews. Its lighter shade was retained for this trial; the identity browser report records the contrast result separately from rendering/layout success. This does not establish accessibility conformance. Final label contrast and palette acceptance remain design-review items.

## Earlier Slate Evidence

Earlier navigation and color work used Slate: the 2026-09-28 audit measured Slate 600 at approximately 7.25:1 on Slate 50 and 6.15:1 on Slate 200, with Slate 400 copyright on Slate 900 at approximately 6.78:1. These are historical measurements of different colors, not Neutral trial results. Later segmented-control reviews changed selection from a dark reversed fill to shade 200 with dark text. See [Navigation](../components/navigation.md) and [Places](../patterns/places.md) for their dated observations; their older Slate names identify the palette at those revisions.

Use this page for the current local palette and the dated component evidence for earlier releases. No production palette state was reverified for this trial.

Scoped gradient refinement, 2026-10-18: runtime changes committed locally at `f4b25ec` restore a white-to-Neutral-100 vertical gradient on posts and topic-layout samples. Each article restarts at white; stream borders remain between adjacent posts. About retains its separate Neutral 50-to-200 gradient. The earlier topic-label contrast measurement above was taken against the previous flat Neutral 50 background and is historical; final label contrast remains a review item.
