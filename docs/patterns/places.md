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

The existing `photography` category identity and `/photography` URL remain. Visitors see **Places**, which opens Map by default. A compact Map | Posts control sits centered on a Slate 200 horizontal rule aligned with the global desktop-header container. Its Slate 300 outline remains distinct from the quieter line. The joined rounded control uses a reversed selected state: Slate 900 background with white text and no underline. An unselected segment uses Slate 600 text and a Slate 200 hover surface, distinct from the selected Slate 900 state. A 1 px gap separates segment backgrounds. Both options are real links with `aria-current`.

Scoped styling refinement inspected on 2026-09-28 in uncommitted `_places/index.twig` above website `b1cf61e`: only the long switcher line changes to Slate 200. Map/gallery structural borders stay Slate 300 and toolbar dividers stay Slate 200. The stronger global-header outer boundary is documented in [Navigation](../components/navigation.md); the refinement passed 18 navigation checks, computed-style/geometry checks, and scoped release QA including Map and Posts. The full Places suite was not rerun for this styling-only follow-up; its earlier feature checks remain a separate result.

Earlier hover correction, 2026-09-28 (both fills are superseded by the later corrections below): the user reported that the unselected hover and selected states both used Slate 200, making the chosen view ambiguous. The correction changes both links to `hover:bg-slate-100` while preserving `aria-[current=page]:bg-slate-200` and the selected/inactive text colors. Source inspected in uncommitted `_places/index.twig` above website `b1cf61e`. Focused Chromium checks passed all four combinations of 1440/390 px widths and Map/Posts selection: inactive hover remained Slate 100, selected hover remained Slate 200, and `aria-current` stayed correct. Keyboard activation and focus outlines passed at both widths; the implementation agent also inspected the two selected/hover screenshots. Scoped Map/Posts release QA passed, including all 48 font faces. These results are separate from the earlier divider checks; no deployment or physical-touch audit is claimed.

Initial contrast update, 2026-09-28: uncommitted `_places/index.twig` above website `b1cf61e` introduced a selected-only underline on Slate 200; that switcher treatment is superseded below. Small gallery captions, totals, instructions, and empty-state text use Slate 600. Chip counts inherit their parent text color at full opacity; selected chips retain white text on Slate 900. The small group-clear icon remains Slate 500, and decorative borders retain their existing hierarchy. Eighteen focused local Chromium checks passed at 390/1440 px, including Map and Posts with JavaScript disabled: unselected counts measured approximately 7.25:1 at rest and 6.15:1 on hover, selected counts 17.83:1, and captions/totals 7.25:1. Only the selected link remained underlined while its neighbor was hovered; the 2 px underline measured 14.46:1 against Slate 200. Keyboard focus and Enter/Tab switching passed, with no overflow or runtime errors. These focused checks are separate from the earlier hover/divider checks and full Places suite; the implementation agent also inspected the selected/hover crops. See [Accessibility](../accessibility/index.md#color-and-contrast) for the broader verification limits.

Selected-state correction, 2026-09-28: the user rejected the underline treatment in favor of reversed colors. The selected link now uses `aria-[current=page]:bg-slate-900 aria-[current=page]:text-white`, with no underline; that stage retained inactive Slate 600 text and Slate 100 hover. The earlier checks above retain their original scope. Four targeted Chromium cases at 390/1440 px and two no-JavaScript routes passed: both selected views stayed reversed through their own and neighboring hover, with no underline or overflow. Selected text measured 17.83:1 against Slate 900; the selected fill measured 17.04:1 against Slate 50. Keyboard switching/focus passed, the implementation agent inspected both selected-view crops, and scoped Map/Posts release QA passed including all 48 font faces.

Earlier hover-strength follow-up, 2026-09-28: the user found the inactive hover too faint. Both switcher links changed to `hover:bg-slate-300`; selected Slate 900/white, inactive Slate 600 text, and existing Alpine, `aria-current`, and focus behavior remain. This supersedes the Slate 100 hover above. Six focused Chromium state cases at 320/390/1280 px passed across both initial views: inactive hover computed to Slate 300, selected and selected-hover remained Slate 900/white before and after switching, and keyboard focus retained a 2 px solid outline. The implementation agent visually inspected the desktop hover state. Scoped Map/Posts release QA passed, including content, asset/environment, build, font, and browser checks.

Later hover correction, 2026-09-28: the user explicitly chose Slate 200 for inactive Map | Posts hover. Both links now use `hover:bg-slate-200`, superseding the Slate 300 stage above while retaining the reversed Slate 900/white selected state. Source inspected in uncommitted `_places/index.twig` above website `b1cf61e`. Focused local Chromium inspection confirmed Slate 200 hover; scoped Map/Posts release QA passed all stages. The accompanying scroll-alignment checks below are a separate geometry result.

| Destination | Behavior |
| --- | --- |
| `/photography` | Map + Gallery by default. |
| `/photography?view=posts` | Full chronological Places post stream. |
| Paginated category URLs | Posts by default; pagination links retain `view=posts`. |

Posts includes unlocated content and is independent of the map viewport. Alpine switches views through browser history and preserves the camera, selected place/group, expansion state, and each view's page position for return navigation in the same browser session. A fresh navigation to Places begins with the default Map view.

## Map And Gallery

The interface begins with the view control, without a visible introductory title or summary. Page and gallery headings remain available to screen readers.

On desktop, a sticky map sits left of a natural-height gallery. Both use ordinary page scrolling; there is no inner gallery scroller. Desktop cooperative gestures allow a wheel gesture over the map to scroll the page, with modifier-wheel or pinch gestures used for map zoom. The map sticks directly beneath the measured global header, with no added gap. Its desktop canvas fills the remaining viewport height after subtracting the desktop-header reserve and 56 px toolbar; the former 640 px cap is removed. In the compact-header change inspected on 2026-09-28, the desktop reserve starts at 96 px and updates to the measured desktop header; mobile disclosure height cannot carry into it. The header no longer resizes on scroll. The explorer section contains the sticky map before the footer.

Scoped local navigation integration, 2026-09-28: the compact header occupies its natural height in a shared sticky wrapper, replacing the previous fixed header and main-content offset. Source inspected in uncommitted website changes above `b1cf61e` (`_layout.twig`, `_components/global-header*.twig`, `_places/index.twig`) and frontend changes above `f3f709f` (`src/places.js`). All 22 local Places Chromium checks passed for this change, including 185 sampled frames with a stable 96 px header and zero map-canvas mutations. These local source changes are separate from the Places first-release verification below; see [Navigation](../components/navigation.md#review-evidence) for their current status.

Below the large breakpoint, a compact map sits above the grid. Expand map and Collapse map change its height explicitly; clicking a group does not expand it. All places returns to the compact overview and fits the collection. Normal Mercator constraints fill the map frame, with horizontal world copies and bounds that account for the antimeridian.

Location chips occupy a horizontally scrollable toolbar row left of the map controls. The row uses the normal 56 px toolbar height. Inline scrollbar-hiding utilities preserve horizontal scrolling without a classic scrollbar gutter increasing the row’s height. They use `text-xs px-3 py-1.5`; 20 px noninteractive gradients fade clipped edges and disappear at either reached end. The side-by-side zoom buttons are each 44 × 32 px. Provider attribution starts minimized in the lower-right information control; its native toggle and credit links remain available.

Scoped scroll-alignment refinement, 2026-09-28: ordinary Chromium measurements kept the toolbar itself at 56 px; the previous 16 px sticky gap above it shared its pale surface and made the visible area appear 72 px high. The desktop height reserve and 640 px cap also left unused space below the map. Uncommitted `_places/index.twig` above website `b1cf61e` now uses the flush header offset, viewport-filling canvas, and hidden scrollbar described above. Existing Alpine result-scroll positioning in `src/places.js` above frontend `f3f709f` aligns the gallery start with the same header boundary. A forced-classic-scrollbar probe found a separate gutter-related height increase; this is not a reproduction of a native Safari or OS configuration.

All 23 local Places Chromium checks passed for the refinement, with no runtime errors or road-shield warnings. The 56 px toolbar and 96 px header stayed stable across 185 sampled scroll frames, with zero WebGL dimension mutations and stable markers. Short/tall desktop checks placed the map bottom exactly at the viewport bottom, and focused 1280/1440 px samples found zero gaps above or below the pinned map. A synthetic classic-scrollbar fixture proved 15 px native gutter allocation while the actual chip list retained zero gutter; horizontal wheel scrolling and Tab access to the last chip passed. Gallery reset/fade, history, and mobile expansion checks passed. Scoped Map/Posts release QA also passed. The implementation agents inspected the scrolled desktop and scrollbar-fixture crops; these results do not establish Safari or physical-device coverage.

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

The viewer provides 44 px previous/next buttons with inline SVG chevrons, arrow-key navigation, Escape dismissal, Alpine focus trapping, focus return, and touch-swipe handlers. The chevrons have mirrored 1 px optical offsets. Previous and next wrap around the current photo set when it contains multiple photos. Both side buttons are hidden when fewer than two photos are available, with the existing disabled guards retained. The viewer follows the site-wide [Tab-triggered focus treatment](../accessibility/index.md#focus-appearance). Swipe support in source does not establish physical-device testing.

Scoped single-image follow-up, 2026-09-28: initially inspected uncommitted `_places/index.twig` changes above the released website `2e65ab5` add `x-show="canPrevious"` / `x-show="canNext"` to the existing controls. The existing Alpine getters already require more than one photo; no new CSS or separate JavaScript behavior is added. Article lightGallery already applies the same single-item visibility policy. Local Chromium checks at 320/390/1280 px verified a real single-photo set, a multi-photo set, and return to the single-photo set: hidden arrows leave the Tab sequence, arrow keys preserve the single photo/index, and multi-photo buttons remain visible and enabled. Focus trapping/return, Escape, and Close passed. All 23 Places regression checks and scoped Map/Posts release QA passed with no runtime errors or road-shield warnings. The source change is committed in website `e644cc4`, with its browser-QA expectations in frontend `bfafdf2`.

Production verification, 2026-09-28: the deployed change passed the same actual single → multi → single sequence at 320/390/1280 px on `/photography`, including arrow visibility, single-photo key guards, Tab/focus trapping, Escape focus return, and Close. No page errors occurred. The implementation agent visually inspected the 390/1280 px single/multi-photo states without clipping. Production deployment smoke and HTTP-header checks also passed. These are scoped Chromium results, not physical-device or screen-reader coverage.

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
