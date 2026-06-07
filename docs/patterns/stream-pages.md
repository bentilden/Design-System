---
title: Stream Pages
type: pattern
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/index.twig
  - bentilden.com/templates/category.twig
  - bentilden.com/templates/_entry-content.twig
  - bentilden.com/templates/_components/entry-preview-image.twig
  - bentilden.com/templates/_components/pagination.twig
classes:
  - bt-article
  - bt-item
  - bt-item-name
  - bt-control-pagination
accessibility:
  reviewed: false
  notes: Pagination is labelled; heading hierarchy and repeated article navigation need review.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Stream Pages

Stream pages are the most important page-level pattern in the current site. They render a paginated vertical sequence of full article previews.

## Sources

| Template | Role |
| --- | --- |
| `index.twig` | Homepage stream of posts. |
| `category.twig` | Area of Interest stream. |
| `_entry-content.twig` | Resolves each entry to the correct article preview template. |
| `_components/entry-preview-image.twig` | Resolves listing preview imagery. |
| `_components/pagination.twig` | Renders previous/next and page-number navigation. |

## Structure

```twig
{% for entry in entries %}
  {% include '_entry-content' %}
{% endfor %}
```

Each item is not a compact card. It is a full-width article section with generous vertical rhythm and, often, media large enough to feel like the primary content.

## Visual Rules

- Alternate content is separated by repeated Slate gradient article bands.
- The Area of Interest icon appears above each article header unless the entry type overrides it.
- Pagination sits in a Slate 200 band with a top border.
- Stream pages use Area of Interest and entry schema classes to support targeted styling.
- Preview image fallback coverage matters because stream pages rely on image rhythm.

## Preview Image Fallback

Stream preview imagery should resolve in this order:

1. Preview Image
2. Recipe Main Image
3. Featured Image block image
4. Gallery block first image
5. First image found in story blocks

## Render Audit

| Finding | Evidence |
| --- | --- |
| Home and category streams rendered without horizontal overflow in desktop and mobile samples. | Playwright audit |
| Photography stream carries the highest image density. | Render sample |
| Cooking stream differs meaningfully between dev and prod content. | Dev includes recipe intro test content; prod sample includes story/featured-image entries. |
| Pagination is present when there are more entries. | `bt-control-pagination` observed in stream samples. |

## Open Decisions

- Should stream entries be documented as article previews, cards, or full articles?
- Should stream pages expose a compact index mode in the future?
- Should content differences between dev and prod be excluded from visual regression checks?
