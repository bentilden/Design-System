---
title: Galleries
type: component
status: observed
source_of_truth: observed production code
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

Galleries support both browsable grids and inline photographs. The same full-image viewer now serves gallery blocks, featured images, [Places Map and Mosaic](../patterns/places.md), and the Posts stream.

Scope: reviewed on 2026-09-28 in website `fcfbf500678f6c156155234846eac75e3c1bb232` and frontend `ddf33f7506eca4513b0755574ccfcb1e35d73ae0`. Production release `20260928174248` contains those verified source files; independent production checks are recorded below. Earlier released viewers and their checks remain historical evidence in [Places](../patterns/places.md#photo-viewer-and-recovery).

## Page Layout

Gallery blocks default to two columns, becoming three at large viewports. Inline galleries and single-image galleries remove those column classes. Both `gallery` block types share one template implementation; both featured-image block types also share one implementation.

Images use the shared responsive-image component with native `srcset`, `sizes`, dimensions, loading, decoding, and priority attributes. Grid galleries use square optimized thumbnails with `sizes="(min-width: 1024px) 28vw, 50vw"`; inline and single-image galleries use full-proportion optimized images with `sizes="90vw"`. The first priority-eligible image may load eagerly; later images remain lazy.

Each photograph is a native link to its full source, with an accessible image description. An ordinary click opens the viewer through Alpine. Modified clicks preserve browser link behavior, and links remain usable without JavaScript. Caption and details continue to appear below inline and featured media when provided.

## Unified Photo Viewer

| Part | Treatment |
| --- | --- |
| Header | Quiet `n / n` count, post title, contextual **View post →**, and an icon-only Close control. The title truncates with its full value available as a title attribute. |
| Photograph | Full proportions fitted into the available area, against a dark opaque backdrop. |
| Desktop navigation | Plain side chevrons with subtle hover surfaces; absent for a single photograph. |
| Mobile navigation | Swipe between photographs, swipe down to dismiss, and pinch/double-tap to zoom; side arrows are hidden. Close remains available. |
| Zoom | A single desktop toggle switches between zoom and fit; mobile uses gestures. |
| Caption | Quiet, left-aligned editorial text below the photograph. No caption area is reserved when both metadata fields are empty. |
| Details | A compact disclosure reveals additional editorial text; the complete metadata region is capped at 35dvh and scrolls when necessary. |

Previous/next navigation wraps through the active collection. The collection retains its context: each post gallery block is independent, a featured-image block opens one photo, Map uses its current filtered collection, and Mosaic follows its color order. The viewer retains the appropriate post association; **View post** is omitted when the visitor is already on that post.

LightGallery supplies transitions, gestures, image rendering, and zoom. Alpine owns the shared shell, collection context, control state, and focus behavior. New interface styling uses inline Tailwind utilities. The same shared component replaces the former separate Places and article interfaces.

## Metadata And Image Delivery

Captions and details come only from their real asset fields, as plain text. Alt text supplies the image description; it is never used as a visible caption fallback. No camera metadata is synthesized from these free-text fields.

Every entry point requests the same `largeImage` rendition, currently 1800 px wide, and its actual transformed dimensions. Existing optimized media remains a fallback. Missing large renditions are generated only when requested by the viewer; rendering a collection does not synchronously process its full archive or enqueue a transform for every photo. Original dimensions remain available for Mosaic layout.

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
