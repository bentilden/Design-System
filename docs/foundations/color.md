---
title: Color
type: foundation
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
source:
  - bentilden.com/templates/_layout.twig
  - bentilden.com/templates/_components/global-header-nav-primary.twig
  - bentilden.com/templates/_components/global-header-nav-mobile.twig
  - bentilden.com-css/src/bentilden.css
tokens:
  - slate
environments:
  observed:
    - prod
    - dev
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Color

The website uses Tailwind Slate for UI and page structure. The compact navigation direction accepted on 2026-09-28 uses Slate links and subtle rule/underline states on desktop and mobile. The previous orange mobile-navigation accent belongs to the superseded overlay.

## Core Palette

<div class="bt-token-grid" markdown>
<div class="bt-swatch">
  <div class="bt-swatch__color" style="background:#f8fafc"></div>
  <div class="bt-swatch__meta">
    <span class="bt-swatch__name">Slate 50</span>
    <span class="bt-swatch__value">#f8fafc</span>
  </div>
</div>
<div class="bt-swatch">
  <div class="bt-swatch__color" style="background:#e2e8f0"></div>
  <div class="bt-swatch__meta">
    <span class="bt-swatch__name">Slate 200</span>
    <span class="bt-swatch__value">#e2e8f0</span>
  </div>
</div>
<div class="bt-swatch">
  <div class="bt-swatch__color" style="background:#90a1b9"></div>
  <div class="bt-swatch__meta">
    <span class="bt-swatch__name">Slate 400</span>
    <span class="bt-swatch__value">#90a1b9</span>
  </div>
</div>
<div class="bt-swatch">
  <div class="bt-swatch__color" style="background:#62748e"></div>
  <div class="bt-swatch__meta">
    <span class="bt-swatch__name">Slate 500</span>
    <span class="bt-swatch__value">#62748e</span>
  </div>
</div>
<div class="bt-swatch">
  <div class="bt-swatch__color" style="background:#45556c"></div>
  <div class="bt-swatch__meta">
    <span class="bt-swatch__name">Slate 600</span>
    <span class="bt-swatch__value">#45556c</span>
  </div>
</div>
<div class="bt-swatch">
  <div class="bt-swatch__color" style="background:#0f172b"></div>
  <div class="bt-swatch__meta">
    <span class="bt-swatch__name">Slate 900</span>
    <span class="bt-swatch__value">#0f172b</span>
  </div>
</div>
</div>

Scoped palette audit, 2026-09-28: these swatches reflect the current website’s computed Tailwind palette. The sampled RGB values correct the older Slate 400, 600, and 900 hex labels and add Slate 500. The documentation theme has its own existing stylesheet; these are website palette values, not a claim that every documentation-theme token was changed.

## Usage

| Use | Tailwind classes | Notes |
| --- | --- | --- |
| Page shell | `bg-slate-200`, `bg-slate-50` | Creates the soft gray page frame and content body. |
| Article background | `bg-gradient-to-b from-slate-50 to-slate-200` | Used to let long articles fade into the page footer area. |
| Primary text | `text-slate-900` | Used for high-emphasis editorial text. |
| Small secondary text | `text-slate-600` | Captions, counts, instructions, and other small text on light surfaces. Avoid opacity reductions. |
| Metadata | `font-micro text-xs text-slate-600` | Editorial dates and image details use 12 px type with uppercase tracking. |
| Footer | `bg-slate-900`, `text-slate-400` | Dark ending band; copyright uses Slate 400 while primary footer links retain their existing light colors. |
| Functional boundaries | `border-slate-500`, `focus:border-slate-700`, `focus:ring-slate-700` | Contact fields remain identifiable before and during focus. |
| Category icons and drop caps | `fill-slate-500`, `hover:fill-slate-700`, `first-letter:text-slate-500` | Solid functional SVG icons; large drop caps use Slate 500. |
| Navigation state | `text-slate-600`, `text-slate-700`, `text-slate-950` | Compact header: quiet links, darker current/hover state, and underline. See [Navigation](../components/navigation.md). |

## Divider Hierarchy

Source and computed-style refinement review, 2026-09-28: use a 1 px `border-slate-300/70` outer header boundary on desktop and mobile. Desktop link groups use spacing in place of a vertical separator. Mobile has one outer rule under the complete header and retains the inset Slate 200 rule above About/Contact.

The earlier Places treatment used a Slate 200 long line behind Map | Posts. The local 2026-09-28 [header-switcher trial](../patterns/places.md#navigation-and-views) removes that separate line and centers the control on the global header’s Slate 300/70 boundary, with a Slate 50 surround clearing the rule behind it. The switcher outline and map/gallery structural borders remain Slate 300; toolbar dividers remain Slate 200. The different strengths identify the global boundary, component structure, and local grouping without making every rule equally prominent. See [Navigation](../components/navigation.md#review-evidence) for the earlier divider refinement’s source and verification status.

The later shared-toolbar follow-up removes the extra explorer top rule and the desktop divider between the toolbar’s two cells. A continuous Slate 200 bottom rule spans the controls and gallery summary; the Slate 300 map/gallery divider starts below it. The slimmer mobile view control keeps the same selected and hover palette on inner fills while its decorative shell becomes 38 px high around actual 44 px links. See [Places](../patterns/places.md#map-and-gallery) for this local source stage and its check status.

## Guidance

- Start with Slate unless a pattern needs semantic color.
- Use the shared Slate treatment for global navigation. Do not reintroduce the former orange mobile-overlay state as current guidance.
- Use Slate 600 for small text on light surfaces. Slate 400 is suitable for the dark-footer copyright role, not light-surface metadata.
- Use `slate-900` for active states and deep surfaces.

Scoped source review, 2026-09-28: the compact-header palette was inspected in uncommitted website header changes above `b1cf61e`. That initial treatment used Slate 50 surfaces, Slate 200 rules, and Slate 950 current/hover links; no orange state remained in the new header. The later accepted divider refinement above supersedes the outer-rule color. This local source check does not refresh the earlier review of other palette uses or establish deployment. See [Navigation](../components/navigation.md#review-evidence).

## Contrast Follow-Up

Approved and inspected in local source on 2026-09-28: the text, metadata, footer, field, icon, and drop-cap roles above replace the weaker sampled treatments. The changes are uncommitted above website `b1cf61e` / frontend `f3f709f`. Following the user’s correction, the Places view switcher uses a reversed selected state: Slate 900 with white text and no underline. The latest user-selected hover treatment uses Slate 200 with Slate 600 text for inactive hover. Decorative divider strengths remain unchanged.

The computed palette gives Slate 600 approximately 7.25:1 against Slate 50 and 6.15:1 against Slate 200; Slate 400 on Slate 900 is approximately 6.78:1. Local Chromium checks on 2026-09-28 confirmed these ratios in the sampled Places counts/captions and footer, with stronger contact boundaries. Those checks preceded the switcher’s reversed-color correction; its earlier underline result is historical. The correction passed targeted checks at 390/1440 px and without JavaScript, measuring 17.83:1 for selected white text on Slate 900. These are scoped measurements, not a claim about every rendered element. Gradients, opacity, images, and interaction states must be reviewed in context. See [Accessibility](../accessibility/index.md#color-and-contrast) for verification scope and limits.
