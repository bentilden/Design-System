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
  - bentilden.com/templates/_entry-content/default.twig
classes:
  - bt-page-container
  - bt-grid
  - container
  - max-w-prose
owner: Ben Tilden
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
