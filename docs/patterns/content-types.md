---
title: Content Types
type: pattern
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_entry-content/default.twig
  - bentilden.com/templates/svg/photography.twig
  - bentilden.com/templates/svg/cooking.twig
  - bentilden.com/templates/svg/design.twig
  - bentilden.com/templates/svg/blog.twig
  - bentilden.com/config/project/categoryGroups/contentTypes--6880db45-0db6-4ee0-99de-1599392237bd.yaml
accessibility:
  reviewed: false
  notes: Icon alt and category-link semantics need audit.
owner: Ben Tilden
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Content Types

The site organizes posts around content types such as photography, cooking, design, and blog. Content type affects icons, navigation, URLs, and article classes.

## Template Hooks

```twig
{% if entry.contentType is not null %}
  {% set entryCategory = entry.contentType.one() %}
{% else %}
  {% set entryCategory = entry %}
{% endif %}
```

The category slug is used for visual hooks:

```twig
bt-article-topic-{{ entryCategory.slug }}
```

## Icon Pattern

Each content type has an SVG include:

```twig
{% include "svg/" ~ entryCategory.slug %}
```

Current icon templates include:

- `svg/photography.twig`
- `svg/cooking.twig`
- `svg/design.twig`
- `svg/blog.twig`
- `svg/video.twig`

## Guidance

- A content type should have a stable URL segment, icon, and article class.
- Icons should remain single-color and quiet, with low opacity by default.
- Avoid making content type treatments too decorative; the images and titles should carry most of the personality.
