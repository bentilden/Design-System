---
title: Layout
type: foundation
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
source:
  - bentilden.com-css/src/elements/grid.css
  - bentilden.com/templates/_layout.twig
  - bentilden.com/templates/_components/global-header.twig
  - bentilden.com/templates/_places/view-navigation.twig
  - bentilden.com/templates/_entry-content/default.twig
classes:
  - bt-page-container
  - bt-grid
  - container
  - max-w-prose
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Layout

The site combines Tailwind containers with custom `bt-*` layout utilities.

## Page Container

```css
.bt-page-container {
  @apply mx-6 md:mx-8;
}
```

Use page gutters to keep content away from mobile edges and preserve a calm reading rhythm.

## Responsive Grid

```css
.bt-grid {
  @apply grid grid-cols-4 gap-4 sm:grid-cols-8 md:gap-8 lg:grid-cols-12;
  @apply mx-auto sm:max-w-[496px] md:max-w-[608px] lg:max-w-[928px] xl:max-w-[1248px] 2xl:max-w-[1504px];
}
```

| Breakpoint | Columns | Gap | Max width |
| --- | ---: | --- | ---: |
| Default | 4 | `gap-4` | Fluid |
| `sm` | 8 | `gap-4` | 496px |
| `md` | 8 | `gap-8` | 608px |
| `lg` | 12 | `gap-8` | 928px |
| `xl` | 12 | `gap-8` | 1248px |
| `2xl` | 12 | `gap-8` | 1504px |

## Article Frame

Articles use a vertical gradient and a conventional container:

```html
<article class="pt-12 pb-14 bg-gradient-to-b from-slate-50 to-slate-200 bt-article">
  <div class="px-8 lg:container mx-auto">
    ...
  </div>
</article>
```

## Reading Width

Use `max-w-prose` for story text. Use wider columns for media and gallery blocks. Image-heavy layouts can break out with negative horizontal margins on small screens:

```html
<div id="lightgallery_{{ block.id }}" class="-mx-8 md:mx-0">
  ...
</div>
```

## Header And Content Boundary

Scoped source review, 2026-09-28: the compact global header uses a shared sticky wrapper in normal flow. Desktop is 96 px high at 768 px and above; the mobile bar is 80 px high, with an inline disclosure beneath it. `_layout.twig` places the wrapper before the growing main-content container and removes the old fixed-header offset. The header does not resize on scroll. The initial Places integration added 16 px to the measured header offset; the later [Places scroll-alignment refinement](../patterns/places.md#map-and-gallery) removes that gap and fills the available desktop viewport. Its desktop reserve still starts at 96 px. These uncommitted changes were inspected above website `b1cf61e` / frontend `f3f709f`; see [Navigation](../components/navigation.md#review-evidence) for the full sources and check status. The earlier grid/article review date remains unchanged.

Local header-switcher trial, 2026-09-28: source above website `e644cc4` / frontend `bfafdf2` adds a Places-only slot beneath the unchanged identity bars. The control straddles their lower rule; the slot supplies 24 px at `md` and above or 32 px below it, making the occupied sticky stack 120/112 px. Places measures that whole stack for its desktop map and result-scroll position, replacing the preceding 96 px reserve. Opening mobile Menu hides the slot. The former in-page control row, long rule, and explorer top margin are removed. See [Places](../patterns/places.md#navigation-and-views) for responsive control dimensions and the passing local checks, including their content-overflow limitation; this local trial is not a deployment.

Shared-toolbar follow-up, 2026-09-28: from `lg`, the explorer grid uses a 56 px first row for aligned map-control and gallery-summary cells, both sticky beneath the 120 px header stack. The map and gallery occupy the next row, with the map sticky at 176 px. The toolbar has one continuous bottom rule; its top rule and internal vertical divider are removed. The map/gallery vertical divider begins below the toolbar. Below `lg`, the same four children flow as controls, map, summary, then gallery. Result-scroll positioning includes the desktop toolbar or preserves the separate mobile summary. Source is implemented locally; [Places](../patterns/places.md#map-and-gallery) records verification separately.
