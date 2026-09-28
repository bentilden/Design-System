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
  - bentilden.com/templates/_places/mosaic.twig
  - bentilden.com/templates/_places/view-navigation.twig
  - bentilden.com/templates/_components/global-header.twig
  - bentilden.com/modules/places/Payload.php
  - bentilden.com/modules/places/MosaicPhotos.php
  - bentilden.com/modules/places/PhotoColors.php
  - bentilden.com/modules/places/ColorProfile.php
  - bentilden.com/modules/places/LocationResolver.php
  - bentilden.com/modules/places/EmbeddedGps.php
  - bentilden.com/modules/places/GpsExif.php
  - bentilden.com-css/src/places.js
  - bentilden.com-css/src/places-geometry.js
  - bentilden.com-css/src/mosaic-layout.js
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

Places combines a photo map with a synchronized gallery. The first release was accepted on 2026-09-28 and is deployed to production and staging. Later scoped changes below distinguish local trials from verified releases.

Local Mosaic integration, 2026-09-28: the owner selected a third color-ordered view with both square and justified layouts. It extends the header control to **Map | Mosaic | Posts** while retaining Map as the default. The [Mosaic section](#mosaic) describes this local, undeployed addition; the historical two-view verification below retains its original scope.

## Navigation And Views

The existing `photography` category identity and `/photography` URL remain. Visitors see **Places**, which opens Map by default. The local header-switcher trial places the compact Map | Posts control at the center of the global header’s lower rule, keeping it available while either view scrolls. The separate in-page switcher row and long rule are removed. A Slate 50 surround clears the header rule behind the control; its outline remains Slate 300. The joined rounded control uses a reversed selected state: Slate 900 background with white text and no underline. An unselected segment uses Slate 600 text and a Slate 200 hover surface, distinct from the selected Slate 900 state. A 1 px gap separates segment backgrounds. Both options are real links with `aria-current`.

Scoped header-switcher trial, 2026-09-28: uncommitted source above website `e644cc4` / frontend `bfafdf2` shares `_places/view-navigation.twig` between the live Alpine control and a `noscript` fallback. Alpine teleports the live control from the Places scope into the shared sticky header. The unchanged 96/80 px identity bars gain 24/32 px of lower clearance on Places, for 120/112 px occupied stacks at desktop/mobile sizes. The later slimmer-mobile refinement retains actual 44 px anchors below `md` around 32 px colored fills and a separate 38 px visual shell; the decorative shell ignores pointer input. From `md`, anchors/fills remain 28 px high and the shell is 34 px. Opening mobile Menu hides the live control and its clearance. Without JavaScript, ordinary view links sit on the expanded header’s lower rule. A Places-only inset moves mobile identity-row contents up 8 px so their link targets do not overlap the switcher.

Initial header-switcher verification, before the slimmer mobile shell and shared desktop toolbar: 25 navigation and 23 Places Chromium checks passed, with no runtime errors or road-shield warnings. Header/control bounds, persistent placement, mobile hide/show and breakpoint reset, keyboard/focus, view history, and no-JavaScript navigation passed. The desktop map met the viewport bottom at 650/1100 px heights; 184 sampled scroll frames retained a 96 px identity bar, 120 px stack, 56 px toolbar, and zero canvas dimension mutations. A subsequent inline focus-stacking correction preserved the mobile signature/Menu outlines above the control surround; the implementation agent visually checked both at 320 px. Scoped Map/Posts release QA passed after that styling change. Desktop/mobile screenshots were also inspected. An existing 23 px Posts title overflow at 768 px remains outside the passing header/control bounds; this is not a whole-page overflow pass. These local checks do not establish Safari, physical-device, or screen-reader coverage. The trial remains uncommitted and undeployed; the shared-toolbar follow-up is verified separately below.

Scoped styling refinement inspected on 2026-09-28 in uncommitted `_places/index.twig` above website `b1cf61e`: only the long switcher line changes to Slate 200. Map/gallery structural borders stay Slate 300 and toolbar dividers stay Slate 200. The stronger global-header outer boundary is documented in [Navigation](../components/navigation.md); the refinement passed 18 navigation checks, computed-style/geometry checks, and scoped release QA including Map and Posts. The full Places suite was not rerun for this styling-only follow-up; its earlier feature checks remain a separate result.

Earlier hover correction, 2026-09-28 (both fills are superseded by the later corrections below): the user reported that the unselected hover and selected states both used Slate 200, making the chosen view ambiguous. The correction changes both links to `hover:bg-slate-100` while preserving `aria-[current=page]:bg-slate-200` and the selected/inactive text colors. Source inspected in uncommitted `_places/index.twig` above website `b1cf61e`. Focused Chromium checks passed all four combinations of 1440/390 px widths and Map/Posts selection: inactive hover remained Slate 100, selected hover remained Slate 200, and `aria-current` stayed correct. Keyboard activation and focus outlines passed at both widths; the implementation agent also inspected the two selected/hover screenshots. Scoped Map/Posts release QA passed, including all 48 font faces. These results are separate from the earlier divider checks; no deployment or physical-touch audit is claimed.

Initial contrast update, 2026-09-28: uncommitted `_places/index.twig` above website `b1cf61e` introduced a selected-only underline on Slate 200; that switcher treatment is superseded below. Small gallery captions, totals, instructions, and empty-state text use Slate 600. Chip counts inherit their parent text color at full opacity; selected chips retain white text on Slate 900. The small group-clear icon remains Slate 500, and decorative borders retain their existing hierarchy. Eighteen focused local Chromium checks passed at 390/1440 px, including Map and Posts with JavaScript disabled: unselected counts measured approximately 7.25:1 at rest and 6.15:1 on hover, selected counts 17.83:1, and captions/totals 7.25:1. Only the selected link remained underlined while its neighbor was hovered; the 2 px underline measured 14.46:1 against Slate 200. Keyboard focus and Enter/Tab switching passed, with no overflow or runtime errors. These focused checks are separate from the earlier hover/divider checks and full Places suite; the implementation agent also inspected the selected/hover crops. See [Accessibility](../accessibility/index.md#color-and-contrast) for the broader verification limits.

Selected-state correction, 2026-09-28: the user rejected the underline treatment in favor of reversed colors. The selected link now uses `aria-[current=page]:bg-slate-900 aria-[current=page]:text-white`, with no underline; that stage retained inactive Slate 600 text and Slate 100 hover. The earlier checks above retain their original scope. Four targeted Chromium cases at 390/1440 px and two no-JavaScript routes passed: both selected views stayed reversed through their own and neighboring hover, with no underline or overflow. Selected text measured 17.83:1 against Slate 900; the selected fill measured 17.04:1 against Slate 50. Keyboard switching/focus passed, the implementation agent inspected both selected-view crops, and scoped Map/Posts release QA passed including all 48 font faces.

Earlier hover-strength follow-up, 2026-09-28: the user found the inactive hover too faint. Both switcher links changed to `hover:bg-slate-300`; selected Slate 900/white, inactive Slate 600 text, and existing Alpine, `aria-current`, and focus behavior remain. This supersedes the Slate 100 hover above. Six focused Chromium state cases at 320/390/1280 px passed across both initial views: inactive hover computed to Slate 300, selected and selected-hover remained Slate 900/white before and after switching, and keyboard focus retained a 2 px solid outline. The implementation agent visually inspected the desktop hover state. Scoped Map/Posts release QA passed, including content, asset/environment, build, font, and browser checks.

Later hover correction, 2026-09-28: the user explicitly chose Slate 200 for inactive Map | Posts hover. Both links now use `hover:bg-slate-200`, superseding the Slate 300 stage above while retaining the reversed Slate 900/white selected state. Source inspected in uncommitted `_places/index.twig` above website `b1cf61e`. Focused local Chromium inspection confirmed Slate 200 hover; scoped Map/Posts release QA passed all stages. The accompanying scroll-alignment checks below are a separate geometry result.

| Destination | Behavior |
| --- | --- |
| `/photography` | Map + Gallery by default. |
| `/photography?view=mosaic` | Color-ordered thumbnails; local Mosaic integration, not yet deployed. |
| `/photography?view=posts` | Full chronological Places post stream. |
| Paginated category URLs | Posts by default; pagination links retain `view=posts`. |

Posts includes unlocated content and is independent of the map viewport. Alpine switches views through browser history and preserves the camera, selected place/group, expansion state, and each view's page position for return navigation in the same browser session. A fresh navigation to Places begins with the default Map view.

## Map And Gallery

The view control belongs to the header boundary; the page does not repeat it or add a visible introductory title or summary. Page and gallery headings remain available to screen readers.

From `lg` (1024 px), a sticky map sits left of a natural-height gallery. Both use ordinary page scrolling; there is no inner gallery scroller. A shared 56 px toolbar spans both columns: chips and zoom controls align over the map, while group context and the count align over the gallery. Its two cells stick at the same measured header-stack boundary, initially 120 px. There is no extra top rule or vertical divider inside the toolbar; its continuous bottom rule is Slate 200. The Slate 300 vertical divider begins below it between the map and gallery.

The map sticks below that shared toolbar, initially at 176 px, and its canvas fills the viewport below the 120 px header reserve and 56 px toolbar. The former 640 px cap remains removed. The reserve tracks the whole `[data-site-header-stack]`; mobile disclosure height cannot carry into it. The identity bars do not resize on scroll, and the explorer section contains the sticky elements before the footer. Desktop cooperative gestures allow a wheel gesture over the map to scroll the page, with modifier-wheel or pinch gestures used for map zoom.

Scoped shared-toolbar and slimmer-mobile follow-up, 2026-09-28: source inspection confirms four explorer children in mobile reading order—map controls, map, gallery summary, gallery—repositioned by the desktop grid. Controls are not duplicated. The map controls and gallery summary form the desktop toolbar through two aligned sticky cells. New styling uses inline Tailwind utilities; the existing Alpine result-scroll logic accounts for the toolbar.

Separate local verification passed 27 navigation and 23 Places Chromium checks on the first run, with no runtime errors or road-shield warnings. At 320/390 px, the 38 px mobile shell retained real 44 px targets, 32 px fills, edge-click activation, settled Slate 200 hover and Slate 900/white selection, and keyboard focus. Desktop toolbar cells remained at 120–176 px with the map beneath them, including a reachable group-clear control during deep gallery browsing. Borders, footer release, history, result-scroll behavior, and no-JavaScript view/pagination links passed. Across 183 sampled scroll frames, the stack/toolbar stayed 120/56 px with zero canvas mutations. Scoped Map/Posts release QA passed. The implementation agent inspected mobile/desktop and scrolled desktop screenshots; this remains local, uncommitted, and undeployed, with the earlier coverage limitations unchanged.

Scoped local navigation integration, 2026-09-28: the compact header occupies its natural height in a shared sticky wrapper, replacing the previous fixed header and main-content offset. Source inspected in uncommitted website changes above `b1cf61e` (`_layout.twig`, `_components/global-header*.twig`, `_places/index.twig`) and frontend changes above `f3f709f` (`src/places.js`). All 22 local Places Chromium checks passed for this change, including 185 sampled frames with a stable 96 px header and zero map-canvas mutations. These local source changes are separate from the Places first-release verification below; see [Navigation](../components/navigation.md#review-evidence) for their current status.

Below the large breakpoint, a compact nonsticky map sits above the grid, with map controls and gallery summary in separate rows. Expand map and Collapse map change its height explicitly; clicking a group does not expand it. All places returns to the compact overview and fits the collection. Normal Mercator constraints fill the map frame, with horizontal world copies and bounds that account for the antimeridian.

Location chips occupy a horizontally scrollable toolbar row left of the map controls. In the local visibility refinement, each place chip remains only while an associated thumbnail frame intersects the map viewport; partial thumbnails count, and visible clusters represent all member places. All places remains available. Chip order and counts stay unchanged, independently of gallery filtering. Camera movement, regrouping, resize, and history restoration refresh the visible set. Before the map is ready or on map failure, all place chips remain available. When a focused chip disappears, focus returns to All places; other focus is preserved. This local behavior is recorded in frontend `71d65e8` and website `4e65c7e`; all ten focused chip cases, 23 Places browser regressions, and scoped Map/Mosaic release checks passed with no runtime errors or road-shield warnings. It is not deployed. The row uses the normal 56 px toolbar height. Inline scrollbar-hiding utilities preserve horizontal scrolling without a classic scrollbar gutter increasing the row’s height. Each chip, including All places, remains one 30 px-high button with a 1 px vertical separator between its name and tabular count. Padding belongs to the stretched spans (`pl-[13px] pr-2.5 py-1.5` for the name, `pl-2 pr-[11px] py-1.5` for the count), letting the divider fill the 28 px interior between outer borders. This spacing adjustment in website `91f5202` was verified locally at 390/1440 px on 2026-09-28. The divider is Slate 300 normally and white at 30% opacity when selected. This local refinement in website `00f0633` passed focused 320/390/1440 px geometry, accessibility, keyboard, overflow, and runtime checks plus scoped Map release QA. The 20 px noninteractive gradients fade clipped edges and disappear at either reached end. The side-by-side zoom buttons are each 44 × 32 px. The local 2026-09-28 spacing follow-ups give the first chip and photo count matching 20 px gaps from the outer desktop toolbar edges while keeping the zoom-control group flush with the map column’s right edge; mobile/tablet padding remains unchanged. Provider attribution starts minimized in the lower-right information control; its native toggle and credit links remain available.

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

Map thumbnails and gallery tiles are square; gallery images use centered `object-cover` crops. The gallery summary displays **N photos** at the right, in the shared toolbar on desktop or its separate row below the map on mobile. A selected thumbnail group adds a plain, truncating name at the left with a separate × control immediately beside it, separated by 2 px. The name retains its full text in a title attribute, and the control is named “Remove [name] filter.” Removing that filter restores the current map area's photos. This plain heading keeps selected context visually distinct from the map's location chips.

A deliberate geographic action that changes the photo set brings its start into view if the visitor was already farther down the gallery. On desktop, the gallery begins below the header stack and shared 56 px toolbar; below `lg`, the separate gallery summary is brought beneath the header so its context remains visible. The gallery body then fades from 0.5 to 1 opacity over 200 ms; its summary stays steady. Reduced motion skips the fade. Unchanged photos, passive layout updates, and state restoration trigger neither the scroll reset nor the fade. Replacing an update cancels its prior animation.

## Photo Viewer And Recovery

A compact row above the photograph holds `n / n`, the post title, **View post →**, and Close. The title truncates while retaining its full text in a title attribute. The link's hover underline runs continuously through the arrow. There is no caption block below the image, leaving more height for the full photograph shown with `object-contain`.

The viewer provides 44 px previous/next buttons with inline SVG chevrons, arrow-key navigation, Escape dismissal, Alpine focus trapping, focus return, and touch-swipe handlers. The chevrons have mirrored 1 px optical offsets. Previous and next wrap around the current photo set when it contains multiple photos. Both side buttons are hidden when fewer than two photos are available, with the existing disabled guards retained. The viewer follows the site-wide [Tab-triggered focus treatment](../accessibility/index.md#focus-appearance). Swipe support in source does not establish physical-device testing.

Scoped single-image follow-up, 2026-09-28: initially inspected uncommitted `_places/index.twig` changes above the released website `2e65ab5` add `x-show="canPrevious"` / `x-show="canNext"` to the existing controls. The existing Alpine getters already require more than one photo; no new CSS or separate JavaScript behavior is added. Article lightGallery already applies the same single-item visibility policy. Local Chromium checks at 320/390/1280 px verified a real single-photo set, a multi-photo set, and return to the single-photo set: hidden arrows leave the Tab sequence, arrow keys preserve the single photo/index, and multi-photo buttons remain visible and enabled. Focus trapping/return, Escape, and Close passed. All 23 Places regression checks and scoped Map/Posts release QA passed with no runtime errors or road-shield warnings. The source change is committed in website `e644cc4`, with its browser-QA expectations in frontend `bfafdf2`.

Production verification, 2026-09-28: the deployed change passed the same actual single → multi → single sequence at 320/390/1280 px on `/photography`, including arrow visibility, single-photo key guards, Tab/focus trapping, Escape focus return, and Close. No page errors occurred. The implementation agent visually inspected the 390/1280 px single/multi-photo states without clipping. Production deployment smoke and HTTP-header checks also passed. These are scoped Chromium results, not physical-device or screen-reader coverage.

A missing map resource leaves the photo gallery and Posts available. Without JavaScript, Map links to the server-rendered Posts view. When no photos have usable locations, an empty state explains that locations are being added and directs visitors to Posts.

## Mosaic

Scoped source review, 2026-09-28: website `f8a731a6770163817505792ff71aa7c1a5f911c6` and frontend `df04ee11c41a0b69c770d557cd10d6f75d19c803` save Mosaic on `codex/photo-mosaic`, including the earlier approved header changes as its integration baseline. This is a locally verified implementation; no staging or production deployment is claimed.

Mosaic provides a field of thumbnails ordered by color. A quiet toolbar directly above it sticks below the global header and contains **Square | Justified**, a three-step **Size** slider, and **N photos**. Controls retain accessible names, pressed-state semantics, and the site's keyboard-focus treatment. On narrow screens the size control and count share a compact stack. New behavior uses Alpine.js and styling uses inline Tailwind utilities.

Local presentation refinement, 2026-09-28, saved in website `1872d998ceffd8b7d811c7fe5b2f51f8731057b8`: the thumbnail field has 20 px outer padding at every width and no 1600 px maximum. A 56 px toolbar aligns its controls to the same 20 px horizontal inset. Unboxed Square and Justified buttons retain 44 px targets, regular 12 px/400 labels matching the map chips, and 14 px outline icons (`stroke-width="1.25"`). Selected and hovered text uses Slate 950. The selected 2 px underline spans the icon and label and is anchored 6 px below their 16 px content box; inactive hover does not add an underline. This optical-spacing correction increases the prior visible gap by 2 px rather than relying on nominal baseline-offset equivalence. That underline width is a later local correction to the original 16 px dash; the preceding commit and its verification record retain their original scope. Size and the photo count remain compact at the right. Focused Chromium checks passed at 320/390/768/1440/1920 px for those dimensions, no overflow/overlap, selected-only underlines, layout switching, keyboard focus, and sticky placement, with no JavaScript errors. The implementation agent visually reviewed 390/1440 px screenshots. Scoped Mosaic release QA passed the build, content/asset, font, and route checks. This remains local and undeployed; the earlier integration results below retain their original scope. The later label/icon refinement in website `467778aa3f7bc4f6a466e16bb5ba4976d0b6e8af` passed focused checks for both layouts at 320/390/1440 px and scoped Mosaic release QA, including all 48 fonts; 390 px Square and 1440 px Justified screenshots were visually reviewed. The spacing correction in `4160833b5721e72841570be4991628a4354ef29c` passed focused checks at the same widths and scoped release QA; DPR 2 screenshots showed a 7.5 CSS px clear gap for both Square and global Places. Justified shares the indicator alignment; glyph-dependent clear gaps need not be identical.

Square displays equal cropped tiles. Justified fits full-proportion images into rows, retaining a modest last row instead of stretching a lone portrait. Both layouts keep the same photo order; size changes alter density without changing that order. Default settings are square and medium. URL settings and optional local preferences restore the chosen layout and size, while each Places view retains its own page position. Changing layout or size anchors the currently visible photograph.

Photos qualify through their published Places uses, independent of GPS or gallery locations. The mosaic includes unlocated photos and shows each shared asset once. Its stable published-post association supplies **View post** in the existing viewer, which navigates the mosaic's color order and wraps in either direction. Square and full-proportion responsive image sources remain distinct. Photos load lazily after the initial row; opening Mosaic does not require the map library.

Color profiles are calculated from small uncropped pixel samples by background processing and refreshed for changed files. Public page requests read stored profiles rather than analyze images. Pending or unavailable profiles leave their photographs visible at the end of the collection. A profile describes the photograph's visible colors, so a large sky or foliage area may determine its placement. Publication date is not a mosaic ordering option. No new author-entered color field or plugin is required.

Without JavaScript, Mosaic links to the server-rendered Posts view. Missing image previews retain a named button that can open the photograph. Empty collections have an explanatory state. The existing full-image viewer keeps keyboard navigation, focus trapping/return, and its compact header.

Local integration verification, 2026-09-28: all 23 Mosaic Chromium checks passed at 1440/768/390/320 px, including both layouts, three densities, unchanged photo order, scroll anchoring, shared-viewer wrapping/focus, URL/preferences/history, return navigation, modified clicks, keyboard size adjustment, a single-photo set, blocked storage, and no-JavaScript navigation. Visible-image decoding passed, and no JavaScript runtime errors occurred. The implementation agent visually reviewed the 1440 px square and 390 px justified layouts. Existing Map/Posts regression checks and the scoped three-view release checks also passed. These results do not establish Safari, physical-device, screen-reader, or much larger archive performance coverage.

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
