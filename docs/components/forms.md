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
  - rounded-md
  - border-slate-300
  - shadow-xs
  - focus:border-slate-500
  - focus:ring-slate-500
dependencies:
  - Tailwind forms plugin
  - Craft contact form plugin
accessibility:
  reviewed: false
  notes: Current source includes labels, field errors, aria-invalid, aria-describedby, and form-level alert; rendered states still need testing.
owner: Ben Tilden
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Forms

The contact page is the current form pattern. It is visually adjacent to the article system, but it remains a bespoke page rather than a `bt-article` component.

## Current Pattern

Contact fields use explicit labels, Slate borders, subtle shadows, and Slate focus rings:

```html
class="block w-full max-w-lg rounded-md border-slate-300 shadow-xs focus:border-slate-500 focus:ring-slate-500 sm:text-sm"
```

The submit button is still a local Tailwind composition, not the shared `bt-button` class. It should either adopt `bt-button` or become a documented form-specific variant.

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
| Submit button should either use `bt-button` or become a documented form-specific variant. | Needs decision |
| Success, validation, spam, and keyboard states need rendered testing. | Needs audit |
