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
| `category.twig` | Area of Interest stream; Places adds Map and Posts views. |
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

## Places Posts View

The photography category defaults to [Places Map + Gallery](places.md). Its Posts view retains the full chronological stream, including entries without located photographs. Map viewport changes do not filter these posts. Pagination links retain `view=posts`; paginated category routes also select Posts by default.

Scoped source review, 2026-09-28: checked `bentilden.com/templates/category.twig`, `_places/index.twig`, and `_components/pagination.twig` at first-release commit `b1cf61ef358dc56cce21402f973740ca5d6ad174`. See [Places verification](places.md#implementation-and-verification) for its release checks; the earlier render observations below retain their historical scope.

## Visual Rules

- Alternate content is separated by repeated Slate gradient article bands.
- The Area of Interest icon appears above each article header unless the entry type overrides it.
- Pagination sits in a Slate 200 band below the preceding rule and meets the global footer directly. Equal vertical padding centers its controls between these boundaries.
- Stream pages use Area of Interest and entry schema classes to support targeted styling.
- Preview image fallback coverage matters because stream pages rely on image rhythm.

## Pagination

The 2026-09-28 refinement styles `_components/pagination.twig` with inline Tailwind utilities. Its Slate 200 navigation band uses `py-12` for 48 px above and below the controls; the list uses flex alignment without its former vertical padding. Extra horizontal padding starts at `md`, and page-number gaps are 4 px below `sm` and 16 px from `sm`, preserving control padding while fitting narrow screens. The former `bt-control-pagination` class and its descendant-list definitions are removed from `site.css`, including the outer vertical margins that exposed a pale strip before the footer.

Source inspected in uncommitted website changes above `b1cf61e` and frontend changes above `f3f709f`. All 13 targeted Chromium cases passed after the narrow-screen refinement: Home and Places first/middle/last pages at 320/390 px, plus Home at 1280 px. Pagination controls remained inside the viewport and centered, with 48 px above and below and no gap between the content wrapper and footer. The earlier 18 samples independently confirmed the same vertical spacing. Places pagination retains `view=posts` through navigation.

This verifies pagination fit, not every page’s content width: long headline words still cause existing 320 px document overflow on Home page 3 and Places Posts pages 2 and 4. A combined three-route release run passed content, asset/environment, build, and font checks but browser QA encountered external Google DNS failures on Home and the sampled recipe page. The final responsive build passed after the spacing refinement. The historical render observation below records the former class rather than a current styling dependency.

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
