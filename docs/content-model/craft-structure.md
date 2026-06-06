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
owner: Ben Tilden
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Craft Structure

## Sections

| Handle | Type | URI | Template |
| --- | --- | --- | --- |
| `homepage` | Single | `__home__` | `index` |
| `about` | Single | `about` | `_entry.twig` |
| `posts` | Channel | `{slug}` | `_entry.twig` |

## Categories And Navigation

| Handle | Type | Role |
| --- | --- | --- |
| `contentTypes` | Category group | Drives topic pages, article icons, and `bt-article-topic-*` classes. |
| `globalHeader` | Navigation | Primary header and mobile navigation. |
| `globalFooter` | Navigation | Footer links. |

## Matrix Fields

| Field | Entry types | Notes |
| --- | --- | --- |
| `story` | Text, Button, HTML | Main rich-story composition field. |
| `gallery` | Gallery | One gallery block. |
| `featuredImage` | Featured Image | One featured-image block. |
| `ingredients` | Ingredient | Recipe ingredient rows. |
| `steps` | Step | Recipe instruction rows. |

## Layout Fields

| Field | Type | Notes |
| --- | --- | --- |
| `alignment` | Position field | Enables `center`, `left`, and `right`; inactive options include `drop-left`, `drop-right`, and `full`. |
| `contentType` | Categories | Maps entries to content type taxonomy. |
| `hideFromStream` | Lightswitch | Excludes posts from stream pages. |
| `previewImage` | Assets | Used for element thumbnails in Craft. |

## Asset Fields

| Field | Type | Notes |
| --- | --- | --- |
| `mainImage` | Asset, max 1 | Used by recipe pages. |
| `image` | Asset, max 1 | Used by featured image blocks. |
| `images` | Assets | Used by gallery blocks. |
| `caption` | Plain text | Image caption metadata. |
| `details` | Plain text | Micro metadata shown below captions. |
| `optimizedImages` | ImageOptimize | Responsive image source set. |
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

## Audit Notes

- The content model is tightly coupled to template naming conventions.
- Matrix block v2 names (`gallery2`, `featuredImage2`) appear to be current even though display names remain "Gallery" and "Featured Image".
- Asset metadata fields are important design-system inputs because captions, details, and alt behavior depend on them.
