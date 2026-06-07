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
| `bentilden.com-css/src/elements/type.css` | Defines Helvetica Now webfonts and `bt-dropcap`. |
| `bentilden.com-css/src/elements/grid.css` | Defines `bt-page-container` and `bt-grid`. |
| `bentilden.com-css/src/components/button.css` | Defines `bt-button`. |
| `bentilden.com-css/src/components/article-icon.css` | Defines `bt-article-icon`. |
| `bentilden.com-css/src/components/site.css` | Defines article, image, callout, nav, pagination, recipe, info bar, and supporting site component styles. |

## Template System

| Pattern | Source | Notes |
| --- | --- | --- |
| Global layout | `_layout.twig` | Loads SEO, CSS, lightGallery, lazysizes, Alpine, global header, main offset, and footer. |
| Entry resolver | `_entry-content.twig` | Chooses `_entry-content/{entry.type}/{section}`, then `_entry-content/{entry.type}/default`, then `_entry-content/default`. |
| Matrix resolver | `_matrix.twig` | Chooses `_matrix/{block.type}`, then `_matrix/default`. |
| Stream pages | `index.twig`, `category.twig` | Paginated entry loops using `_entry-content`. |
| Article shell | `_entry-content/default.twig` | Shared `bt-article` gradient shell, Area of Interest icon, entry header, and matrix content. |
| Entry preview image | `_components/entry-preview-image.twig` | Preview image fallback chain for listings. |
| Featured image layout | `_entry-content/featuredImage/default.twig` | Dynamically composes image/text widths based on orientation and alignment. |
| Gallery layout | `_entry-content/gallery/default.twig` | Dynamically composes gallery/text widths based on alignment and gallery style. |
| Recipe branch | `_entry-content/recipe/*.twig`, `_entry/recipe/*.twig` | Intro, story, and recipe detail views with Tailwind, Alpine, and `bt-*` hooks. |
| Contact | `contact.twig` | Form-specific layout with labels, error wiring, honeypot, and reCAPTCHA. |

## Rendered `bt-*` Surface

These hooks should be considered part of the current documentation backlog:

| Class family | Meaning |
| --- | --- |
| `bt-article`, `bt-article-topic-*`, `bt-article-schema-*` | Article shell and source-aware styling hooks. |
| `bt-control-*` | Matrix block wrapper hooks. |
| `bt-control-image`, `bt-image-file`, `bt-image-caption`, `bt-image-details` | Media presentation hooks. |
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
| Gallery template has reported malformed markup: `class="text-center""`. | `_entry-content/gallery/default.twig` | Browser likely recovers, but this should be fixed before treating gallery layout as approved. |
| Gallery and featured-image matrix blocks have duplicate v1/v2 templates. | `_matrix/gallery*.twig`, `_matrix/featuredImage*.twig` | Needs a deprecation decision. |
| Contact page uses bespoke form layout. | `contact.twig` | Needs a documented form component or explicit exception. |
| Native asset alt text is missing across much of the library. | Photos and Site Images volumes | Templates can fall back, but content quality still depends on authored alt text. |
| Standalone image route does not yet enforce relation to the post. | `image.twig` | Needs legacy asset review before tightening. |
