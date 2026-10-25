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
  - bentilden.com/modules/photoarchive/MetadataPanel.php
  - bentilden.com/modules/photoarchive/Archive.php
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
| Legacy recipe step `image2` | `{owner.uri}` |
| Captioned image `captionedImageAsset` | Editor/direct-field default: `rich-text/story/`; toolbar library modal: selected Content Images folder |
| `avatar` | `avatars/` |

Use `{owner.uri}` for the existing Matrix media fields and `{uri}` for fields owned directly by the post. CKEditor's editor uploader resolves the selected Assets field path before a nested owner exists, so Captioned image uses `rich-text/story/` rather than a deeper owner URI for that default. The toolbar library modal retains native browsing and uploads into its selected folder. Both paths select and upload only to Content Images.

When one image is related to multiple entries, duplicate the source into each owning entry folder. The current operational preference is clear ownership over de-duplicated shared folders.

## Image Metadata

Historical authoring checkpoint, 2026-10-19: runtime `4214e23` adds a native **Photo metadata** tab to Content Images. It shows read-only date/location, camera and authorship details from newly archived uploads, separately from existing editable captions, details, alt text and location controls. Existing files without an archived original say so explicitly. Administrators have original-download and retained-version controls; other editors do not. The CP reports independent backup status, including the last successful run in the archive browser and whether an asset is awaiting backup; local cloud backup is now active. A stale backup on intermittent dev reports waiting for catch-up without a missed-run alert; actual failures remain visible. Staging verification on 2026-10-19 at runtime `4214e23` covered metadata rendering, original-download authorization and retained versions; production rollout had not occurred at that checkpoint. The archive integration suite passed 34 checks and CP rendering/access checks passed 13; the latter uses a web request context, not an interactive visual CP review. Existing public image/metadata presentation is unchanged.

Public images should have useful native Craft alt text. Templates now use fallback logic, but the fallback is a rendering safety net:

1. Native asset alt text
2. Entry title or asset title
3. File name

Captions and details remain separate editorial metadata. Use them for visible context, location, credit, or descriptive details that benefit all readers.

AI-generated alt text may be used as a starting point when the AI Alt Text plugin is configured, but the durable value is the native Craft alt field. Authors should still review and edit generated text.

Lightbox-visible captions should use caption/details. Alt text should remain focused on accessibility and should not be treated as the visible caption source.

Local [Captioned image](../components/captioned-image.md) placements can override the caption and credit/details or independently hide either. Blank overrides inherit asset metadata when the corresponding hide switch is off. Article, article-viewer, and RSS text resolve the same placement values; the native asset alt text remains the accessibility source, and placement changes do not alter shared asset metadata. Global Places captions/details remain asset-based when deduplicating repeated uses. The separate Hide credit / details switch was added on 2026-10-05.

Scoped viewer update, 2026-09-28: `PhotoViewerMedia.php` in website `fcfbf500678f6c156155234846eac75e3c1bb232` supplies the same plain caption/details fields, 1800 px `largeImage` source, actual source dimensions, and existing optimized fallback to post galleries, featured images, Map, and Mosaic. Missing transforms are requested lazily instead of queued for every photo during page rendering. The [unified viewer](../components/galleries.md#unified-photo-viewer) uses a Details disclosure and reserves no caption area for empty metadata. Eleven media-contract checks and the dedicated 15-check shared-viewer Chromium suite passed locally; [Galleries verification](../components/galleries.md#accessibility-and-verification) records broader regression coverage and its limits. Production verification is recorded with the viewer.

Scoped lifecycle update, 2026-10-19: website `c3977f9` adds administrator-only **Delete original…** controls in Photo originals, a separate confirmation form, and a recovery download with a visible UTC deadline. Deleting an archive version leaves the website image and other versions unchanged. Recovery lasts 30 days; physical backup removal runs in scheduled maintenance afterward. The local CP request-context suite passes 19 checks, including administrator permissions, CSRF, POST-only deletion and explicit confirmation. Staging release `20261019182836` passed the same 19 request-context checks and a 14-check real-cloud lifecycle rehearsal. Production rollout had not occurred at that checkpoint.

Scoped recovery-panel update, 2026-10-19: website `df60e77` keeps the current uploaded version’s metadata visible during its 30-day recovery window. The asset panel shows archive deletion/pending status, a readable UTC deadline and an administrator-only **Download recovery copy** button. It hides metadata and that button at expiry, without falling back to older versions. An expandable native explanation distinguishes the website image, private uploaded original and independent backup; recovery download does not restore the archive. Local CP request-context QA passes 31 checks including deadline/purge and role-specific states. Staging release `20261019202623` also passed seven read-only rendering checks for a deleted asset; interactive visual acceptance remains pending. Production rollout had not occurred at that checkpoint.


Scoped Trash revision, 2026-10-19 (runtime `cc13ba7`, staging release `20261019205130`): the owner selected **30-day Trash and Undo** with independent backups retained for the same window. **Photo Originals** uses Craft’s native archive icon and separate Originals/Trash views. The metadata tab uses a native status pane, clear UTC restore deadline, grouped read-only metadata with aligned columns, primary Restore action and secondary Download/version actions. An expandable explanation distinguishes the website image, uploaded original, backup and Trash. Restore updates the panel without submitting the asset form or losing unsaved edits. Restoring an older archive version never replaces a newer uploaded image. These conventions supersede the earlier Delete original/recovery-download-only interface above. Non-admin/static rendering remains read-only; recovery actions and metadata end at the deadline. Native CP styling/action bundles are intentionally separate from the website’s Alpine/Tailwind frontend. Forty local CP/controller checks, seven desktop/narrow synthetic browser interaction checks, and eleven read-only deployed CP checks pass. Eighteen isolated cloud lifecycle checks pass on staging. The owner subsequently confirmed Restore works; production rollout had not occurred at that checkpoint.

Scoped production authoring update, 2026-10-20: the archive and Trash interface from runtime `b18e67a` is deployed, and private new-upload capture plus daily independent backups are enabled. **Photo Originals** separates retained versions from 30-day Trash. **Restore original** cancels the Trash deadline; **Download original** leaves state unchanged. The Photo metadata tab keeps the current upload’s read-only details visible during Trash and identifies images without an archived original. Archive expiry does not remove the public viewer’s allowlisted technical index. Existing working images and manually authored metadata remain separate; older originals are not recovered automatically. Schema/layout, healthy backup status and retention behavior have scoped verification, including prior owner Restore acceptance on staging; this activation session did not repeat an interactive production CP walkthrough. Native Craft interface styles and protected server-side actions remain separate from the website’s Alpine/Tailwind presentation.

## Photo Locations

Released revision, 2026-10-20 (runtime `e00d55e`): [hierarchical Locations](../patterns/places.md#local-hierarchical-locations-revision) replace free-text place names with one optional `photoPlace` relation. The photo's explicit relation wins everywhere; blank inherits per gallery use. Map position has three choices: Automatic (GPS then Location point), Use location’s map position, and Set custom position. A missing custom point produces validation feedback. The read-only status describes the saved source and available GPS. Legacy GPS-only choices require migration review; they do not silently gain fallback. The following four-mode guidance is retained as the superseded baseline.

Optional-label addition, 2026-10-20 (runtime `73e495d`): Photos have a single-line **Photo location label** (`photoLocationLabel`) immediately beneath the related Location selector. It is optional and available in every map-position mode. Blank uses the assigned/inherited Location name; a value describes that asset everywhere it appears. It never changes coordinates, Location identity, hierarchy or pills. Existing `placeName` remains hidden legacy storage and is not reused. See [Places](../patterns/places.md#local-hierarchical-locations-revision) for individual/cluster labels and viewer presentation.

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

Scoped viewer-information trial, 2026-10-19 (runtime `b18e67a`, frontend `884e87a`, verified on staging and production release `20261019213436`): the owner selected the Caption strip direction. A separate display index retains selected technical values independently of private archive Trash, updates on replacement and clears when the working asset is hard-deleted. It contains camera/lens, exposure and a calendar capture date; image dimensions/format come from the working master. It does not publish raw EXIF, exact GPS/time, embedded identities or private storage references. This supersedes the earlier statement that no camera metadata is supplied to the public viewer for this deployed release. Existing production photos without captured metadata retain only available master-image specifications; enabling new-upload capture does not backfill older originals. See [Photo info caption strip](../components/galleries.md#photo-info-caption-strip) for behavior, sources and verification. Existing manual location-source and editorial-caption rules remain intact.

Scoped dev addition, 2026-10-20: Recipe Step Instructions (`text2`, exposed as `text`) now reuse native Captioned image placements and the shared renderer/viewer. Multiple images can appear between paragraphs; new inline uploads use `rich-text/recipe-steps/`. The old `image2` relation remains a trailing-image fallback. Recipe/Places eligibility and existing preview-image precedence are unchanged. See [Recipe Content](../components/recipe-content.md#step-anatomy-and-authoring).

## Related Pages

- [Craft Structure](craft-structure.md) defines the asset fields and image transforms.
- [Galleries](../components/galleries.md) and [Recipe Content](../components/recipe-content.md) describe how media appears in components.
- [Captioned Image](../components/captioned-image.md) documents the local nested-image placement and its viewer/feed behavior.
- [Content QA](../operations/content-qa.md) describes checks for missing alt text, relations, and configuration drift.

## Recovered Source Metadata

Scoped production update, 2026-10-24, runtime `bc73a56`: verified recovered camera/edit sources can fill missing public camera/lens, exposure and calendar-date values. Existing current-image values win; the camera source fills gaps before the recovered edit. Recovered GPS fills a missing GPS index entry while the existing Automatic/custom/Location choices continue to decide the public map position. Author-entered fields and working image files remain unchanged. Publication is performed during reviewed recovery, not on visitor requests; private originals remain protected. The public display indexes retain their existing replacement and archive-retention behavior.

Pilot completion, 2026-10-24, runtime `24af9e1`: a reviewed single source may use the **Recovered photo source** role without claiming exact historical-upload bytes or a proven camera/edit pair. It requires explicit batch authorization and native same-photo verification bound to its SHA256; camera/edit pair rules remain strict. Existing current-image values win, followed by verified camera source, generic recovered source, then recovered edit.

All 42 production pilot photos now have camera/date/settings in Map and Mosaic; 40 use embedded GPS and two retain existing gallery locations. The public [Kyoto viewer](https://www.bentilden.com/kyoto-in-fall) and [Alhambra viewer](https://www.bentilden.com/alhambra-in-september) were inspected at desktop size with Details expanded. This is scoped data/behavior verification, not a new responsive interface review. Sources: runtime `modules/photoarchive/{Recovery,RecoveredMetadata}.php`, `modules/photoarchive/console/RecoveryController.php`, and `modules/places/{PhotoInfo,EmbeddedGps,LocationResolver}.php`. No template/frontend source or public metadata allowlist changed.
