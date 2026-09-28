---
title: Navigation
type: component
status: observed
source_of_truth: observed dev code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_layout.twig
  - bentilden.com/templates/_components/global-header.twig
  - bentilden.com/templates/_components/global-header-nav-primary.twig
  - bentilden.com/templates/_components/global-header-nav-mobile.twig
  - bentilden.com/templates/_components/global-footer.twig
  - bentilden.com/templates/_places/index.twig
  - bentilden.com/templates/_places/view-navigation.twig
  - bentilden.com/templates/category.twig
  - bentilden.com-css/src/places.js
dependencies:
  - Alpine.js
accessibility:
  reviewed: false
  notes: The approved Personal Index mobile overlay uses modal semantics and Alpine focus trapping; source and rendered checks are recorded below.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-09-28
review_status: needs audit
---

# Navigation

Global navigation pairs a compact signature with ordinary links and stable header dimensions. The Personal Index mobile follow-up approved and deployed on 2026-09-28 opens a full-screen overlay above the stationary page. It supersedes the initial compact inline disclosure; earlier implementation and verification records retain their historical scope.

## Desktop Header

Place the signature at the left and the navigation at the right. At the `md` breakpoint (768 px) and above, the header is 96 px high and the signature is 160 px wide. Keep both dimensions stable as the visitor scrolls. Use a subtle separating rule and underline for the current destination; avoid raised or filled navigation chips. The header contains no portrait. Its Slate 50 surface and 1 px `border-slate-300/70` lower rule replace the previous blurred surface and scroll-triggered shadow. The primary links and About/Contact are separated by a 40 px gap at `md` and a 56 px gap at `lg`, without a vertical separator.

## CMS Navigation Contract

The Craft `globalHeader` navigation nodes own labels, order, and destinations. The reviewed set is **All posts, Places, Food, Work, About, Contact**. These labels are content and must not be replaced with a hardcoded list in the templates. In particular, Food and Work remain the labels even though their underlying category identities are cooking and design.

Preserve navigation URLs while normalizing the existing photography destination to **Places** at `/photography`, which opens Map by default. The shared header builds the primary and secondary link groups once, using each node’s `current` state for `aria-current="page"` rather than marking a current ancestor as the destination. Use the same ordered destinations on desktop and mobile.

## Mobile Personal Index

The mobile header remains 80 px high, including its 1 px `border-slate-300/70` lower rule. Its identity row uses 24 px gutters, a 135 px signature, and a visible **Menu** control. Opening Menu places a Slate 50 overlay above the stationary page. The overlay repeats the signature in an 80 px header and provides a visible **Close** control. Menu and Close use 16 px medium-weight labels, with a 20 px Menu icon and a 24 px Close X; both targets remain at least 44 px high. It contains no avatar, bottom tagline, or additional navigation heading.

Primary links use 25 px labels in ruled rows at least 58 px high with 24 px side gutters. About/Contact form a smaller 17 px group below. Ordinary labels use regular weight; the current destination uses medium weight and a solid dot, 7 px for primary links and 5 px for secondary links, alongside `aria-current="page"`. Both dots sit immediately after their label with an 8 px gap; the primary dot moves 2 px below vertical center for optical alignment, while the secondary dot stays centered. Hover can darken and underline the text but adds no background fill. The mockup's alternative Current label and filled active row are not part of this implementation.

Alpine teleports the named `role="dialog"`, `aria-modal="true"` overlay to the body. Menu exposes `aria-haspopup="dialog"`, `aria-expanded`, and `aria-controls`. The closed overlay stays hidden; opening focuses Close and uses `x-trap.inert.noscroll.noreturn` to contain focus, isolate the background with `aria-hidden`, and lock page scrolling. Alpine's `.inert` modifier here does not set the native `inert` attribute. Explicit Close/Escape dismissal restores Menu focus without scrolling. Crossing into the desktop breakpoint closes the overlay and returns focus to the visible desktop home link; `pageshow` resets it without requesting focus. Following a destination closes without restoring the old trigger.

The overlay's links scroll internally on short screens while its header remains available. A `noscript` copy keeps the same destinations available as inline navigation, with the inactive Menu toggle hidden. Its scrollable fallback uses `calc(100dvh - 6.5rem)`, or `calc(100dvh - 8.5rem)` on Places to reserve the extra 32 px below it. These source observations require the rendered verification recorded below.

## Page Boundary

A shared `sticky top-0` wrapper is a direct child of the body’s flex column, before the growing main-content container. The header occupies its natural height in page flow, so the former artificial main-content top offset is removed. The mobile overlay is outside this flow and preserves the underlying content position and header height. The old `scrolledFromTop` state and window-scroll listener remain removed.

## Places Destination

Production update, 2026-09-28: the three-view Places header and associated toolbar/map refinements are deployed at website `acacd8adf66f2651b086411d63588b7a9e3ee962` / frontend `8fae64919e3e29f3f1b68bd6e1576f3c9fd7d78d`; all 27 production navigation cases passed. The [Places release note](../patterns/places.md) records the broader verification status. Earlier trial and two-view review paragraphs retain their historical scope.

The category retains its existing `photography` identity and topic hooks. Posts is the complete chronological category stream. In the current integration, Map | Mosaic | Posts straddles the global header’s lower rule and remains visible during page scrolling. It retains its own “Places views” navigation label and real links, separate from the CMS destination list. The old in-page row and long Slate 200 line are removed. The switcher outline and map/gallery structure retain Slate 300. See [Places](../patterns/places.md#navigation-and-views) for the trial’s source and verification status.

The desktop/mobile identity bars remain 96/80 px with 24/32 px below them on Places, yielding occupied stacks of 120/112 px. The slimmer mobile refinement retains actual 44 px links while using 32 px colored fills inside a separate 38 px visual shell. From `md`, links/fills remain 28 px and the shell is 34 px. The shell ignores pointer input; focus belongs to the full link target. The shared wrapper owns the Alpine menu state. In the Personal Index follow-up, the Places slot retains its space beneath the modal; it no longer collapses when Menu opens. The same view-link partial supplies the Alpine-teleported control and the no-JavaScript fallback beneath the expanded header. Other destinations do not receive this slot or its extra height.

On Places only, `pb-4` within the fixed-height mobile identity row moves its contents up 8 px to separate the signature/Menu hit areas from the view links crossing the rule. The overlay header repeats this inset so the signature stays in the same position when Menu opens. This keeps the bar at 80 px; spacing must be checked using link bounds, not text appearance alone. The mobile signature and Menu controls use `relative focus-visible:z-10` so their keyboard outlines draw above the adjacent switcher surround.

From `lg`, the shared map/gallery toolbar sticks directly beneath the measured whole header stack, initially at 120 px. The map sticks below its 56 px row, initially at 176 px, and the canvas fills the remaining viewport. The desktop reserve starts at 120 px; the mobile overlay does not contribute to it. Below `lg`, the map and separate location-chip/summary rows remain nonsticky; zoom and Expand/Collapse sit over the map itself. Header changes must still be checked with map canvas sizing, result-scroll targets, and camera stability during ordinary scrolling.

## Footer

The footer uses a Slate 900 band, white signature asset, compact navigation links, Slate 400 copyright, and an RSS link. The user-requested 2026-09-28 refinement removes the Mastodon link. Source inspected in uncommitted `_components/global-footer.twig` above website `b1cf61e`; targeted Chromium samples at 320/390/1280 px confirmed Mastodon absent and RSS retained. Stream-page pagination should meet the footer directly without an intervening pale band; see [Stream Pages](../patterns/stream-pages.md#pagination).

## Implementation Rule

Implement new behavior with Alpine.js and new styling with inline Tailwind utilities. Ask the site owner before introducing an exception. See [Contributing](../contributing.md#frontend-implementation-rule) for the durable rule accepted on 2026-09-28.

## Review Evidence

Production verification, 2026-09-28: website `48f6249f626c0ef78d32a6cdbf0a4a339df6661e` and frontend `6f981f56bdac73fe90b39dceed832bb5a4fadf62` are deployed, including the final adjacent-dot alignment and Menu/Close sizing. All six changed runtime paths matched the committed source by SHA-256, and the publicly served CSS and JavaScript matched as well. All 27 production navigation checks passed with zero runtime errors; the deployed 390 px Places menu was also visually reviewed. Local browser results below retain their separate scope, and this navigation result does not establish a passing full-site browser audit.

Personal Index source review, 2026-09-28: uncommitted website changes above `fcfbf500678f6c156155234846eac75e3c1bb232` update `global-header.twig`, `global-header-nav-mobile.twig`, and the desktop home focus reference in `global-header-nav-primary.twig`. The approved overlay uses Alpine behavior and inline Tailwind styling. All 27 updated local Chromium navigation checks passed with zero runtime errors: responsive header fit, stationary underlying content, trapped focus and return, background scroll lock, breakpoint reset, actual destination/current states, preserved Places geometry, and no-JavaScript reachability. Tested widths include 320, 390, 767, 768, 1024, 1280, and 1440 px, with 667 × 375 px short-screen coverage. Visual review covered the 390 px menu, active Places/About states, and short landscape state. These checks do not establish Safari, physical-device, or screen-reader coverage; no deployment is claimed.

The required seven-route release run passed content, asset environment, frontend build, and font QA, loading all 48 faces on each route. Browser QA passed `/about`, `/contact`, `/photography`, `/photography?view=mosaic`, `/photography?view=posts`, and `/kyoto-in-fall`, but the overall run failed on `/` because an external Google ad-traffic-quality request returned `net::ERR_NAME_NOT_RESOLVED`. No overall release-QA pass is claimed. Earlier results below describe the preceding disclosure and do not verify the overlay.

Initial disclosure source reviewed on 2026-09-28 in uncommitted `bentilden.com` changes above `b1cf61ef358dc56cce21402f973740ca5d6ad174` and frontend changes above `f3f709f178c9df6a67c823353d381aa994b09a2b`: the files listed in this page’s metadata, including the shared header, both responsive variants, layout, and Places measurements. The new behavior uses Alpine directives and the new styling uses inline Tailwind utilities. Local Chromium verification on 2026-09-28 passed 18 navigation checks: 16 interactive/layout checks plus two no-JavaScript checks, with no page runtime errors. Coverage includes widths 320, 390, 767, 768, 1024, and 1440 px, short 667 × 375 px reachability, focus/Escape and outside dismissal, page scrolling, breakpoint reset, and current destinations. All six fallback links remain reachable at 390 × 844 and 667 × 375; the short-screen case retains 24 px of page context.

All 22 Places browser checks passed after the header change, including a stable 96 px header with zero map-canvas mutations across 185 sampled frames. Scoped release QA passed content, asset-environment, build, fonts, and browser checks on `/about`, `/contact`, `/kyoto-in-fall`, `/kyoto-guard-tower`, `/photography`, and `/photography?view=posts`; all 48 declared font faces loaded on each route. The browser font check now requires Micro typography only when the page contains a Micro target.

The passing release scope excludes the homepage: an earlier full run encountered an external Google DNS failure there. A Places fixture initially sent Escape before Alpine's delayed focus trap was ready; the passing rerun waits for focus and asserts closure, with no accompanying product change. The result JSON and release log were inspected for this summary; their sanitized combined receipt is retained in private project notes. These checks do not establish Safari, physical-device, or screen-reader behavior. No navigation deployment is claimed.

Scoped divider refinement, 2026-09-28: the stronger outer rule, desktop group spacing, single mobile boundary, and softer Places switcher line were inspected in uncommitted `global-header-nav-primary.twig`, `global-header-nav-mobile.twig`, and `_places/index.twig` above website `b1cf61e`. The mobile identity row uses `h-[calc(5rem-1px)]` to retain the 80 px closed-header total after moving the 1 px border to the outer header. Existing Alpine behavior is unchanged. All 18 local navigation checks passed for the refinement with no runtime errors. Computed styles confirmed the 1 px outer rule at 70% opacity, 40/56 px group gaps, absent desktop separator, no row/menu boundary, and no horizontal overflow at 1440, 768, and 390 px. The header retained its 96 px desktop and 80 px closed-mobile height; the scrolled desktop map remained at 112 px. Screenshot inspection was reported for the desktop and mobile states.

The refinement’s scoped release QA passed on `/about`, `/contact`, `/kyoto-in-fall`, `/photography`, and `/photography?view=posts`, including all 48 font faces on each route. This is a separate result from the preceding release run. The full Places browser suite was not rerun for this styling-only change, and the homepage was outside its release scope. Result JSON, measurements, and the release log were inspected and summarized in the retained private receipt. No deployment is claimed.

## Related Pages

- [Accessibility](../accessibility/index.md) covers modal state, focus, and the review bar.
- [Layout](../foundations/layout.md) covers header/content boundaries.
- [Areas of Interest](../patterns/areas-of-interest.md) explains the category identities behind the authored navigation labels.
- [Render Audit](../audit/render-audit.md) preserves historical findings from the previous navigation.
