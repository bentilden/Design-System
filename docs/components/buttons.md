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
- Align visible surfaces and labels, rather than invisible target edges. Peer controls share a center. Work's current header placement is documented in [Work Hide Text Switch](#work-hide-text-switch); the earlier date-side alignment is superseded by the below-date layout.
- Keep the existing compact desktop roles: shared segments, Places chip/filter targets and the Mosaic slider can be 32 px high from 768 px. Contact retains its existing desktop field/button sizing, and footer links retain their text-led desktop spacing. Inline prose links follow reading typography rather than a standalone-control box.
- Preserve surface geometry separately: Places chips remain 30 px, filter surfaces 32 px, and the Work track 28 px. Shared toolbar rows remain 56 px; a mobile filter summary may grow when its copy wraps.
- Put padding on the actual link/button. Pagination uses whole 44 px links and wraps rather than overflowing; footer links retain separation between enlarged targets. Viewer Fit and Close have matching 44 px targets.

The same pass aligns Mosaic's Size label/rail with the layout labels while retaining its 2 px rail, 12 px thumb and count. Mobile Contact inputs and Send, footer destinations/RSS, viewer View post and Places chip/filter/range controls now follow the mobile target default. Keyboard semantics and native links remain intact. Focus outlines use Neutral 700 on light surfaces; the dark footer uses a light Neutral 300 outline. See [Navigation](navigation.md#control-target-follow-up), [Places](../patterns/places.md#control-target-follow-up) and [Forms](forms.md#control-target-follow-up).

Verification: 22 focused local Chromium cases at 320/390/768/1280 px plus a short 667 × 375 no-JavaScript case, 30 navigation cases, 23 Mosaic cases and 23 viewer cases passed. The Places run passed 22 cases; its remaining native-pagination case passed after the mobile fallback header correction. Local release checks passed content, assets, build, fonts and four routes. These are emulated/browser checks, not physical-device, Safari or screen-reader coverage.

Production verification, 2026-11-23: all 22 target/alignment, 10 hover/touch/reduced-motion and two segmented-control cases passed on the public site after activation. Public CSS and JavaScript match the release build; route/header smoke passed. Mobile Mosaic was visually reviewed, and the temporary viewport was reset. This supplements the local checks above; the same physical-device and assistive-technology limits apply.

## Shape, Surface And Shadow Roles

Owner-approved and deployed 2026-11-23: runtime `4be5be1`, frontend styling `f7ae8e6` (source release `8c0d3ee`). Public assets match the release build; all 32 production interaction/target cases pass.

- Outer utility controls use 8 px corners: Contact fields/Send/form feedback and viewer hover controls now match the existing segments, switch track and map controls. Small focus-only link outlines and nested 7/5/2 px corners retain their separate geometry.
- Ordinary fields/buttons are flat. Contact and the legacy shared primary button lose their tiny shadows while retaining borders, targets and focus behavior. No new custom CSS is introduced; the legacy source change only removes its shadow utility.
- Floating map utilities use white surfaces and one quiet `shadow-sm`; controls in document flow remain flat.
- Content images use square corners, including Places grid thumbnails. Floating map photo frames retain their 6 px frame / 2 px inner image and front/back shadow hierarchy.
- Work, Gallery and Featured Image hover share the existing 25/50/−12 px geometry at Neutral 500/50%. Hover-capability gates, fades and reduced-motion handling are retained.
- Keep recipe content variants (facts 18/20 px, Nutrition 16 px/6 px frame, step ingredients 12 px/4 px frame), pill/circle controls and the two-layer sticky-navigation / clipped next-project oval treatments. These are intentional roles, not additional utility-control styles.

## Icon And Text Link Pattern

Owner-approved reference, 2026-11-26: retain this pattern for future uses. It was prototyped on Dev and deliberately removed from the homepage; it is not a production component or the selected Photography header treatment.

- Use one native link with two visual segments inside an outer `rounded-md` (6 px) shape.
- The left segment is a 36 px square (`size-9`) with `bg-neutral-800`, centering the existing 18 px icon.
- The right segment uses `bg-neutral-950`, light 14/20 px text, `px-2.5 py-2` (10 px horizontal / 8 px vertical), and a width determined by its label.
- Separate adjacent controls by 8 px. Keep the group flat, with no arrows or shadow unless the use calls for them.
- Preserve native link semantics and visible keyboard focus. When reusing on mobile, keep the standard 44 px target outside the smaller visible surface without overlapping neighboring controls. The 36 px prototype surface is not an exception to the target guidance above.

The trial retained a lighter spectrum gradient for the color-browsing label to keep it readable on the dark surface. Use this split when an icon needs its own visual segment; ordinary inline links retain their text-led role.

## Primary Button

```css
.bt-button {
  @apply inline-flex items-center rounded-lg border border-transparent bg-neutral-600 px-6 py-3 text-base font-medium text-white hover:bg-neutral-700 focus:outline-hidden focus:ring-2 focus:ring-neutral-500 focus:ring-offset-2;
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
| Default | `bg-neutral-600`, white text, flat surface |
| Hover | `bg-neutral-700` |
| Focus | `focus:outline-hidden`, Neutral focus ring with offset |

Scoped first-release review, 2026-09-28: the global layout at website `b1cf61e` displays these outlines/rings after Tab or Shift+Tab and hides them after pointer interaction. See [Focus Appearance](../accessibility/index.md#focus-appearance) for the input-mode rule and no-Alpine fallback.

## Guidance

- Keep labels short and verb-led.
- Use links styled as buttons when the action navigates.
- Preserve visible focus styling.
- Do not introduce decorative color variants until there is a repeated content need.

## Work Hide Text Switch

Owner-approved header update, 2026-11-23: runtime `33e6292`, frontend QA `a8b1077`. Deployed; public assets and header markup match the release build. This updates placement while preserving the existing switch behavior below.

Scoped review, 2026-11-22: all Work detail pages use a **Hide text** switch with an exposed checked state and a 44 px minimum target. Off shows explanatory text; on shows images only, including hiding image captions. The switch adopts the segmented controls’ neutral surfaces, border and rounded corners. Content fades out, swaps layout at zero opacity, then fades in; reduced motion changes immediately. The original date-side placement described in the release evidence below is superseded by the owner-approved header update: the title and posted date are centered, with Hide text centered directly below the date inside the header, before its divider. The control row has 12 px top spacing; its target remains at least 44 px, with the existing 28 px track. The whole row is hidden without JavaScript.

Explicit on/off choices persist in browser storage. The saved layout restores without a transition, with text visible for a new visitor. If storage is unavailable, the control remains usable for that visit. The preference belongs to the current browser and site origin and is shared across Work entries. Native images in mixed Story content remain visible in both modes.

Source: frontend `38e4780`, `src/work-project-view.js`; runtime `686aaff` with mobile alignment refinement `ff08512`, `_work/project.twig`, `_work/controls/text-switch.twig`, `_work/media.twig` and generated assets. The Brand refresh-only template is superseded by this shared renderer. Fourteen controller tests and 81 native Work checks pass; local 320/390/1280 px review confirmed metadata alignment and shared preference. Production verification confirmed all three Work pages, both saved choices across reloads and between projects, and the mobile right-edge/date alignment at 390 px. Desktop Brand refresh remains side by side at 1280 px. Public CSS/JavaScript hashes match the committed build; four-route asset/font and route/header checks passed. Runtime CI/deployment trigger [45080920748](https://github.com/bentilden/bentilden.com/actions/runs/45080920748) succeeded. This does not establish physical-device, other-engine or screen-reader coverage.

## Related Pages

- [Matrix Blocks](matrix-blocks.md) describes authored button content.
- [Forms](forms.md) documents the submit-button and field treatment.
- [Accessibility](../accessibility/index.md) supplies the interaction review bar.
