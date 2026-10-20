---
title: Galleries
type: component
status: observed
source_of_truth: observed dev code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_matrix/gallery.twig
  - bentilden.com/templates/_matrix/gallery2.twig
  - bentilden.com/templates/_matrix/featuredImage.twig
  - bentilden.com/templates/_matrix/featuredImage2.twig
  - bentilden.com/templates/_components/photo-viewer-item.twig
  - bentilden.com/templates/_components/photo-viewer.twig
  - bentilden.com/modules/places/PhotoViewerMedia.php
  - bentilden.com-css/src/photo-viewer.js
  - bentilden.com-css/src/bentilden.js
  - bentilden.com-css/src/bentilden.css
classes:
  - bt-control-gallery2
  - bt-control-image
  - bt-image-file
dependencies:
  - Alpine.js
  - Alpine focus plugin
  - lightGallery
accessibility:
  reviewed: false
  notes: Source supplies native image links, named controls, focus trapping and return, Escape, and reduced motion; physical-device and screen-reader review remains open.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-09-28
review_status: needs audit
---

# Galleries

Local interface-icon standardization, 2026-10-17: the touched icons now use the shared [Lucide 1.5-stroke component](icons.md). The development/staging context fixture preserves previous glyphs for review; this change has not been deployed.

Galleries support both browsable grids and inline photographs. The same full-image viewer now serves gallery blocks, featured images, [Places Map and Mosaic](../patterns/places.md), and the Posts stream.

Scope: reviewed on 2026-09-28 in website `fcfbf500678f6c156155234846eac75e3c1bb232` and frontend `ddf33f7506eca4513b0755574ccfcb1e35d73ae0`. Production release `20260928174248` contains those verified source files; independent production checks are recorded below. Earlier released viewers and their checks remain historical evidence in [Places](../patterns/places.md#photo-viewer-and-recovery).

Desktop zoom follow-up, 2026-09-28: the zoom treatment below was saved in website `b8af3d11a26eb6293591eb5e41fd429d6465cee7` and frontend `3443b68d9fd53629112cff7b96779a23667b45f1`, covering `src/photo-viewer.js` and `_components/photo-viewer.twig`. It replaces the single zoom/fit toggle and is now deployed in website `48f6249f626c0ef78d32a6cdbf0a4a339df6661e` / frontend `6f981f56bdac73fe90b39dceed832bb5a4fadf62`. Runtime template and generated-asset hashes, plus publicly served CSS/JavaScript hashes, match the released source; the local interaction checks below remain separately scoped.

## Page Layout

Scoped local refinement, 2026-10-18: Gallery posts show topic identity, centered headline/date, photos, then story text below 768 px, in both source and visual order. The shared Gallery entry template renders one headline/date and uses responsive grid placement for side-by-side desktop layouts. From 768 px, native `alignment` and `galleryStyle` retain the previous left/right columns, widths, title/body positions, and centered/inline arrangements. Existing viewer behavior and photo-grid column counts are unchanged.

Mobile galleries have one 32 px bottom margin before story text. The former 48 px gallery margin plus 40 px text-column padding no longer accumulate; centered layouts also avoid an extra outer mobile margin. Desktop gallery margins remain 48 px, with the existing additional 32 px for centered layouts.

Local Chromium comparison on Malaga, Kinkaku-ji, and Kyoto in Fall at 768/1024/1440 px found desktop header, gallery, body, and article geometry unchanged within 0.02 px rounding. `qa:gallery-layouts` covers those posts at 320/390/767/768/1024/1440 px; native unsaved tests cover all six alignment/style combinations. Malaga's long title already overflows 10 px at 768 px in the original desktop layout; that baseline is recorded rather than changed by this mobile-order refinement. Sources: locally committed runtime `be1a8a2` and frontend `8f4da56`, `_entry-content/gallery/default.twig`, `scripts/post-header-layout-qa.php`, and `scripts/qa-gallery-layouts-browser.mjs`. No deployment is claimed.

Gallery blocks default to two columns, becoming three at large viewports. Inline galleries and single-image galleries remove those column classes. Both `gallery` block types share one template implementation; both featured-image block types also share one implementation.

Images use the shared responsive-image component with native `srcset`, `sizes`, dimensions, loading, decoding, and priority attributes. Grid galleries use square optimized thumbnails with `sizes="(min-width: 1024px) 28vw, 50vw"`; inline and single-image galleries use full-proportion optimized images with `sizes="90vw"`. The first priority-eligible image may load eagerly; later images remain lazy.

Each photograph is a native link to its full source, with an accessible image description. An ordinary click opens the viewer through Alpine. Modified clicks preserve browser link behavior, and links remain usable without JavaScript. Caption and details continue to appear below inline and featured media when provided.

## Unified Photo Viewer

Production release, 2026-10-20: runtime `f28f89b574fa39b76de3f7a2f72c7668c111c409` and frontend `3aab0118dfbb5edb16197eb7ac3aa7df5aa3ac02` are deployed in release `20261020132221`. All seven changed runtime files match committed hashes. Production passed 18 location-pill browser cases, 21 shared-viewer browser cases (including persistent Details choices), 59 Places PHP integration checks, and server release/asset/header checks. Existing content warnings remain; browser evidence uses Chromium and emulated touch. This supersedes the uncommitted/undeployed status of the October 20 refinements recorded below.

| Part | Treatment |
| --- | --- |
| Header | Quiet `n / n` count, post title, contextual **View post →**, and an icon-only Close control. The title truncates with its full value available as a title attribute. |
| Photograph | Full proportions fitted into the available area, against a dark opaque backdrop. |
| Desktop navigation | Plain side chevrons with subtle hover surfaces; absent for a single photograph. |
| Mobile navigation | Swipe between photographs, swipe down to dismiss, and pinch/double-tap to zoom; side arrows are hidden. Close remains available. |
| Zoom | Desktop has minus, a quiet percentage readout, plus, and **Fit** beside Close. Mobile continues to use gestures. |
| Caption | Quiet, left-aligned editorial text below the photograph. No footer area is reserved when caption, editorial details, and photo information are all absent. |
| Details | One footer disclosure reveals editorial text and photo information together. It appears when either is available, even without a caption. The region scrolls within 45dvh with photo information, otherwise 35dvh. |

Previous/next navigation wraps through the active collection. The collection retains its context: each post gallery block is independent, a featured-image block opens one photo, Map uses its current filtered collection, and Mosaic follows its color order. The viewer retains the appropriate post association; **View post** is omitted when the visitor is already on that post.

LightGallery supplies transitions, gestures, image rendering, and zoom. Alpine owns the shared shell, collection context, control state, and focus behavior. New interface styling uses inline Tailwind utilities. The same shared component replaces the former separate Places and article interfaces.

Header refinement, released 2026-10-20: equal side columns center the title/link against the full viewer. After moving Photo info into the footer Details disclosure, mobile uses equal 64 px columns and desktop uses equal 228 px columns for the counter and remaining controls. Long titles continue to truncate within the center column. Source: `templates/_components/photo-viewer.twig` at runtime `f28f89b`, deployed 2026-10-20.

### Desktop Zoom

Plus and minus multiply or divide the current scale by 1.25, with smooth transitions between the fitted image and its actual size. **Fit** immediately restores the complete photograph to the available space. Each newly selected photograph starts fitted. The percentage describes the rendered image relative to the delivered source: **100%** means one CSS pixel per source pixel, while Fit varies with the photograph and available space. It does not describe the original upload's resolution when the viewer receives a smaller rendition.

The relevant controls appear muted and use guarded `aria-disabled` states at their limits and while the image is unavailable. They remain in the keyboard order so focus is not lost during image changes. The readout uses tabular figures and announces changes politely; loading shows a dash rather than the preceding photo's value. Desktop drag-to-pan remains available while enlarged, and stepped changes preserve the point at the viewport centre within the image's pan bounds. Native mobile swipe, pinch, double-tap, and dismissal behavior remains unchanged.

Local follow-up verification, 2026-09-28: all 18 shared-viewer Chromium checks passed with no runtime errors, including intermediate levels and percentages, limits/focus, native actual-size handoff, panning/resizing, new-photo Fit, all entry points, and existing mobile gestures. A focused mobile run passed five checks. Scoped release QA also passed the build, content/asset checks, and five browser routes with all 48 font faces loaded per route. Desktop screenshots at 1440 and 768 px were visually reviewed; the header remains opaque over an enlarged photo. These results describe local interaction verification before the source deployment recorded above and use emulated touch rather than physical devices.

## Metadata And Image Delivery

Editorial captions and details come only from their real asset fields, as plain text. The Photo info strip below adds a separate allowlisted technical display index. Alt text supplies the image description; it is never used as a visible caption fallback. No camera metadata is synthesized from these free-text fields.

Every entry point requests the same `largeImage` rendition, currently 1800 px wide, and its actual transformed dimensions. Existing optimized media remains a fallback. Missing large renditions are generated only when requested by the viewer; rendering a collection does not synchronously process its full archive or enqueue a transform for every photo. Original dimensions remain available for Mosaic layout.

## Photo Info Caption Strip

Release verification, 2026-10-20 (`c5d9f64` / `20261020134337`): Production verification passed all 19 pill/link browser cases, 64 Places PHP integration checks, 19 Mosaic PHP integration checks, and server release QA including temporary asset write/read/delete plus route/header smoke checks. All 12 changed runtime files match the committed release. Browser coverage includes desktop/mobile grid labels, named-pill selection and viewer links from Map, Mosaic and native posts; touch/device coverage is Chromium emulation. Existing content warnings remain.

Viewer-location refinement, released 2026-10-20: Details uses the same authored name and stable identity as the map pills: the containing gallery block's `placeName`, then asset `placeName`, with whitespace normalized and no post-title fallback. The underlined location links to `photography?view=map&place=<named-place-id>`, which opens Map, fits that named place and selects its pill. Native post galleries pass their own block context; Mosaic follows its primary published post/placement; a viewer opened from a selected map pill retains that pill's name. Missing names omit the location. These are authored names, not reverse-geocoded labels, and naming a photo does not supply missing coordinates. If a link's place has no currently eligible map photos, Map falls back to All places and announces that the place is unavailable. Source: `NamedPlaces.php`, `Payload.php`, `MosaicPhotos.php`, `PlacesVariable.php`, viewer/gallery Twig, and frontend `photo-viewer.js` / `places.js` at runtime `c5d9f64281e4fedfbcb61f1c9a58fea5f0e10b62` / frontend `0b5b3a1a4dc6ce3db8e06e82ff801e01528baf16`, deployed in release `20261020134337`. Local verification passed 19 pill/link browser cases, 21 shared-viewer regressions, scoped Map/Mosaic/post release QA and 61 Places / 19 Mosaic PHP checks. Desktop and 390 px layouts were reviewed; browser gesture coverage uses Chromium emulation.

Released follow-up, 2026-10-20: a single **Details** button beside the caption controls both editorial details and photo information below the image. The header no longer has an info button. The footer control remains available for metadata-only photos, disappears when there is nothing to expand, and reports its state through `aria-expanded` and `aria-controls`. One Alpine disclosure state replaces the separate info state. Details defaults to closed for a new browser; explicit show/hide choices persist in local storage across photos, viewer reopenings, reloads, and navigation between Map, Mosaic and posts. Photos without details do not clear that choice. If storage is blocked, toggling and reopening still retain the choice on the current page. The preference is specific to that browser and site origin. This supersedes the two-toggle interface in the production record below; metadata extraction and delivery are unchanged. Source: viewer Twig/JavaScript at runtime `f28f89b` / frontend `3aab011`, deployed 2026-10-20.

Scoped production implementation, 2026-10-19 (runtime `b18e67a`, frontend `884e87a`): the shared viewer adds an icon-only **Photo info** control beside Close. It toggles a quiet strip below the photograph and existing editorial caption. Camera/lens sit beside compact Aperture, Shutter, Focal and ISO values, with master-image megapixels, dimensions and format. Capture date and an already available public map place label appear below a fine divider. Missing fields disappear; no “unknown” tiles or empty metric slots are added. Actual focal length is not relabeled as a 35mm equivalent.

The strip starts closed on each viewer opening and stays open while moving through that collection. It resets to the selected photo’s values and reserves image space through the existing LightGallery layout path. It does not overlay the photograph. Desktop uses a wrapping horizontal arrangement; mobile stacks camera, settings and file facts, with two setting columns at narrow widths and four from 360px. The information footer is capped at 45dvh and scrolls when necessary; the existing editorial-only footer retains its 35dvh limit. The same native touch, zoom, keyboard and focus behavior remains available. Styling uses inline Tailwind classes, with Alpine controlling the disclosure.

`modules/places/PhotoInfo.php` provides a separate public display index, captured before upload sanitization and versioned with the working file fingerprint. It keeps only camera/lens, exposure settings and calendar capture date. It excludes precise GPS, capture time/offset, embedded identities, captions, keywords, copyright and private archive references. Dimensions/format describe the website’s master file, not the private original or reduced viewer rendition. Existing editorial fields remain separate. Archive Trash/expiry does not erase these published display values; replacing the working image replaces or clears them, and hard asset deletion removes its index. Existing captured current originals can initialize this index without downloading files. No original is fetched during page rendering. Map/Mosaic and post galleries use batch reads for their displayed collections.

Local evidence: 17 public metadata checks, 37 archive/upload checks, 11 media-contract checks and 19 shared-viewer browser checks passed. Scoped release QA passed Map, Mosaic and New Zealand routes with all 48 font faces loaded. Real New Zealand photos were reviewed at desktop, 390px and 320px, including sparse metadata, image fitting and bounded footer scrolling. These observations are local Chromium/emulated touch. Staging release `20261019212713` also passed authenticated checks of real photo metadata, disclosure, desktop zoom, reopening, shared Map/Mosaic entry points and delivered CSS/JavaScript, with no runtime errors. Desktop, 390px and 320px layouts were visually reviewed; short-screen information scrolls within its limit. The same runtime/frontend revisions are deployed to production release `20261019213436`. All 19 shared-viewer browser checks pass there, including client-side full/sparse metadata fixtures, along with server release QA, Map/Mosaic/published-post checks and exact public asset delivery. Existing production photos have no captured camera records at activation, so they show available master-image specs. New uploads can acquire camera metadata; older-original recovery is separate. Physical-phone/Safari acceptance remains pending. Sources: `templates/_components/photo-viewer.twig`, `photo-viewer-item.twig`, `templates/_matrix/gallery.twig`, `modules/places/{PhotoInfo,PhotoViewerMedia,Payload,PlacesVariable,Module}.php`, the additive viewer-info migration, and frontend `src/photo-viewer.js`.

## Accessibility And Verification

Controls have accessible names, and native image links stay in the page's normal keyboard order. The viewer provides Escape dismissal, arrow-key navigation, focus trapping, focus return, scroll locking, reduced-motion handling, and the site's [Tab-triggered focus appearance](../accessibility/index.md#focus-appearance). A loading failure retains a direct photograph link and Close.

Local source review covered the files in this page's metadata. Eleven focused PHP checks passed for the media contract, lazy transforms, metadata separation, and Map/Mosaic agreement; the existing Places and Mosaic PHP integration suites passed 31 and 18 checks. A rendered local post returned nine valid image links in one gallery collection. The final dedicated shared-viewer Chromium suite passed all 15 checks with no JavaScript runtime errors: shared entry points/context, zoom, keyboard wrapping, modal focus and return, empty/long metadata, image/module failures, mobile swipe/pinch/pan/dismissal, two-photo wrapping, reopening, and reduced motion. The existing Places and Mosaic browser suites each passed 23 checks; 29 frontend unit checks also passed. Scoped release QA passed five routes—Map, Mosaic, Posts, Alhambra in September, and Kyoto Guard Tower—with all 48 font faces loaded, along with content/asset checks and the build. Desktop and mobile screenshots were visually reviewed. The final build passed after the gesture-reopen correction. These are local Chromium and emulated-touch results; they do not establish physical-phone, Safari, or screen-reader coverage, and production verification is recorded separately below.

Production verification, 2026-09-28: all 61 interactive Chromium checks passed against release `20260928174248`—15 shared-viewer, 23 Places, and 23 Mosaic—with no runtime errors. Production server release QA and five public route checks passed, including all 48 font faces per route and CSS/main-JavaScript delivery matching the release. Desktop and emulated-mobile viewer screenshots were visually reviewed. These results are separate from the local checks above; physical-phone, Safari, and screen-reader coverage remains open.

The earlier 2026-09-28 caption/detail refinement remains the page-media treatment: Slate 600 captions and 12 px `font-micro` details below inline/featured images. That historical refinement's evidence does not verify the new viewer shell.

## Related Pages

- [Matrix Blocks](matrix-blocks.md) explains block resolution and wrappers.
- [Assets & Media](../content-model/assets-media.md) owns shared image delivery and authoring guidance.
- [Photography](../patterns/photography.md) describes photographic presentation.
- [Places](../patterns/places.md) describes collection and post-link context.
- [Accessibility](../accessibility/index.md) and the [Render Audit](../audit/render-audit.md) identify broader verification needs.

Combined disclosure verification, local 2026-10-20: all 19 shared-viewer Chromium cases passed, including editorial and technical details together, metadata-only/empty photos, bounded footers, image fitting, collection updates, post entry points, focus, desktop zoom and emulated mobile gestures. Desktop 1440 px and mobile 390/320 px metadata layouts were visually reviewed. Map/Mosaic release QA and strict documentation builds passed. These changes remain uncommitted and undeployed; physical-device/Safari coverage is not established by these checks.
