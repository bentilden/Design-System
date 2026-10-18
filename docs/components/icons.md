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

Accepted on 2026-10-17: use **Lucide outline icons with `stroke-width="1.5"`** for the site's interface icons. The light stroke complements Helvetica Now. The current local [Neutral palette trial](../foundations/color.md) replaces the earlier Slate interface colors while preserving the shared stroke and sizes. Destination-owned identity icons and the new topic header were approved on 2026-10-18. The implementation is committed locally in runtime `4a339ef` and frontend `76ec360`; no deployment of this change is claimed.

## Shared Rendering

```twig
{% include '_components/icon' with {
    name: 'arrow-right',
    iconClass: 'size-4 text-neutral-600'
} only %}
```

The helper owns the 24-unit view box, 1.5 stroke, round line caps/joins, `fill="none"`, and `currentColor`. Stroke scales with the icon's displayed size. Its default size is 20 px; contexts use sizes from 12 px compact controls to 28 px viewer navigation. The View post arrow and Details chevron both use 16 px in Neutral 300, with white on hover, beside their 12 px labels; homepage arrows are 18 px in Neutral 700, improving visibility while retaining the 1.5 stroke. Pass literal Tailwind classes for size, placement, and color. Optional template-authored `attributes` supply bindings such as a disclosure's Alpine rotation.

All icons are decorative SVGs with `aria-hidden="true"` and `focusable="false"`. Put the accessible name on the button/link or visible adjacent text. Preserve labels, hit targets, focus outlines, selected states, and event handlers when changing an icon.

## Context Mapping

| Context | Icons |
| --- | --- |
| Mobile navigation | `menu`, `x` |
| Map zoom, filter removal, attribution | `minus`, `plus`, `x`, `info` |
| Mosaic layout choices | `grid-2x2`, `layout-dashboard` |
| Photo viewer | `minus`, `plus`, `x`, `chevron-left`, `chevron-right`, `chevron-down`, `arrow-right` |
| Navigation and article topic identities | CMS-selected `identityIcon`: initially `house`, `map`, `cooking-pot`, `pen-tool`, and `notebook-pen` |
| Recipe metadata and actions | `utensils`, `clock-3`, `slash`, `heart-pulse`, `printer` |
| Nutrition dialog / story-to-recipe link | `x`, `cooking-pot` |
| Homepage browse links, feature actions, recent rows | `arrow-right` |
| Story table scroll hint | `arrow-right` |

Map attribution retains MapLibre's native disclosure and all required provider links; only its glyph changes. Signatures, favicons, provider branding, photographic map markers, and browser-native controls retain their identities. Hidden LightGallery controls and its engine assets remain library internals.

## Source And Updates

The frontend pins `lucide-static` **1.59.0** as a development dependency. `npm run build:icons` generates all **2,159 shipped SVG identifiers** (including upstream aliases) as server-side Twig geometry and local SVG previews for Verbb Icon Picker **3.1.5**. It preserves the complete ISC/Feather MIT notice in both catalogs and `/assets/licenses/lucide.txt`. Each public inline SVG references that notice.

The CP can select any icon from this pinned catalog. The public renderer validates the selection against the generated manifest and inlines only that icon's geometry through the shared helper. It does not load the catalog, preview files, icon font, sprite sheet, or browser-side Lucide library. Choosing another included icon requires no frontend rebuild.

`identityIcon` is an optional, single-choice field on Areas of Interest topic entries and the Homepage single. Navigation reads the linked destination's value; a post reads `entry.areaOfInterest.one().identityIcon`. About and Contact have no picker. Navigation retains authored labels, ordering, grouping, and current states. See [Areas of Interest](../patterns/areas-of-interest.md) and [Article Content](article-content.md#article-icons).

To update the available collection, deliberately update the pinned package, regenerate, and review selections before removing deprecated identifiers. `npm run qa:icons` checks the entire catalog, metadata, previews, geometry, and licenses for drift. Do not hand-edit generated geometry. Upstream documentation: [Lucide static assets](https://lucide.dev/guide/static), [license](https://lucide.dev/license).

## Review Fixture

`/dev-test/icons` follows the existing **development and staging** fixture policy; all other environment IDs return 404. It extends the guarded fixture layout, which also supplies no-store and noindex directives. The owner explicitly confirmed staging access for this fixture.

Ten context pairs show frozen previous glyphs beside the current treatment with synthetic content. The article panel compares frozen original artwork with the actual CMS-selected topic identity component. Recipe previews reuse the real metadata component; compact panels use its container-responsive layout. Menu, layout, filter, zoom, Details, nutrition, print, and attribution examples support interaction. Native live-page behavior is verified separately from the synthetic context panels.

The original recipe image assets remain comparison sources; ordinary recipes use the shared Lucide helper, including Heart Pulse for nutrition. Removed pseudo-element rules no longer draw those icons. Legacy category SVG files remain available for historical comparison but ordinary post headers no longer select them by slug or title keywords.

Accepted by the owner on 2026-10-17: use `heart-pulse` for nutritional information at 24 px with the shared 1.5 stroke; its current trial color is Neutral 600. The real recipe component and its fixture preview use the same icon directly. The three reviewed options remain below the recipe comparison, with Heart Pulse labeled as selected.

The complementary `/dev-test/topic-layouts` fixture pairs the same CMS-selected icon/label with eight full-width synthetic content layouts. It offers topic and title-length controls, reuses the shared title/date and Story Text components, and follows the same dev/staging policy. See [Article Content](article-content.md#topic-layout-review-fixture).

## Verification Scope

Local checks cover the full 2,159-identifier generation contract, 56 environment/path guard cases, comparison rendering and interactions at 320/390/1440 px, and the native map attribution disclosure. Existing navigation, viewer, Places, homepage, and isolated homepage-renderer regressions cover the touched public contexts. These are local Chromium and synthetic/unsaved fixture results; they do not establish production, Safari, physical-device, or screen-reader behavior.

Scoped verification, 2026-10-18: native Craft save/reopen checks temporarily selected `telescope` in a rolled-back database transaction, verified inheritance through a navigation node and a related post, and rendered it without a rebuild. Native CP field rendering and catalog enumeration passed. Responsive post/header checks at 320/390/768/1440 px passed on four photo, gallery, and recipe routes with zero unused-catalog requests. This is not an authenticated CP browser interaction or production deployment test. Sources: `modules/identityicons/`, `scripts/identity-icons-qa.php`, `scripts/identity-icons-cp-qa.php`, and frontend `scripts/qa-identity-icons-browser.mjs`, the local changes now committed at the revisions listed above.
