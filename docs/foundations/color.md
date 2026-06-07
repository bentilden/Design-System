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
  - orange
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

The current website leans on Tailwind Slate for most UI and page structure. Orange appears as a focused accent in mobile navigation active states.

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
  <div class="bt-swatch__color" style="background:#94a3b8"></div>
  <div class="bt-swatch__meta">
    <span class="bt-swatch__name">Slate 400</span>
    <span class="bt-swatch__value">#94a3b8</span>
  </div>
</div>
<div class="bt-swatch">
  <div class="bt-swatch__color" style="background:#475569"></div>
  <div class="bt-swatch__meta">
    <span class="bt-swatch__name">Slate 600</span>
    <span class="bt-swatch__value">#475569</span>
  </div>
</div>
<div class="bt-swatch">
  <div class="bt-swatch__color" style="background:#0f172a"></div>
  <div class="bt-swatch__meta">
    <span class="bt-swatch__name">Slate 900</span>
    <span class="bt-swatch__value">#0f172a</span>
  </div>
</div>
<div class="bt-swatch">
  <div class="bt-swatch__color" style="background:#fdba74"></div>
  <div class="bt-swatch__meta">
    <span class="bt-swatch__name">Orange 300</span>
    <span class="bt-swatch__value">#fdba74</span>
  </div>
</div>
</div>

## Usage

| Use | Tailwind classes | Notes |
| --- | --- | --- |
| Page shell | `bg-slate-200`, `bg-slate-50` | Creates the soft gray page frame and content body. |
| Article background | `bg-gradient-to-b from-slate-50 to-slate-200` | Used to let long articles fade into the page footer area. |
| Primary text | `text-slate-900` | Used for high-emphasis text and active navigation pills. |
| Secondary text | `text-slate-500`, `text-slate-600` | Used for captions and lower-emphasis links. |
| Metadata | `text-slate-400` | Used with micro typography and uppercase tracking. |
| Footer | `bg-slate-900`, `text-white` | Strong ending band for global navigation. |
| Mobile active state | `text-orange-300`, `bg-orange-200 text-orange-700` | Used sparingly in mobile navigation. |

## Guidance

- Start with Slate unless a pattern needs semantic color.
- Keep orange as a navigational accent, not a broad brand wash.
- Use `slate-400` for metadata only when the text remains legible at small sizes.
- Use `slate-900` for active states and deep surfaces.
