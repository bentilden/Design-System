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
  - bentilden.com/config/project/volumes/photos--93bd7970-e85b-43bd-9316-34ea316396b5.yaml
  - bentilden.com/config/project/volumes/siteImages--5e1f1aaf-69d1-4a05-b29d-dedf8ea97196.yaml
  - bentilden.com/config/project/fields/homeCover--ad9509f2-7cd7-462f-8d73-9513be5eb6ad.yaml
  - bentilden.com/config/project/fields/captionedImageAsset--a8b3744c-5b0e-4c7f-b363-6b2d539954ec.yaml
  - bentilden.com/templates/_partials/entry/captionedImage.twig
  - bentilden.com/modules/content/Images.php
  - bentilden.com/templates/_components/entry-preview-image.twig
  - bentilden.com/templates/_matrix/featuredImage2.twig
  - bentilden.com/templates/_matrix/gallery2.twig
  - bentilden.com/templates/image.twig
  - bentilden.com/scripts/content-qa.php
  - bentilden.com/modules/places/LocationResolver.php
  - bentilden.com/modules/places/Payload.php
  - bentilden.com/modules/places/EmbeddedGps.php
  - bentilden.com/modules/places/GpsExif.php
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-08
review_status: needs audit
---

# Assets & Media

Assets are part of the design system because the site is image-forward and many templates depend on asset metadata, upload paths, responsive transforms, and CDN configuration.

## Volumes

| Volume | Role |
| --- | --- |
| Content Images (`photos`, formerly Photos) | All public webpage-content images, including photographs, design illustrations, and other editorial artwork in posts, galleries, recipes, story blocks, and homepage features. |
| Site Images (`siteImages`) | Website presentation and chrome only, such as signatures, avatars, and default brand imagery. Never use for editorial content. |
| User Photos | Local or private user assets. Do not use for public entry imagery without a specific feature reason. |

Scoped volume-policy update, 2026-10-04: the owner confirmed this content/chrome boundary. Source inspection of the volume definitions and `homeCover` field listed above in clean website `03356500caa9e8fd6908737d955b5ba3691f08fd` confirmed that the homepage cover selector still exposes Photos and Site Images. Choose Photos for editorial covers; narrowing that selector is a separate proposed follow-up. This check did not change asset storage or verify runtime behavior, and the page's overall review date is unchanged.

Scoped local implementation, 2026-10-04: the `codex/ckeditor-captioned-image` feature branch renames the Photos volume's display label to **Content Images** and applies that configuration locally. The `photos` handle, volume UID, filesystem, folders, asset identities/relations, and URLs remain unchanged; this does not move stored files. The source is committed in website `cad9448`, and this observation does not establish a staging or production release. Older observations below use Photos for this same volume. The Homepage cover selector still exposes the content and Site Images volumes; choose Content Images for editorial covers.

Production naming verification, 2026-10-05: website `bdb5b4f` / production release `20261005152908` applies **Content Images**. Fresh native configuration confirms the original volume identity, single-image source, and default folder. Before/after fingerprints preserve all 285 production assets and native-alt rows, relations/URLs, and storage identity. Temporary filesystem write/read/delete probes and public URLs passed; no production CMS assets moved, uploaded, or deleted. See [Captioned Image](../components/captioned-image.md#review-evidence) for the precise source, rendering, and browser limits.

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

Existing entry-owned media fields use folders named from the owning entry URI. The Captioned image field uses the dedicated static path below.

| Field | Upload path |
| --- | --- |
| `previewImage` | `{uri}` |
| `mainImage` | `{uri}` |
| Featured image block `image` | `{owner.uri}` |
| Gallery block `images` | `{owner.uri}` |
| Recipe step `image2` | `{owner.uri}` |
| Captioned image `captionedImageAsset` | Editor/direct-field default: `rich-text/story/`; toolbar library modal: selected Content Images folder |
| `avatar` | `avatars/` |

Use `{owner.uri}` for the existing Matrix media fields and `{uri}` for fields owned directly by the post. CKEditor's editor uploader resolves the selected Assets field path before a nested owner exists, so Captioned image uses `rich-text/story/` rather than a deeper owner URI for that default. The toolbar library modal retains native browsing and uploads into its selected folder. Both paths select and upload only to Content Images.

When one image is related to multiple entries, duplicate the source into each owning entry folder. The current operational preference is clear ownership over de-duplicated shared folders.

## Image Metadata

Public images should have useful native Craft alt text. Templates now use fallback logic, but the fallback is a rendering safety net:

1. Native asset alt text
2. Entry title or asset title
3. File name

Captions and details remain separate editorial metadata. Use them for visible context, location, credit, or descriptive details that benefit all readers.

AI-generated alt text may be used as a starting point when the AI Alt Text plugin is configured, but the durable value is the native Craft alt field. Authors should still review and edit generated text.

Lightbox-visible captions should use caption/details. Alt text should remain focused on accessibility and should not be treated as the visible caption source.

Local [Captioned image](../components/captioned-image.md) placements can override the caption and credit/details or independently hide either. Blank overrides inherit asset metadata when the corresponding hide switch is off. Article, article-viewer, and RSS text resolve the same placement values; the native asset alt text remains the accessibility source, and placement changes do not alter shared asset metadata. Global Places captions/details remain asset-based when deduplicating repeated uses. The separate Hide credit / details switch was added on 2026-10-05.

Scoped viewer update, 2026-09-28: `PhotoViewerMedia.php` in website `fcfbf500678f6c156155234846eac75e3c1bb232` supplies the same plain caption/details fields, 1800 px `largeImage` source, actual source dimensions, and existing optimized fallback to post galleries, featured images, Map, and Mosaic. Missing transforms are requested lazily instead of queued for every photo during page rendering. The [unified viewer](../components/galleries.md#unified-photo-viewer) uses a Details disclosure and reserves no caption area for empty metadata. Eleven media-contract checks and the dedicated 15-check shared-viewer Chromium suite passed locally; [Galleries verification](../components/galleries.md#accessibility-and-verification) records broader regression coverage and its limits. Production verification is recorded with the viewer.

## Photo Locations

The Photos asset layout has a Location tab with a Location source selector (`photoLocationSource`), read-only embedded-GPS status, a custom coordinate picker (`photoLocation`), and a public place name (`placeName`). The picker appears for Custom location; the asset place-name field is hidden for Gallery location. Gallery blocks have `galleryLocation` and `placeName` inline alongside their images. Maps by Ether Creative supplies explicit place search, coordinate inputs, and Clear address. Opening the picker's default camera does not assign a point.

| Location source | Authoring meaning |
| --- | --- |
| Automatic | Use available embedded GPS; otherwise use each gallery's location for that appearance. |
| Embedded GPS | Use GPS everywhere this asset appears. If coordinates are unavailable, the photo stays off the map. |
| Gallery location | Use each gallery's location, ignoring GPS and retained custom coordinates. |
| Custom location | Use one assigned position everywhere this asset appears. A blank custom position keeps it off the map. |

Clearing the picker while Custom location remains selected does not restore inheritance. Choose Gallery location to inherit directly, or Automatic for GPS with gallery fallback. Changing the source preserves stored custom coordinates for later reuse; they are ignored until Custom location is selected. The first-release migration preserves prior individual assignments as Custom location.

The source choice and individual custom position belong to the shared asset. Custom and GPS positions apply everywhere; gallery inheritance belongs to each use. Asset saves are independent of the gallery entry's save/publish lifecycle, so editing a shared photo can affect already-published uses.

The [Places browser](../patterns/places.md#which-photos-appear) preserves each asset's inherited map appearances. A photo shared by galleries at different locations appears at each place, with its post link supplied by that use. Repeated uses at one place count once. The gallery, viewer, and overall photo total count each asset once within their current context; place counts can overlap. Duplicated files are separate assets, and their image contents are not compared. A public place name should reflect whether the coordinates represent a precise shooting position or a general gallery location.

### Embedded GPS And Older Uploads

Extraction supports JPEG and TIFF originals. New uploads and replacements have coordinates captured before Craft sanitizes image metadata. The captured result survives the same upload moving from temporary storage into Photos; background scans can index existing originals. Public map and authoring requests read the stored coordinates/status without fetching those originals. Replacement updates or clears GPS, including when the new file has none; an older queued scan cannot overwrite the replacement.

A background scan can only read metadata that remains in the stored original. Older uploads may already have lost GPS during sanitization, even if the photographer's local original still contains it. Rescanning cannot recover removed coordinates. To recover them, use **Replace file** on the existing asset and select the GPS-bearing original, then choose Automatic or Embedded GPS. This keeps the asset identity and gallery references. Uploading a separate duplicate creates a different asset. Gallery or custom locations remain alternatives when the original is unavailable.

Pending or unavailable GPS makes Automatic use gallery fallback; Embedded GPS stays off the map until coordinates are available. Unsupported formats can use gallery or custom locations. Check the read-only GPS status to distinguish available coordinates, absent metadata, unsupported formats, and an original that could not be checked.

Scoped source review, 2026-09-28: these location rules were checked against website `b1cf61ef358dc56cce21402f973740ca5d6ad174`, including Photos/Gallery layouts and fields under `config/project/`, `modules/mapsauthoring/LocationStatus.php`, `modules/places/`, and the source-preservation migration. That first release is deployed to staging and production. Other content-model sections and the page's overall review date are unchanged.

Historical verification, 2026-09-28: local checks covered real upload, delayed temporary-to-Photos relocation, replacement, deletion, and source conditions; the final GPS integration suite passed 43 checks. CP source visibility and save/reload passed locally and on staging. Production CP checks were read-only; native image/canvas warnings occurred, and rapid-transition timing remains unverified. A separate isolated investigation reproduced historical GPS stripping and confirmed that replacing a stripped asset with its GPS-bearing original restores map lookup without changing its ID. Production was inspected without changes. See [Places verification](../patterns/places.md#implementation-and-verification) for the release's browser coverage and accessibility limits.

## Responsive Images

The Photos volume carries two ImageOptimize fields:

| Field | Use |
| --- | --- |
| `optimizedImages` | Responsive uncropped editorial image variants. |
| `optimizedThumbnails` | Square cropped thumbnail variants for listings and gallery grids. |

Keep these fields attached to Photos while the current templates rely on them.

Render frontend images through the shared `templates/_components/responsive-image.twig` component when possible.

The component owns the common delivery contract:

- `width` and `height` are always emitted when Craft or ImageOptimize can provide dimensions.
- Named Craft transform fallbacks use transform dimensions, not original asset dimensions, so cropped fallbacks do not create layout shift.
- Images are lazy-loaded by default with `decoding="async"`.
- Templates can pass `priority: true` for the likely LCP image; this switches the image to eager loading and emits `fetchpriority="high"`.
- Listing pages should prioritize only the first entry image that is intentionally treated as above-the-fold content. Later stream images should remain lazy.

Do not hand-roll `loading`, `fetchpriority`, `width`, or `height` behavior in feature templates unless the shared component cannot represent the needed behavior.

Scoped source review, 2026-09-28: Places renders its Posts markup alongside Map and passes `useExistingImageUrls` to gallery/featured-image templates. Their lightbox sources use the largest existing optimized image or the original URL, avoiding new `largeImage` transform jobs for hidden markup. The ordinary template path retains its named transform. The map payload likewise uses existing variants without generating transforms during assembly. Checked in `bentilden.com` at `b1cf61ef358dc56cce21402f973740ca5d6ad174`.

## Standalone Image Route

The route `post/<slug>/<asset-id>` renders a single image with image-aware SEO metadata. In the inspected local checkout, `templates/image.twig` looks up an image by asset ID and kind:

```twig
{% set image = craft.assets.kind('image').id(assetID).one() %}
```

This query does not restrict the asset to the Photos volume or require a relation to the post. The route's actual lookup behavior must not be confused with the intended media ownership rules above.

The [open question](../audit/open-questions.md) is whether to restrict the volume and enforce post-asset relations after reviewing legacy assets.

Partial source review, 2026-09-25: the lookup above was checked in `bentilden.com` at commit `e2c8c1bea88d205bdf1e1a26f13c170705bddfc2`, with a clean working tree. This verifies the query in that checkout only; the route was not exercised in a browser, and the other sections of this page were not re-audited.

## Embedded Image Discovery

Scoped local source review, 2026-10-04: `modules/content/Images.php` on `codex/ckeditor-captioned-image` provides one bounded traversal of enabled Story Text entries and their referenced Captioned image entries. Listing previews, Homepage image inheritance, social-image fallback, and content QA use this helper. Explicit Preview Image, recipe Main Image, Featured Image, and Gallery precedence remain ahead of Story fallback; embedded images participate in source order within that fallback. Disabled, trashed, unreferenced, and missing images are excluded.

Places retains its live, visible photography-Post/category rules and public `photos` image-volume check. Volume membership alone does not make an image photography content: design-only Posts remain excluded, while an illustration placed in an eligible photography Post is treated as content from that Post. Unlocated eligible images can appear in Mosaic; Map requires a location allowed by the asset's existing location-source rules. A Captioned image placement does not supply a gallery location or a new placement-location control. These are local observations of website `cad9448`, with staging and production verification pending.

## Current Cleanup Backlog

The asset library works, but content QA can still surface cleanup needs:

- Some Photos assets have no relation rows.
- Photos and Site Images are missing native alt text.

Do not bulk-delete assets from the database. Review them in Craft first, then decide whether to relate, move, archive, or delete each asset and remote file.

## Related Pages

- [Craft Structure](craft-structure.md) defines the asset fields and image transforms.
- [Galleries](../components/galleries.md) and [Recipe Content](../components/recipe-content.md) describe how media appears in components.
- [Captioned Image](../components/captioned-image.md) documents the local nested-image placement and its viewer/feed behavior.
- [Content QA](../operations/content-qa.md) describes checks for missing alt text, relations, and configuration drift.
