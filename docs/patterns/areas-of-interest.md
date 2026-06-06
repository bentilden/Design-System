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
  - bentilden.com/config/project/categoryGroups/areasOfInterest--b00f82d7-12d9-4a67-9e3c-bb7be7d7eae1.yaml
  - bentilden.com/config/project/fields/areaOfInterest--fca4117f-c2a9-4d87-8c39-31d385b36c3e.yaml
classes:
  - bt-article-topic-*
  - bt-article-icon
accessibility:
  reviewed: false
  notes: Category icon links have labels in source; rendered icon semantics still need audit.
owner: Ben Tilden
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
- Photography

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

## Guidance

- Use Areas of Interest for broad subject identity only.
- Use entry type for content shape, such as story, gallery, featured image, or recipe.
- Use tags for specific cross-cutting subjects, places, tools, projects, or series.
- Keep area icons quiet and single-color. They should orient the reader without competing with titles and images.
- Do not reintroduce `contentType` naming in new docs, templates, or Craft instructions unless documenting older migration history.
