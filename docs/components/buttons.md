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

## Control Sizes And Alignment

Deployed 2026-11-23: runtime `ae3f1a2`, frontend `cf522fd`. [Production workflow](https://github.com/bentilden/bentilden.com/actions/runs/45265205053).

- Use at least 44 × 44 px targets for standalone mobile controls and navigation below 768 px. A smaller visible track, chip or icon can sit inside that target. Do not extend hit areas into neighboring controls or instructional text.
- Align visible surfaces and labels, rather than invisible target edges. Peer controls share a center; the Work switch deliberately aligns its visible bottom with the posted date on mobile and centers with it on desktop.
- Keep the existing compact desktop roles: shared segments, Places chip/filter targets and the Mosaic slider can be 32 px high from 768 px. Contact retains its existing desktop field/button sizing, and footer links retain their text-led desktop spacing. Inline prose links follow reading typography rather than a standalone-control box.
- Preserve surface geometry separately: Places chips remain 30 px, filter surfaces 32 px, and the Work track 28 px. Shared toolbar rows remain 56 px; a mobile filter summary may grow when its copy wraps.
- Put padding on the actual link/button. Pagination uses whole 44 px links and wraps rather than overflowing; footer links retain separation between enlarged targets. Viewer Fit and Close have matching 44 px targets.

The same pass aligns Mosaic's Size label/rail with the layout labels while retaining its 2 px rail, 12 px thumb and count. Mobile Contact inputs and Send, footer destinations/RSS, viewer View post and Places chip/filter/range controls now follow the mobile target default. Keyboard semantics and native links remain intact. Focus outlines use Neutral 700 on light surfaces; the dark footer uses a light Neutral 300 outline. See [Navigation](navigation.md#control-target-follow-up), [Places](../patterns/places.md#control-target-follow-up) and [Forms](forms.md#control-target-follow-up).

Verification: 22 focused local Chromium cases at 320/390/768/1280 px plus a short 667 × 375 no-JavaScript case, 30 navigation cases, 23 Mosaic cases and 23 viewer cases passed. The Places run passed 22 cases; its remaining native-pagination case passed after the mobile fallback header correction. Local release checks passed content, assets, build, fonts and four routes. These are emulated/browser checks, not physical-device, Safari or screen-reader coverage.

Production verification, 2026-11-23: all 22 target/alignment, 10 hover/touch/reduced-motion and two segmented-control cases passed on the public site after activation. Public CSS and JavaScript match the release build; route/header smoke passed. Mobile Mosaic was visually reviewed, and the temporary viewport was reset. This supplements the local checks above; the same physical-device and assistive-technology limits apply.

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

Scoped review, 2026-11-22: all Work detail pages use a **Hide text** switch with an exposed checked state and a 44 px minimum target. Off shows explanatory text; on shows images only, including hiding image captions. The switch adopts the segmented controls’ neutral surfaces, border and rounded corners. Content fades out, swaps layout at zero opacity, then fades in; reduced motion changes immediately. On mobile the switch shares the posted-date row: its visible track aligns with the bottom of the date block and the right content edge. Its 44 px target is preserved. From 768 px the row uses the existing centered alignment.

Explicit on/off choices persist in browser storage. The saved layout restores without a transition, with text visible for a new visitor. If storage is unavailable, the control remains usable for that visit. The preference belongs to the current browser and site origin and is shared across Work entries. Native images in mixed Story content remain visible in both modes.

Source: frontend `38e4780`, `src/work-project-view.js`; runtime `686aaff` with mobile alignment refinement `ff08512`, `_work/project.twig`, `_work/controls/text-switch.twig`, `_work/media.twig` and generated assets. The Brand refresh-only template is superseded by this shared renderer. Fourteen controller tests and 81 native Work checks pass; local 320/390/1280 px review confirmed metadata alignment and shared preference. Production verification confirmed all three Work pages, both saved choices across reloads and between projects, and the mobile right-edge/date alignment at 390 px. Desktop Brand refresh remains side by side at 1280 px. Public CSS/JavaScript hashes match the committed build; four-route asset/font and route/header checks passed. Runtime CI/deployment trigger [45080920748](https://github.com/bentilden/bentilden.com/actions/runs/45080920748) succeeded. This does not establish physical-device, other-engine or screen-reader coverage.

## Related Pages

- [Matrix Blocks](matrix-blocks.md) describes authored button content.
- [Forms](forms.md) documents the separate submit-button treatment and its open design decision.
- [Accessibility](../accessibility/index.md) supplies the interaction review bar.
