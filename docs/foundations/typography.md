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
  - bentilden.com/templates/_matrix/text.twig
  - bentilden.com/templates/_matrix/featuredImage2.twig
classes:
  - font-sans
  - font-display
  - font-micro
  - text-xs
  - bt-dropcap
accessibility:
  reviewed: false
  notes: Metadata and drop-cap source changes are recorded below; broader heading and assistive-technology review remains separate.
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
| Display | `font-display` | `HelveticaNowDisplay`, defaulting to Extra Black weight |
| Metadata | `font-micro` | `HelveticaNowMicro` |
| Code | n/a | System monospace stack |

!!! note "Webfont licensing"
    The current website and the Interface Field Guide serve licensed Helvetica Now webfont files from `https://cdn.bentilden.com/fonts/helvetica-now/`. The documentation uses Text for prose, Display for headings, and Micro for navigation, metadata, and interface labels.

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
<p class="font-micro text-xs uppercase tracking-widest text-slate-600 mt-4 mb-8">
  Posted {{ postDate | date('M d, Y') }}
</p>
```

Use the Micro family at 12 px (`text-xs`) with Slate 600 for editorial dates and image details. Uppercase tracking provides the quiet metadata treatment without relying on a very small size or pale foreground.

### Prose

```html
<div class="bt-text max-w-prose prose prose-p:leading-relaxed prose-li:my-1">
  {{ block.text|typogrify }}
</div>
```

Long-form content uses Tailwind Typography with `max-w-prose` to keep line length readable.

## Drop Cap

The author-supplied `bt-dropcap` class remains a content hook in stored rich text. Its styling is applied by inline descendant utilities on the `_matrix/text.twig` wrapper, so existing content needs no migration.

```html
<div class="bt-text max-w-prose prose [&_.bt-dropcap]:first-letter:text-[5.25em] [&_.bt-dropcap]:first-letter:-mb-3 [&_.bt-dropcap]:first-letter:leading-[0.9] [&_.bt-dropcap]:first-letter:font-bold [&_.bt-dropcap]:first-letter:text-slate-500 [&_.bt-dropcap]:first-letter:mr-3 [&_.bt-dropcap]:first-letter:float-left">
  ...
</div>
```

Use the hook only on narrative openings. The bold Slate 500 letter uses `5.25em` with `0.9` line-height, scaling to the surrounding prose. With the sampled 16 px body text, this computes to 84 px type and a 75.6 px line box. The float, 12 px right spacing, and negative 12 px bottom margin preserve the wrap around the three-line initial.

Scoped source review, 2026-09-28: uncommitted changes above website `b1cf61e` and frontend `f3f709f` update shared/listing dates, matrix/recipe image details, and the rich-text wrapper. The unused `.bt-datePublished`, `.bt-image-details`, and `.bt-dropcap` CSS definitions are removed; stored `bt-dropcap` content hooks remain supported by the template. Local Chromium checks at 320/390/1280 px verified the 12 px dates and large drop caps. Date contrast is 6.15–7.25:1 across the article gradient endpoints; actual drop-cap background samples measured 4.21–4.40:1. Image/recipe details remain source-only verification because the sampled live fields had no matching metadata. The earlier page review date is retained because unrelated type and heading behavior was not re-audited.

Scoped alignment refinement, 2026-09-28: the inline rich-text wrapper replaces the earlier fixed 90 px / unit line-height treatment with the relative size and tighter line-height above. Local Chromium checks at 320/390/1280 px found no overflow; visual inspection at 390 px showed the glyph top aligned with the first text line and its bottom at the third-line baseline. The earlier contrast checks retain their original scope. The implementation agent also reviewed before/after crops at all three widths, and the coordinating agent inspected the 320/390 px results. These checks do not establish cross-browser, physical-device, or assistive-technology coverage.
