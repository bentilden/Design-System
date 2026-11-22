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

## Work Hide Text Switch

Scoped review, 2026-11-22: all Work detail pages use a **Hide text** switch with an exposed checked state and a 44 px minimum target. Off shows explanatory text; on shows images only, including hiding image captions. The switch adopts the segmented controls’ neutral surfaces, border and rounded corners. Content fades out, swaps layout at zero opacity, then fades in; reduced motion changes immediately. On mobile the switch shares the posted-date row and aligns with the right content edge. The same alignment works on wider screens.

Explicit on/off choices persist in browser storage. The saved layout restores without a transition, with text visible for a new visitor. If storage is unavailable, the control remains usable for that visit. The preference belongs to the current browser and site origin and is shared across Work entries. Native images in mixed Story content remain visible in both modes.

Source: frontend `38e4780`, `src/work-project-view.js`; runtime `686aaff`, `_work/project.twig`, `_work/controls/text-switch.twig`, `_work/media.twig` and generated assets. The Brand refresh-only template is superseded by this shared renderer. Fourteen controller tests and 81 native Work checks pass; local 320/390/1280 px review confirmed metadata alignment and shared preference. Production verification confirmed all three Work pages, both saved choices across reloads and between projects, and the mobile right-edge/date alignment at 390 px. Desktop Brand refresh remains side by side at 1280 px. Public CSS/JavaScript hashes match the committed build; four-route asset/font and route/header checks passed. Runtime CI/deployment trigger [45080920748](https://github.com/bentilden/bentilden.com/actions/runs/45080920748) succeeded. This does not establish physical-device, other-engine or screen-reader coverage.

## Related Pages

- [Matrix Blocks](matrix-blocks.md) describes authored button content.
- [Forms](forms.md) documents the separate submit-button treatment and its open design decision.
- [Accessibility](../accessibility/index.md) supplies the interaction review bar.
