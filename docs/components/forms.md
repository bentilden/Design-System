---
title: Forms
type: component
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/contact.twig
  - bentilden.com-css/src/bentilden.css
classes:
  - rounded-lg
  - border-neutral-500
  - focus:border-neutral-700
  - focus:ring-neutral-700
dependencies:
  - Tailwind forms plugin
  - Craft contact form plugin
accessibility:
  reviewed: false
  notes: Current source includes labels, field errors, aria-invalid, aria-describedby, and form-level alert; rendered states still need testing.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Forms

The contact page is the current form pattern. It is visually adjacent to the article system, but it remains a bespoke page rather than a `bt-article` component.

## Control Target Follow-Up

Deployed 2026-11-23, runtime `ae3f1a2`: Contact inputs and Send now have a 44 px minimum height below 768 px; the existing desktop sizing, labels, validation, colors and corners remain. The textarea already exceeds the minimum. Field focus and Send hit testing pass at 320/390/768/1280 px; the form was not submitted. This resolves target sizing only; separate styling/validation audit items below retain their status. Follow the shared [control sizes and alignment](buttons.md#control-sizes-and-alignment).

## Approved Surface Follow-Up

Owner-approved and deployed 2026-11-23, runtime `4be5be1`: fields, Send and form feedback use 8 px corners; ordinary field/Send shadows are removed. Field borders, focus, validation and target sizes remain. Follow [shape, surface and shadow roles](buttons.md#shape-surface-and-shadow-roles).

## Current Production Pattern

Contact fields use explicit labels, Neutral borders, flat surfaces, and Neutral focus rings:

```html
class="block w-full max-w-lg rounded-lg border-neutral-500 focus:border-neutral-700 focus:ring-neutral-700 sm:text-sm"
```

Scoped first-release review, 2026-09-28: field focus rings at website `b1cf61e` follow the global [Focus Appearance](../accessibility/index.md#focus-appearance) rule: Tab or Shift+Tab enables them, and pointer interaction hides them. The existing focus border treatment remains.

Scoped source update, 2026-09-28: uncommitted `contact.twig` above website `b1cf61e` strengthens the normal-state field boundary from Slate 300 to Slate 500 and its focus border/ring to Slate 700. Existing validation-error branches remain intact. The rendered form has no placeholders, so no placeholder utility is added. Local Chromium checks at 320/390/1280 px verified normal and keyboard-focus boundaries, measuring approximately 4.55:1 and 9.90:1 respectively against the surrounding Slate 50. Submission, error announcements, and assistive-technology behavior are outside this contrast check.

The submit button remains a local Tailwind composition. Future form variants should follow the [inline utility rule](../contributing.md#frontend-implementation-rule); visual alignment with other buttons does not require a new custom CSS class.

## Layout

Form rows use a three-column grid on small screens and above:

```html
sm:grid sm:grid-cols-3 sm:items-start sm:gap-4 sm:border-t sm:border-slate-200 sm:pt-5
```

## Error Contract

The current source includes:

- field-specific error lists,
- a form-level error summary with `role="alert"`,
- `aria-invalid` on invalid fields,
- `aria-describedby` connections from fields to errors,
- a hidden honeypot field,
- reCAPTCHA integration.

## Audit Notes

| Finding | Status |
| --- | --- |
| Labels are explicitly associated with inputs. | Observed |
| Error text is connected to invalid fields in source. | Observed |
| Contact does not use `bt-article` or the shared article shell. | Needs decision |
| Submit styling remains an inline form-specific composition; broader visual alignment with shared buttons is separate from these contrast fixes. | Observed |
| Success, validation, spam, and broader keyboard flows need rendered testing; normal-field keyboard focus was checked in the scoped contrast follow-up. | Needs audit |

## Related Pages

- [Buttons](buttons.md) and [Article Content](article-content.md) describe the shared patterns that the contact page may adopt.
- [Accessibility](../accessibility/index.md) lists requirements for labels and error feedback.
- [Open Questions](../audit/open-questions.md) tracks the decision about integrating form styling.


## Local width follow-up

2026-11-23: Contact now uses available page width capped at 768 px, with shared 24 px mobile/32 px desktop shell padding. Targets, labels, field validation and Send behavior are retained. Committed locally in runtime `87f773d` / frontend `cc3ef50`; not pushed or deployed. See [local spacing and rhythm rules](../foundations/layout.md#local-spacing-and-rhythm-review).
