---
title: Source Inventory
type: audit
status: observed
source_of_truth: audit finding
audience:
  - design
  - development
source:
  - bentilden.com/templates
  - bentilden.com/config/project
  - bentilden.com-css/src
  - bentilden.com/docs
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: active
---

# Source Inventory

The source audit found a small Tailwind source layer sitting above a larger Twig, Craft content-model, and asset-authoring surface.

## CSS Source

| File | Role |
| --- | --- |
| `bentilden.com-css/src/bentilden.css` | Imports Tailwind 4, declares source paths, loads plugins, defines theme tokens, applies base compatibility rules, and imports local CSS. |
| `bentilden.com-css/src/elements/type.css` | Defines Helvetica Now webfonts. The 2026-09-28 contrast update moves drop-cap styling into inline rich-text wrapper utilities. |
| `bentilden.com-css/src/elements/grid.css` | Defines `bt-page-container` and `bt-grid`. |
| `bentilden.com-css/src/components/button.css` | Defines `bt-button`. |
| `bentilden.com-css/src/components/site.css` | Defines article, image, callout, nav, recipe, info bar, and supporting site component styles. Pagination styling moves into inline template utilities in the 2026-09-28 refinement. |

Scoped contrast inventory, 2026-09-28: uncommitted frontend changes above `f3f709f` remove `components/article-icon.css` and its import, plus unused date/detail/drop-cap definitions from `site.css` and `type.css`. Website SVG, date, and details templates use inline utilities. The stored `bt-dropcap` rich-text class remains a content hook targeted by inline descendant utilities on `_matrix/text.twig`. This is a source observation; see [Typography](../foundations/typography.md) and [Article Content](../components/article-content.md) for rendered verification status.

## Template System

| Pattern | Source | Notes |
| --- | --- | --- |
| Global layout | `_layout.twig` | Loads SEO, compiled CSS, bundled JavaScript, the shared sticky header, growing main-content container, and footer. The compact-header update removes the old main top offset. |
| Global navigation | `_components/global-header.twig`, `global-header-nav-primary.twig`, `global-header-nav-mobile.twig` | Shared CMS links, stable desktop header, and Personal Index mobile modal with inline no-JavaScript fallback. |
| Entry resolver | `_entry-content.twig` | Chooses `_entry-content/{entry.type}/{section}`, then `_entry-content/{entry.type}/default`, then `_entry-content/default`. |
| Matrix resolver | `_matrix.twig` | Chooses `_matrix/{block.type}`, then `_matrix/default`. |
| Stream pages | `index.twig`, `category.twig` | Paginated entry loops using `_entry-content`. |
| Article shell | `_entry-content/default.twig` | Shared `bt-article` gradient shell, Area of Interest icon, entry header, and matrix content. |
| Entry preview image | `_components/entry-preview-image.twig` | Preview image fallback chain for listings. |
| Featured image layout | `_entry-content/featuredImage/default.twig` | Dynamically composes image/text widths based on orientation and alignment. |
| Gallery layout | `_entry-content/gallery/default.twig` | Dynamically composes gallery/text widths based on alignment and gallery style. |
| Recipe branch | `_entry-content/recipe/*.twig`, `_entry/recipe/*.twig` | Intro, story, and recipe detail views with Tailwind, Alpine, and `bt-*` hooks. |
| Contact | `contact.twig` | Form-specific layout with labels, error wiring, honeypot, and reCAPTCHA. |

Scoped header review, 2026-09-28: the shared wrapper and responsive templates above were inspected in uncommitted website changes above `b1cf61e`. Behavior uses Alpine directives and styling uses inline Tailwind utilities. See [Navigation](../components/navigation.md#review-evidence) for sources and verification limits.

Homepage launch update, 2026-09-29: the Stream pages row records the earlier source map. Release `5871297` uses `index.twig` and `_home/` for the curated [Homepage](../patterns/homepage.md), with `_archive/index.twig` owning the chronological archive. See [Stream Pages](../patterns/stream-pages.md#homepage-and-archive-addresses) for the new routes and production verification; the rest of this inventory retains its prior scope.

## Places Addition

Scoped first-release inventory, 2026-09-28: website `b1cf61e` and frontend `99af237` include `bentilden.com/templates/_places/index.twig` and `modules/places/` for the public photo browser, with `bentilden.com-css/src/places.js` and `src/places-geometry.js` owning Alpine and map behavior. `category.twig` selects this interface for the existing photography category; other category streams retain their loop. The new interface uses inline Tailwind utilities and MapLibre library styles. See [Places](../patterns/places.md) for the implementation contract and source-review limits.

## Rendered `bt-*` Surface

These hooks should be considered part of the current documentation backlog:

| Class family | Meaning |
| --- | --- |
| `bt-article`, `bt-article-topic-*`, `bt-article-schema-*` | Article shell and source-aware styling hooks. |
| `bt-control-*` | Matrix block wrapper hooks. |
| `bt-control-image`, `bt-image-file`, `bt-image-caption` | Media presentation hooks. Image details now use inline typography utilities. |
| `bt-item`, `bt-item-name` | Entry/item listing hooks. |
| `bt-nav-menu`, `bt-nav-bigLink`, `bt-icon` | Navigation support hooks. |
| `bt-recipe-*`, `bt-infoBar`, `bt-servings`, `bt-times` | Recipe detail hooks. |
| `bt-cell-*`, `bt-table-ingredients`, `bt-control-nutritionInformation__table` | Recipe table hooks. |

## Craft Content Model

| Area | Handles |
| --- | --- |
| Sections | `homepage`, `about`, `posts` |
| Category groups | `areasOfInterest` |
| Navigation | `globalHeader`, `globalFooter` |
| Asset volumes | `photos`, `siteImages`, `userPhotos` |
| Matrix fields | `story`, `gallery`, `featuredImage`, `ingredients`, `steps` |
| Key entry types | `story`, `gallery`, `featuredImage`, `recipe`, `about`, `homepage`, `text`, `button`, `html`, `heading`, `callout`, `ingredient`, `step` |
| Image transforms | `largeImage`, `featuredImage`, `galleryThumbnails`, `inStoryLarge`, `inStorySmall`, `avatar` |

## Implementation Debt

| Finding | Source | Impact |
| --- | --- | --- |
| Gallery and featured-image matrix blocks have duplicate v1/v2 templates. | `_matrix/gallery*.twig`, `_matrix/featuredImage*.twig` | Needs a deprecation decision. |
| Contact page uses bespoke form layout. | `contact.twig` | Needs a documented form component or explicit exception. |
| Native asset alt text is missing across much of the library. | Photos and Site Images volumes | Templates can fall back, but content quality still depends on authored alt text. |
| Standalone image route does not yet enforce relation to the post. | `image.twig` | Needs legacy asset review before tightening. |

## Related Pages

- [Audit](index.md) records the scope and limits of the June 2026 review.
- [Matrix Blocks](../components/matrix-blocks.md) and [Craft Structure](../content-model/craft-structure.md) explain how template and content-model contracts fit together.
- [Assets & Media](../content-model/assets-media.md#standalone-image-route) contains the later, scoped check of the image lookup.
- [Open Questions](open-questions.md) records the decisions needed to resolve the implementation debt.
