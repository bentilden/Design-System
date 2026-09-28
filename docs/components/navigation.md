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
  - bentilden.com-css/src/places.js
dependencies:
  - Alpine.js
accessibility:
  reviewed: false
  notes: The approved mobile pattern is a nonmodal disclosure; source and rendered checks are recorded below.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-09-28
review_status: needs audit
---

# Navigation

Global navigation pairs a compact signature with ordinary links. The accepted direction on 2026-09-28 gives the site a stable header and keeps mobile navigation in the page context. This replaces the large centered signature, scroll-driven resizing, uppercase pills, and full-screen mobile overlay.

## Desktop Header

Place the signature at the left and the navigation at the right. At the `md` breakpoint (768 px) and above, the header is 96 px high and the signature is 160 px wide. Keep both dimensions stable as the visitor scrolls. Use a subtle separating rule and underline for the current destination; avoid raised or filled navigation chips. The header contains no portrait. Its Slate 50 surface and 1 px `border-slate-300/70` lower rule replace the previous blurred surface and scroll-triggered shadow. The primary links and About/Contact are separated by a 40 px gap at `md` and a 56 px gap at `lg`, without a vertical separator.

## CMS Navigation Contract

The Craft `globalHeader` navigation nodes own labels, order, and destinations. The reviewed set is **All posts, Places, Food, Work, About, Contact**. These labels are content and must not be replaced with a hardcoded list in the templates. In particular, Food and Work remain the labels even though their underlying category identities are cooking and design.

Preserve navigation URLs while normalizing the existing photography destination to **Places** at `/photography`, which opens Map by default. The shared header builds the primary and secondary link groups once, using each node’s `current` state for `aria-current="page"` rather than marking a current ancestor as the destination. Use the same ordered destinations on desktop and mobile.

## Mobile Disclosure

The closed mobile header is 80 px high, including its 1 px lower rule. A 79 px identity row holds a 144 px signature and a visible **Menu** control. Opening Menu reveals ordinary navigation links beneath that row while keeping the page visible. It is a nonmodal disclosure: the navigation does not trap focus, make the page inert, or declare dialog semantics. It does not introduce a navigation heading into the document outline.

Use one 1 px `border-slate-300/70` outer rule below the complete header: beneath the signature/Menu row when closed and beneath the disclosed navigation when open. The row and menu share a surface with no internal boundary. The inset Slate 200 rule above About/Contact remains to group those destinations.

Alpine exposes `aria-expanded` and the region relationship through `aria-controls`. Native `hidden` attributes prevent a flash before Alpine initializes and keep closed links out of the keyboard sequence. The toggle changes its visible label between Menu and Close. Escape within the header closes the disclosure and returns focus to the toggle; moving focus or clicking outside closes it without moving focus back. Crossing into the desktop breakpoint and the browser’s `pageshow` event reset the open state.

The disclosed region uses `max-height: calc(100dvh - 6.5rem)` through an inline Tailwind utility and can scroll internally on short screens. This leaves page context visible. A `noscript` copy of the same links keeps navigation available when JavaScript is disabled, and the inactive toggle stays hidden. These are source observations; browser verification is recorded below.

## Page Boundary

A shared `sticky top-0` wrapper is a direct child of the body’s flex column, before the growing main-content container. The header occupies its natural height in page flow, so the former artificial main-content top offset is removed. Opening mobile navigation expands the header in flow. The old `scrolledFromTop` state and window-scroll listener are removed.

## Places Destination

The category retains its existing `photography` identity and topic hooks. Its centered Map | Posts switcher remains separate from global navigation; Posts is the complete chronological category stream. The long line behind the switcher is Slate 200, while the switcher outline and map/gallery structure use Slate 300. See [Places](../patterns/places.md) for map, gallery, and view-restoration behavior.

The later Places scroll-alignment refinement removes the extra 16 px offset so the map sticks directly beneath the measured header. Its canvas fills the remaining desktop viewport below that header and the 56 px toolbar. The initial desktop reserve is 96 px and tracks the measured desktop header. Mobile disclosure height cannot carry into that desktop reserve. Header changes must still be checked with map canvas sizing, result-scroll targets, and camera stability during ordinary scrolling.

## Footer

The footer uses a Slate 900 band, white signature asset, compact navigation links, Slate 400 copyright, and an RSS link. The user-requested 2026-09-28 refinement removes the Mastodon link. Source inspected in uncommitted `_components/global-footer.twig` above website `b1cf61e`; targeted Chromium samples at 320/390/1280 px confirmed Mastodon absent and RSS retained. Stream-page pagination should meet the footer directly without an intervening pale band; see [Stream Pages](../patterns/stream-pages.md#pagination).

## Implementation Rule

Implement new behavior with Alpine.js and new styling with inline Tailwind utilities. Ask the site owner before introducing an exception. See [Contributing](../contributing.md#frontend-implementation-rule) for the durable rule accepted on 2026-09-28.

## Review Evidence

Source reviewed on 2026-09-28 in uncommitted `bentilden.com` changes above `b1cf61ef358dc56cce21402f973740ca5d6ad174` and frontend changes above `f3f709f178c9df6a67c823353d381aa994b09a2b`: the files listed in this page’s metadata, including the shared header, both responsive variants, layout, and Places measurements. The new behavior uses Alpine directives and the new styling uses inline Tailwind utilities. Local Chromium verification on 2026-09-28 passed 18 navigation checks: 16 interactive/layout checks plus two no-JavaScript checks, with no page runtime errors. Coverage includes widths 320, 390, 767, 768, 1024, and 1440 px, short 667 × 375 px reachability, focus/Escape and outside dismissal, page scrolling, breakpoint reset, and current destinations. All six fallback links remain reachable at 390 × 844 and 667 × 375; the short-screen case retains 24 px of page context.

All 22 Places browser checks passed after the header change, including a stable 96 px header with zero map-canvas mutations across 185 sampled frames. Scoped release QA passed content, asset-environment, build, fonts, and browser checks on `/about`, `/contact`, `/kyoto-in-fall`, `/kyoto-guard-tower`, `/photography`, and `/photography?view=posts`; all 48 declared font faces loaded on each route. The browser font check now requires Micro typography only when the page contains a Micro target.

The passing release scope excludes the homepage: an earlier full run encountered an external Google DNS failure there. A Places fixture initially sent Escape before Alpine's delayed focus trap was ready; the passing rerun waits for focus and asserts closure, with no accompanying product change. The result JSON and release log were inspected for this summary; their sanitized combined receipt is retained in private project notes. These checks do not establish Safari, physical-device, or screen-reader behavior. No navigation deployment is claimed.

Scoped divider refinement, 2026-09-28: the stronger outer rule, desktop group spacing, single mobile boundary, and softer Places switcher line were inspected in uncommitted `global-header-nav-primary.twig`, `global-header-nav-mobile.twig`, and `_places/index.twig` above website `b1cf61e`. The mobile identity row uses `h-[calc(5rem-1px)]` to retain the 80 px closed-header total after moving the 1 px border to the outer header. Existing Alpine behavior is unchanged. All 18 local navigation checks passed for the refinement with no runtime errors. Computed styles confirmed the 1 px outer rule at 70% opacity, 40/56 px group gaps, absent desktop separator, no row/menu boundary, and no horizontal overflow at 1440, 768, and 390 px. The header retained its 96 px desktop and 80 px closed-mobile height; the scrolled desktop map remained at 112 px. Screenshot inspection was reported for the desktop and mobile states.

The refinement’s scoped release QA passed on `/about`, `/contact`, `/kyoto-in-fall`, `/photography`, and `/photography?view=posts`, including all 48 font faces on each route. This is a separate result from the preceding release run. The full Places browser suite was not rerun for this styling-only change, and the homepage was outside its release scope. Result JSON, measurements, and the release log were inspected and summarized in the retained private receipt. No deployment is claimed.

## Related Pages

- [Accessibility](../accessibility/index.md) covers disclosure state, focus, and the review bar.
- [Layout](../foundations/layout.md) covers header/content boundaries.
- [Areas of Interest](../patterns/areas-of-interest.md) explains the category identities behind the authored navigation labels.
- [Render Audit](../audit/render-audit.md) preserves historical findings from the previous navigation.
