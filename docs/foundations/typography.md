---
title: Typography
type: foundation
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com-css/src/bentilden.css
  - bentilden.com-css/src/elements/type.css
  - bentilden.com/templates/_components/entry-header.twig
classes:
  - font-sans
  - font-display
  - font-micro
  - text-2xs
  - bt-dropcap
accessibility:
  reviewed: false
  notes: Heading hierarchy and small metadata contrast need full audit.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Typography

The site uses Helvetica Now families for text, display, and microcopy.

## Font Families

| Role | Tailwind token | Font family |
| --- | --- | --- |
| Body | `font-sans` | `HelveticaNow`, then Helvetica and system sans fallbacks |
| Display | `font-display` | `HelveticaNowDisplayExtraBlack` |
| Metadata | `font-micro` | `HelveticaNowMicro` |
| Code | n/a | System monospace stack |

!!! note "Webfont licensing"
    The current website includes licensed MyFonts webfont files. This documentation records the intended type roles. The Interface Field Guide asks for Helvetica Now in its CSS stack only when the font is locally available; it does not currently ship the licensed webfont files.

## Type Roles

### Article Title

```html
<h1 class="font-display text-5xl mb-3 leading-none">
  <a href="{{ url }}">{{ title }}</a>
</h1>
```

Use the display face for entry titles and major editorial headings. Keep line-height tight.

### Metadata

```html
<p class="font-micro text-2xs uppercase tracking-widest text-slate-400 mt-4 mb-8">
  Posted {{ postDate | date('M d, Y') }}
</p>
```

Use micro typography for dates, details, photo metadata, and small labels. It should be uppercase, tracked out, and quiet.

### Prose

```html
<div class="bt-text max-w-prose prose prose-p:leading-relaxed prose-li:my-1">
  {{ block.text|typogrify }}
</div>
```

Long-form content uses Tailwind Typography with `max-w-prose` to keep line length readable.

## Drop Cap

The `bt-dropcap` utility creates a large first letter for editorial openings.

```css
.bt-dropcap {
  @apply first-letter:text-[90px] first-letter:-mb-3 first-letter:leading-none first-letter:font-bold first-letter:text-slate-300 first-letter:mr-3 first-letter:float-left;
}
```

Use it only on narrative text blocks where the first paragraph needs an editorial lead-in.
