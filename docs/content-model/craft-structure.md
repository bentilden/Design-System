---
title: Craft Structure
type: content_model
status: observed
source_of_truth: observed production code
audience:
  - development
  - content
source:
  - bentilden.com/config/project/sections
  - bentilden.com/config/project/entryTypes
  - bentilden.com/config/project/fields
  - bentilden.com/config/project/imageTransforms
  - bentilden.com/config/project/volumes
  - bentilden.com/docs/craft-authoring-standards.md
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Craft Structure

Craft structure is a design-system input. Entry type controls content shape, Areas of Interest control broad subject identity, and Matrix blocks control article composition.

## Sections

| Handle | Type | URI | Template |
| --- | --- | --- | --- |
| `homepage` | Single | `__home__` | `index` |
| `about` | Single | `about` | `_entry.twig` |
| `posts` | Channel | `{slug}` | `_entry.twig` |

## Taxonomy And Navigation

| Handle | Type | Role |
| --- | --- | --- |
| `areasOfInterest` | Category group | Drives topic pages, article icons, broad navigation, and `bt-article-topic-*` classes. |
| `globalHeader` | Navigation | Primary header and mobile navigation. |
| `globalFooter` | Navigation | Footer links. |

Use Areas of Interest for broad lanes such as Blog, Cooking, Design, and Photography. Use tags for narrower cross-cutting subjects.

## Entry Types

| Entry type | Role |
| --- | --- |
| `story` | Prose-led article composed from Matrix blocks. |
| `gallery` | Image-led entry that can render dense gallery layouts. |
| `featuredImage` | Single-image entry with text alongside media. |
| `recipe` | Cooking entry with intro, story, and recipe-detail views. |
| `about` | Static about page content. |
| `homepage` | Stream-style home page. |
| `text`, `button`, `html`, `heading`, `callout` | Nested Matrix block entries. |
| `ingredient`, `step` | Nested recipe detail entries. |

## Matrix Fields

| Field | Entry types | Notes |
| --- | --- | --- |
| `story` | Text, Button, HTML, Heading, Callout, Featured Image, Gallery | Main article composition field. |
| `gallery` | Gallery | One gallery block for gallery entry type layouts. |
| `featuredImage` | Featured Image | One featured-image block for featured-image entry type layouts. |
| `ingredients` | Ingredient | Recipe ingredient rows. |
| `steps` | Step | Recipe instruction rows, with optional process image. |

## Layout And Classification Fields

| Field | Type | Notes |
| --- | --- | --- |
| `alignment` | Position field | Enables `center`, `left`, and `right`; inactive options include `drop-left`, `drop-right`, and `full`. |
| `areaOfInterest` | Categories | Maps posts to broad subject lane and icon treatment. |
| `hideFromStream` | Lightswitch | Excludes posts from stream pages. |
| `previewImage` | Assets | Optional listing/share override before template fallback logic runs. |

## Asset Fields

| Field | Type | Notes |
| --- | --- | --- |
| `mainImage` | Asset, max 1 | Primary recipe image. |
| `image` | Asset, max 1 | Featured image block image. |
| `images` | Assets | Gallery block images. |
| `image2` | Asset, max 1 | Optional recipe step image in current project config. |
| `caption` | Plain text | Visible image caption metadata. |
| `details` | Plain text | Micro metadata shown below captions. |
| `optimizedImages` | ImageOptimize | Responsive editorial image source set. |
| `optimizedThumbnails` | ImageOptimize | Responsive thumbnail source set. |

## Image Transforms

| Handle | Width | Height | Mode |
| --- | ---: | ---: | --- |
| `largeImage` | 1800 | auto | fit |
| `featuredImage` | 1200 | auto | crop |
| `galleryThumbnails` | 500 | 500 | crop |
| `inStoryLarge` | 700 | auto | fit |
| `inStorySmall` | 300 | auto | fit |
| `avatar` | 250 | 250 | crop |

## Authoring Standards

- Entry type defines shape.
- Area of Interest defines broad subject identity.
- Tags define specific subjects, places, tools, people, events, or series.
- Matrix and nested entries should have useful title formats and card previews.
- Raw HTML blocks should be rare and clearly labeled.
- Images should be uploaded into entry-owned folders and carry native alt text when public.

## Audit Notes

- The content model is tightly coupled to template naming conventions.
- Matrix block v2 names (`gallery2`, `featuredImage2`) appear to be current even though display names remain "Gallery" and "Featured Image".
- Asset metadata fields are important design-system inputs because captions, details, alt behavior, and responsive image output depend on them.
