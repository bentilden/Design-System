---
title: Icons
type: component
status: approved
source_of_truth: observed dev code and design system decision
audience:
  - design
  - development
source:
  - bentilden.com/templates/_components/icon.twig
  - bentilden.com/templates/_components/recipe-info.twig
  - bentilden.com/templates/_icons/lucide/LICENSE
  - bentilden.com/templates/dev-test/icons.twig
  - bentilden.com-css/scripts/build-icons.mjs
  - bentilden.com-css/scripts/qa-icons-browser.mjs
  - bentilden.com-css/package.json
dependencies:
  - Lucide static SVG assets
owner: Documentation owner
created: 2026-10-17
last_reviewed: 2026-10-17
review_status: active
accessibility:
  reviewed: false
  notes: Local Chromium checks cover decorative SVG semantics and control interactions; no screen-reader or physical-device audit is claimed.
---

# Icons

Accepted on 2026-10-17: use **Lucide outline icons with `stroke-width="1.5"`** for the site's interface icons. The light stroke complements Helvetica Now and the Slate palette. The implementation is committed locally in runtime `50b7c0b` and frontend `f2ff4d5`; it has not been pushed or deployed.

## Shared Rendering

```twig
{% include '_components/icon' with {
    name: 'arrow-right',
    iconClass: 'size-4 text-slate-600'
} only %}
```

The helper owns the 24-unit view box, 1.5 stroke, round line caps/joins, `fill="none"`, and `currentColor`. Stroke scales with the icon's displayed size. Its default size is 20 px; contexts use sizes from 12 px compact controls to 28 px viewer navigation. The View post arrow and Details chevron both use 16 px in Slate 300, with white on hover, beside their 12 px labels; homepage arrows are 18 px in Slate 700, improving visibility while retaining the 1.5 stroke. Pass literal Tailwind classes for size, placement, and color. Optional template-authored `attributes` supply bindings such as a disclosure's Alpine rotation.

All icons are decorative SVGs with `aria-hidden="true"` and `focusable="false"`. Put the accessible name on the button/link or visible adjacent text. Preserve labels, hit targets, focus outlines, selected states, and event handlers when changing an icon.

## Context Mapping

| Context | Icons |
| --- | --- |
| Mobile navigation | `menu`, `x` |
| Map zoom, filter removal, attribution | `minus`, `plus`, `x`, `info` |
| Mosaic layout choices | `grid-2x2`, `layout-dashboard` |
| Photo viewer | `minus`, `plus`, `x`, `chevron-left`, `chevron-right`, `chevron-down`, `arrow-right` |
| Places / Food / Work / Blog / Video article symbols | Previous filled artwork retained by owner request |
| Recipe metadata and actions | `utensils`, `clock-3`, `slash`, `heart-pulse`, `printer` |
| Nutrition dialog / story-to-recipe link | `x`, `cooking-pot` |
| Homepage browse links, feature actions, recent rows | `arrow-right` |
| Story table scroll hint | `arrow-right` |

Map attribution retains MapLibre's native disclosure and all required provider links; only its glyph changes. Signatures, favicons, provider branding, photographic map markers, and browser-native controls retain their identities. Hidden LightGallery controls and its engine assets remain library internals.

## Source And Updates

The frontend pins `lucide-static` **1.59.0** as a development dependency. `npm run build:icons` extracts 19 selected SVG geometries into runtime `_icons/lucide/*.twig` and preserves the package's complete ISC/Feather MIT license in `LICENSE` and publicly served `/assets/licenses/lucide.txt`. Each SVG references that notice. It does not add a browser-side icon library or icon font. The normal build and development startup generate these files; they are committed with runtime assets.

To add an icon, extend the curated list in `scripts/build-icons.mjs`, regenerate, and use the shared helper. `npm run qa:icons` checks package geometry, the license, and the exact curated file set for drift. Do not hand-edit generated geometry or replace the shared stroke per icon. Upstream documentation: [Lucide static assets](https://lucide.dev/guide/static), [license](https://lucide.dev/license).

## Review Fixture

`/dev-test/icons` follows the existing **development and staging** fixture policy; all other environment IDs return 404. It extends the guarded fixture layout, which also supplies no-store and noindex directives. The owner explicitly confirmed staging access for this fixture.

Ten context pairs show frozen previous glyphs beside the current treatment with synthetic content. Both article-category columns show the retained original artwork. Recipe previews reuse the real metadata component; compact panels use its container-responsive layout. Menu, layout, filter, zoom, Details, nutrition, print, and attribution examples support interaction. Native live-page behavior is verified separately from the synthetic context panels.

The original recipe image assets remain comparison sources; ordinary recipes use the shared Lucide helper, including Heart Pulse for nutrition. Removed pseudo-element rules no longer draw those icons. Category Twig entry points retain the original filled artwork and category-selection logic.

Accepted by the owner on 2026-10-17: use `heart-pulse` for nutritional information at 24 px with the shared 1.5 stroke and Slate 600 color. The real recipe component and its fixture preview use the same icon directly. The three reviewed options remain below the recipe comparison, with Heart Pulse labeled as selected.

## Verification Scope

Local checks cover the 19-icon generation contract, 42 environment/path guard cases, comparison rendering and interactions at 320/390/1440 px, and the native map attribution disclosure. Existing navigation, viewer, Places, homepage, and isolated homepage-renderer regressions cover the touched public contexts. These are local Chromium and synthetic/unsaved fixture results; they do not establish production, Safari, physical-device, or screen-reader behavior.
