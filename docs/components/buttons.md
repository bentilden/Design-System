---
title: Buttons
type: component
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
source:
  - bentilden.com-css/src/components/button.css
  - bentilden.com/templates/_matrix/button.twig
classes:
  - bt-button
accessibility:
  reviewed: false
  notes: Focus styles exist in source; labels and link semantics need content audit.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Buttons

Buttons are compact, quiet, and utility-driven.

## Primary Button

<div class="bt-example" markdown>
<span class="bt-button-demo">Read more</span>
</div>

```css
.bt-button {
  @apply inline-flex items-center rounded-lg border border-transparent bg-slate-600 px-6 py-3 text-base font-medium text-white shadow-xs hover:bg-slate-700 focus:outline-hidden focus:ring-2 focus:ring-slate-500 focus:ring-offset-2;
}
```

## Usage

```twig
<a class="bt-button" href="{{ block.buttonUrl }}">{{ block.label }}</a>
```

Use primary buttons for explicit content actions in matrix blocks. Avoid using them for ordinary inline links.

## States

| State | Treatment |
| --- | --- |
| Default | `bg-slate-600`, white text, `shadow-xs` |
| Hover | `bg-slate-700` |
| Focus | `focus:outline-hidden`, Slate focus ring with offset |

Scoped first-release review, 2026-09-28: the global layout at website `b1cf61e` displays these outlines/rings after Tab or Shift+Tab and hides them after pointer interaction. See [Focus Appearance](../accessibility/index.md#focus-appearance) for the input-mode rule and no-Alpine fallback.

## Guidance

- Keep labels short and verb-led.
- Use links styled as buttons when the action navigates.
- Preserve visible focus styling.
- Do not introduce decorative color variants until there is a repeated content need.

## Related Pages

- [Matrix Blocks](matrix-blocks.md) describes authored button content.
- [Forms](forms.md) documents the separate submit-button treatment and its open design decision.
- [Accessibility](../accessibility/index.md) supplies the interaction review bar.
