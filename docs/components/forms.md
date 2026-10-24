---
title: Forms
type: component
status: observed
source_of_truth: observed dev code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/contact.twig
  - bentilden.com-css/src/bentilden.css
classes:
  - rounded-md
  - border-neutral-500
  - shadow-xs
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

## Current Pattern

Contact fields use explicit labels, Neutral borders, subtle shadows, and Neutral focus rings:

```html
class="block w-full max-w-lg rounded-md border-neutral-500 shadow-xs focus:border-neutral-700 focus:ring-neutral-700 sm:text-sm"
```

Scoped first-release review, 2026-09-28: field focus rings at website `b1cf61e` follow the global [Focus Appearance](../accessibility/index.md#focus-appearance) rule: Tab or Shift+Tab enables them, and pointer interaction hides them. The existing focus border treatment remains.

Scoped source update, 2026-09-28: uncommitted `contact.twig` above website `b1cf61e` strengthens the normal-state field boundary from Slate 300 to Slate 500 and its focus border/ring to Slate 700. Existing validation-error branches remain intact. The rendered form has no placeholders, so no placeholder utility is added. Local Chromium checks at 320/390/1280 px verified normal and keyboard-focus boundaries, measuring approximately 4.55:1 and 9.90:1 respectively against the surrounding Slate 50. Submission, error announcements, and assistive-technology behavior are outside this contrast check.

The submit button remains a local Tailwind composition. Future form variants should follow the [inline utility rule](../contributing.md#frontend-implementation-rule); visual alignment with other buttons does not require a new custom CSS class.

## Layout

Form rows use a three-column grid on small screens and above:

```html
sm:grid sm:grid-cols-3 sm:items-start sm:gap-4 sm:border-t sm:border-neutral-200 sm:pt-5
```

Scoped local review, 2026-10-24: `contact.twig` at runtime `69a3f2b` removes nested `divide-y` containers and gives the Send area its own subtle separator:

```html
class="mt-8 border-t border-neutral-200 pt-5 sm:mt-5"
```

Tailwind 4's `divide-y` draws a bottom border on each non-last child. On the former field-group wrapper, that border touched the message textarea's bottom edge. Keeping the divider on the action area provides clear space before the rule and padding after it. Avoid applying automatic sibling dividers to a group that mixes visible form sections with hidden integration inputs.

The corrected layout was measured locally at 320/390/640/768/1423 px: the textarea-to-divider gap is 32 px below `sm` and 20 px from `sm` upward, with no horizontal overflow. The normal field classes and palette above were checked against current local source; the September Slate measurements remain historical. Production verification, 2026-10-24 at runtime `69a3f2b`: Chromium checks at 320/390/768/1440 px confirm the same spacing, a single 1 px action separator, 20 px padding below it, no field-group bottom border and no overflow or application exceptions. Active font checks pass; the strict generic browser suite still flags the existing Google reCAPTCHA `requestStorageAccess` console warning. No message was submitted. Submission, error-state and assistive-technology audits remain separate.

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
