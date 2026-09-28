---
title: Places
type: pattern
status: approved
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/category.twig
  - bentilden.com/templates/_places/index.twig
  - bentilden.com/modules/places/Payload.php
  - bentilden.com/modules/places/LocationResolver.php
  - bentilden.com/modules/places/EmbeddedGps.php
  - bentilden.com/modules/places/GpsExif.php
  - bentilden.com-css/src/places.js
  - bentilden.com-css/src/places-geometry.js
dependencies:
  - Alpine.js
  - Alpine focus plugin
  - MapLibre GL JS
  - OpenFreeMap Positron
accessibility:
  reviewed: false
  notes: Named controls, live announcements, keyboard viewer navigation, focus trapping, and a Posts fallback are implemented. Focused Chromium checks are not a full accessibility audit.
owner: Documentation owner
created: 2026-09-27
last_reviewed: 2026-09-28
review_status: active
---

# Places

Places combines a photo map with a synchronized gallery. The first release was accepted on 2026-09-28 and is deployed to production and staging. This page documents that release; further enhancements remain future work.

## Navigation And Views

The existing `photography` category identity and `/photography` URL remain. Visitors see **Places**, which opens Map by default. A compact Map | Posts control sits centered on a horizontal rule aligned with the global desktop-header container. The joined rounded control uses a light Slate 200 active surface and a 1 px gap between segment backgrounds. Both options are real links with `aria-current`.

| Destination | Behavior |
| --- | --- |
| `/photography` | Map + Gallery by default. |
| `/photography?view=posts` | Full chronological Places post stream. |
| Paginated category URLs | Posts by default; pagination links retain `view=posts`. |

Posts includes unlocated content and is independent of the map viewport. Alpine switches views through browser history and preserves the camera, selected place/group, expansion state, and each view's page position for return navigation in the same browser session. A fresh navigation to Places begins with the default Map view.

## Map And Gallery

The interface begins with the view control, without a visible introductory title or summary. Page and gallery headings remain available to screen readers.

On desktop, a sticky map sits left of a natural-height gallery. Both use ordinary page scrolling; there is no inner gallery scroller. Desktop cooperative gestures allow a wheel gesture over the map to scroll the page, with modifier-wheel or pinch gestures used for map zoom. The map stays 16 px beneath the measured fixed header, and its canvas uses a stable height reserve so normal header collapse does not repeatedly resize it. The explorer section contains the sticky map before the footer.

Below the large breakpoint, a compact map sits above the grid. Expand map and Collapse map change its height explicitly; clicking a group does not expand it. All places returns to the compact overview and fits the collection. Normal Mercator constraints fill the map frame, with horizontal world copies and bounds that account for the antimeridian.

Location chips occupy a horizontally scrollable toolbar row left of the map controls. They use `text-xs px-3 py-1.5`; 20 px noninteractive gradients fade clipped edges and disappear at either reached end. The side-by-side zoom buttons are each 44 × 32 px. Provider attribution starts minimized in the lower-right information control; its native toggle and credit links remain available.

| Interaction | Result |
| --- | --- |
| Move the map | The gallery follows the visible area. |
| Choose a place | Fit that place and show its photos. |
| Choose All places | Clear the selection and fit the collection. |
| Click a thumbnail spanning multiple coordinates | Zoom to those coordinates, even if they represent one shared photo. |
| Click several photos at one coordinate | Select that group in the gallery. |
| Click one photo at one coordinate | Open the photo viewer. |

Map thumbnails and gallery tiles are square; gallery images use centered `object-cover` crops. The gallery header displays **N photos** at the right. A selected thumbnail group adds a plain, truncating name at the left with a separate × control immediately beside it, separated by 2 px. The name retains its full text in a title attribute, and the control is named “Remove [name] filter.” Removing that filter restores the current map area's photos. This plain heading keeps selected context visually distinct from the map's location chips.

A deliberate geographic action that changes the photo set brings its start beneath the header if the visitor was already farther down the gallery. The gallery body then fades from 0.5 to 1 opacity over 200 ms; its header stays steady. Reduced motion skips the fade. Unchanged photos, passive layout updates, and state restoration trigger neither the scroll reset nor the fade. Replacing an update cancels its prior animation.

## Photo Viewer And Recovery

A compact row above the photograph holds `n / n`, the post title, **View post →**, and Close. The title truncates while retaining its full text in a title attribute. The link's hover underline runs continuously through the arrow. There is no caption block below the image, leaving more height for the full photograph shown with `object-contain`.

The viewer provides 44 px previous/next buttons with inline SVG chevrons, arrow-key navigation, Escape dismissal, Alpine focus trapping, focus return, and touch-swipe handlers. The chevrons have mirrored 1 px optical offsets. Previous and next wrap around the current photo set; both disable only when fewer than two photos are available. The viewer follows the site-wide [Tab-triggered focus treatment](../accessibility/index.md#focus-appearance). Swipe support in source does not establish physical-device testing.

A missing map resource leaves the photo gallery and Posts available. Without JavaScript, Map links to the server-rendered Posts view. When no photos have usable locations, an empty state explains that locations are being added and directs visitors to Posts.

## Which Photos Appear

The map reads enabled images from the Photos volume that appear in rendered gallery or featured-image blocks of live Places posts. Hidden-from-stream posts, drafts, revisions, disabled blocks, unrelated asset-library images, and preview images alone do not qualify.

| Location source | Public behavior |
| --- | --- |
| Automatic | Use available embedded GPS; otherwise inherit each gallery's location for that use. |
| Embedded GPS | Use the photo's embedded coordinates everywhere. If unavailable, keep the photo off the map. |
| Gallery location | Inherit each gallery's position, ignoring embedded GPS and retained custom coordinates. |
| Custom location | Use the photo's assigned position everywhere. A blank custom position keeps the photo off the map. |

Custom and GPS positions produce one map appearance per asset. Gallery inheritance can produce several: a photo shared by galleries in different places appears at each place, with its post link supplied by that use. Repeated uses at the same place produce one appearance. Separate duplicate asset files remain separate identities.

Markers retain every location appearance. After applying the current place, group, or viewport filter, the gallery and viewer show each asset once. All places, gallery, and thumbnail-stack counts use distinct assets; place counts can overlap when one photo appears in several places. A changed context updates the card's label and post link even if its asset ID stays the same. Opening a marker preserves that appearance's post link in the viewer.

A place name is independent of coordinates; without one, the linked public post title is the fallback. Place identity uses normalized coordinates at nine decimal places. JPEG/TIFF GPS is captured before upload sanitization or read from an existing original by a background scan. The map reads stored results without downloading originals. Replacing a file refreshes or clears that GPS result, and an older queued scan cannot overwrite the replacement.

Older stored files may already have lost GPS during image sanitization. A scan cannot recover removed metadata. Replacing the existing asset's file with its GPS-bearing original allows capture while preserving its identity and gallery references; gallery or custom coordinates are alternatives. See [Photo Locations](../content-model/assets-media.md#photo-locations) for the authoring workflow.

## Implementation And Verification

The surrounding interface uses Twig with inline Tailwind utilities and Alpine behavior. MapLibre GL JS 6.11.2 loads when needed and uses OpenFreeMap Positron. Library styles live in the components cascade layer. The build packages the versioned worker, shared module, and license locally; worker paths must stay in sync on dependency upgrades. A narrow numeric-type guard protects three provider road-shield filters and should be reviewed if the upstream style changes.

Source review, 2026-09-28: the current contract above was checked against `bentilden.com` at `b1cf61ef358dc56cce21402f973740ca5d6ad174` and `bentilden.com-css` at `99af2370c081f34f1309ef473dbf84af18e1e713`, using the metadata sources, global navigation/layout, and location field configuration. This closeout reviews the release's source and records prior verification; it is not a new runtime test run. The cited release is the baseline for these observations; later source changes require separate verification.

Historical verification on 2026-09-27–28 established the following scoped results:

- Local Chromium checks covered desktop and mobile layouts, keyboard/focus behavior, return navigation, cooperative scrolling, stable canvas height during header transitions, chip overflow, reduced-motion result feedback, no-JavaScript Posts, and provider failure. The suite grew from 10 to 22 cases as these refinements landed. Synthetic world-spanning and reused-photo payloads were isolated browser fixtures.
- The completed release passed 19 frontend unit checks, 44 local Places checks, 43 GPS checks including real upload/replacement/temporary-file relocation, and seven authoring-adapter tests. An additional isolated replacement test confirmed that a GPS-bearing original recovers location for a stripped asset without changing its ID.
- All 22 staging Places browser checks passed. Production initially passed 20/22; title and viewer-image cases passed focused reruns after metadata-cache invalidation and image-load rechecking. This is not a later clean full-suite run. Route/font and asset checks also passed.
- Native authoring checks covered all four source choices and map/name visibility, with save/reload tested locally and on staging. Production checks were read-only. Existing Craft image/canvas warnings occurred; one rapid source transition timed out while normal-paced runs passed. Rapid-transition timing remains outside the verified scope.

These checks do not establish a full accessibility, screen-reader, Safari, or physical-touch audit. Those evaluations remain future verification work, separate from the accepted first-release behavior.

## Related Pages

- [Navigation](../components/navigation.md) covers global navigation.
- [Photography](photography.md) covers photographs within posts.
- [Stream Pages](stream-pages.md) covers Posts.
- [Assets & Media](../content-model/assets-media.md) covers shared image metadata and authoring.
