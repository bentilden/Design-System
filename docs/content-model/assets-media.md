---
title: Assets & Media
type: content_model
status: observed
source_of_truth: observed production code
audience:
  - development
  - content
  - governance
source:
  - bentilden.com/docs/assets.md
  - bentilden.com/templates/_components/entry-preview-image.twig
  - bentilden.com/templates/_matrix/featuredImage2.twig
  - bentilden.com/templates/_matrix/gallery2.twig
  - bentilden.com/templates/image.twig
  - bentilden.com/scripts/content-qa.php
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-08
review_status: needs cleanup
---

# Assets & Media

Assets are part of the design system because the site is image-forward and many templates depend on asset metadata, upload paths, responsive transforms, and CDN configuration.

## Volumes

| Volume | Role |
| --- | --- |
| Photos | Public editorial media for posts, galleries, recipes, and story blocks. |
| Site Images | Public reusable site-level assets, including avatars and brand/social images. |
| User Photos | Local or private user assets. Do not use for public entry imagery without a specific feature reason. |

Avoid adding more public volumes unless the authoring boundary is genuinely different.

## Environment Contract

The target deployment model is one public asset bucket/CDN per environment.

| Environment | Asset contract |
| --- | --- |
| Production | Production bucket and production CDN URL. |
| Staging | Staging bucket and staging CDN URL. |
| Dev | Dev bucket and dev CDN URL. |

Use environment variables for the bucket, CDN root, API credentials, endpoint, region, and volume subfolders:

- `ASSETS_BUCKET`
- `ASSETS_BASE_URL`
- `PHOTOS_FOLDER`
- `SITE_IMAGES_FOLDER`
- `SPACES_API_KEY`
- `SPACES_SECRET`
- `SPACES_ENDPOINT`
- `SPACES_REGION`

Templates and content should use Craft asset fields and `asset.getUrl()`. Do not hard-code CDN URLs in entries, Twig templates, or documentation examples.

## Upload Paths

Entry-related media should upload into folders named from the owning entry URI.

| Field | Upload path |
| --- | --- |
| `previewImage` | `{uri}` |
| `mainImage` | `{uri}` |
| Featured image block `image` | `{owner.uri}` |
| Gallery block `images` | `{owner.uri}` |
| Recipe step `image2` | `{owner.uri}` |
| `avatar` | `avatars/` |

Use `{owner.uri}` for nested entries and `{uri}` for fields owned directly by the post.

When one image is related to multiple entries, duplicate the source into each owning entry folder. The current operational preference is clear ownership over de-duplicated shared folders.

## Image Metadata

Public images should have useful native Craft alt text. Templates now use fallback logic, but the fallback is a rendering safety net:

1. Native asset alt text
2. Entry title or asset title
3. File name

Captions and details remain separate editorial metadata. Use them for visible context, location, credit, or descriptive details that benefit all readers.

AI-generated alt text may be used as a starting point when the AI Alt Text plugin is configured, but the durable value is the native Craft alt field. Authors should still review and edit generated text.

Lightbox-visible captions should use caption/details. Alt text should remain focused on accessibility and should not be treated as the visible caption source.

## Responsive Images

The Photos volume carries two ImageOptimize fields:

| Field | Use |
| --- | --- |
| `optimizedImages` | Responsive uncropped editorial image variants. |
| `optimizedThumbnails` | Square cropped thumbnail variants for listings and gallery grids. |

Keep these fields attached to Photos while the current templates rely on them.

## Standalone Image Route

The route `post/<slug>/<asset-id>` renders a single image with image-aware SEO metadata. It currently limits lookups to image assets in the Photos volume.

Remaining decision: whether the route should enforce that the requested asset is related to the post. The source notes intentionally postpone that until legacy assets are reviewed.

## Current Cleanup Backlog

The asset library works, but content QA can still surface cleanup needs:

- Some Photos assets have no relation rows.
- Photos and Site Images are missing native alt text.

Do not bulk-delete assets from the database. Review them in Craft first, then decide whether to relate, move, archive, or delete each asset and remote file.
