---
title: Areas of Interest
type: pattern
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_entry-content/default.twig
  - bentilden.com/templates/category.twig
  - bentilden.com/templates/svg/photography.twig
  - bentilden.com/templates/svg/cooking.twig
  - bentilden.com/templates/svg/design.twig
  - bentilden.com/templates/svg/blog.twig
  - bentilden.com/config/project/categoryGroups/areasOfInterest--6880db45-0db6-4ee0-99de-1599392237bd.yaml
  - bentilden.com/config/project/fields/areaOfInterest--fca4117f-c2a9-4d87-8c39-31d385b36c3e.yaml
classes:
  - bt-article-topic-*
accessibility:
  reviewed: false
  notes: Category icon links have labels in source; rendered icon semantics still need audit.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Areas of Interest

Areas of Interest are the broad subject lanes for posts. They replaced the older "content type" language and are the current source of topic icons, listing routes, article topic classes, and broad navigation.

Current areas:

- Blog
- Cooking
- Design
- Places (the existing `photography` identity)

Scoped source review, 2026-09-28: `category.twig` and `_entry-content/default.twig` present the photography category as Places while retaining its slug, icon template, and topic CSS hooks. The category opens the [Places map](places.md), with the full stream available in Posts. Checked against the first-release `bentilden.com` source at `b1cf61ef358dc56cce21402f973740ca5d6ad174`; the rest of this page retains its earlier review scope.

## Template Contract

Entries use the `areaOfInterest` field:

```twig
{% if entry.areaOfInterest is not null %}
  {% set entryCategory = entry.areaOfInterest.one() %}
{% else %}
  {% set entryCategory = entry %}
{% endif %}
```

The resolved category slug is used as a visual and testing hook:

```twig
bt-article-topic-{{ entryCategory.slug }}
```

## Icon Pattern

Each area has a matching SVG include:

```twig
{% include "svg/" ~ entryCategory.slug %}
```

Current icon templates include:

- `svg/photography.twig`
- `svg/cooking.twig`
- `svg/design.twig`
- `svg/blog.twig`
- `svg/video.twig`

The icon link points to `/{slug}` and includes an accessible label in the current source.

Scoped source update, 2026-09-28: the category SVG templates use inline `size-12 fill-slate-500 opacity-100 hover:fill-slate-700` styling, preserving their 48 px size and vertical spacing. Solid fills replace the former low-opacity `bt-article-icon` treatment. The SVG remains hidden from assistive technology inside its labeled link. Inspected in uncommitted website changes above `b1cf61e`. Local Chromium checks sampled the photography/cooking icons at 320/390/1280 px, with conservative gradient-endpoint contrast of at least 3.86:1 at rest and 8.40:1 on desktop hover. The other three SVG variants were inspected in source. See [Article Content](../components/article-content.md#article-icons).

## Guidance

- Use Areas of Interest for broad subject identity only.
- Use entry type for content shape, such as story, gallery, featured image, or recipe.
- Use tags for specific cross-cutting subjects, places, tools, projects, or series.
- Keep area icons single-color and clearly visible as links. Use solid Slate 500 with Slate 700 hover rather than reducing opacity.
- Do not reintroduce `contentType` naming in new docs, templates, or Craft instructions unless documenting older migration history.
