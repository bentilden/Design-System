---
title: Matrix Blocks
type: component
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_matrix.twig
  - bentilden.com/templates/_matrix/default.twig
  - bentilden.com/templates/_matrix/text.twig
  - bentilden.com/templates/_matrix/heading.twig
  - bentilden.com/templates/_matrix/callout.twig
  - bentilden.com/templates/_matrix/button.twig
  - bentilden.com/templates/_matrix/html.twig
  - bentilden.com/templates/_matrix/featuredImage2.twig
  - bentilden.com/templates/_matrix/gallery2.twig
classes:
  - bt-control-*
  - bt-text
  - bt-callout
  - bt-button
  - bt-control-image
  - bt-image-caption
  - bt-image-details
dependencies:
  - Tailwind typography plugin
  - lightGallery
  - lazysizes
accessibility:
  reviewed: false
  notes: Text, heading, button, image, gallery, and raw HTML blocks need block-by-block rendered audit.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Matrix Blocks

Matrix blocks are the main article composition system. They let entries combine prose, headings, calls to action, raw HTML, callouts, featured images, and galleries inside the shared article shell.

## Resolver Contract

The matrix resolver tries the block-specific template first and falls back to the default wrapper:

```twig
{% include [
  "_matrix/" ~ block.type,
  "_matrix/default"
] %}
```

The default wrapper generates a stable control hook:

```twig
bt-control-{{ block.type }}
```

That means every block type can be targeted for styling, audits, and QA even when most of the visual styling lives inside the block-specific template.

## Current Block Types

| Block | Template | Role |
| --- | --- | --- |
| Text | `_matrix/text.twig` | Main prose, using `bt-text` plus Tailwind typography utilities. |
| Heading | `_matrix/heading.twig` | Section heading with optional divider. |
| Callout | `_matrix/callout.twig` | Highlighted editorial aside with optional author-supplied class. |
| Button | `_matrix/button.twig` | Centered call to action using the shared `bt-button` class. |
| HTML | `_matrix/html.twig` | Raw HTML escape hatch. Use sparingly. |
| Featured Image | `_matrix/featuredImage2.twig` | Single editorial image with optional link, caption, details, and lightbox behavior. |
| Gallery | `_matrix/gallery2.twig` | Multi-image or inline gallery with responsive optimized images and lightbox behavior. |

Legacy `featuredImage.twig` and `gallery.twig` templates still exist. Treat the `*2` templates as current unless the content model explicitly routes older entries to the v1 templates.

## Authoring Contract

- Matrix blocks should be readable when collapsed in Craft.
- Every nested entry type needs a useful title format.
- Media blocks should show a thumbnail in card views.
- Raw HTML blocks should be rare and clearly labeled.
- Calls to action should use the Button block unless a template needs a bespoke link treatment.

## Accessibility Contract

- Text blocks should preserve semantic rich text from authors.
- Heading blocks should not skip levels within the rendered article.
- Image blocks should render native asset alt text first, then title or file-name fallback.
- Gallery and featured-image blocks should keep caption/detail text visually adjacent to the image.
- Raw HTML blocks must be manually reviewed before a page can be treated as accessibility-clean.

## QA Notes

Raw HTML blocks remain a known content risk. The current content QA script reports raw HTML block counts so that escape-hatch usage stays visible.
