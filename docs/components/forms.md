---
title: Forms
type: component
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
source:
  - bentilden.com/templates/contact.twig
  - bentilden.com-css/tailwind.config.js
classes:
  - rounded-md
  - border-slate-300
  - focus:border-slate-500
  - focus:ring-slate-500
dependencies:
  - Tailwind forms plugin
accessibility:
  reviewed: false
  notes: Labels are present; error, validation, success, and spam-field behavior need review.
owner: Ben Tilden
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Forms

The contact page currently provides the main form pattern.

## Current Pattern

Contact fields use explicit labels, Slate borders, subtle shadows, and Slate focus rings:

```html
class="block w-full max-w-lg rounded-md border-slate-300 shadow-sm focus:border-slate-500 focus:ring-slate-500 sm:text-sm"
```

The submit button is a local Tailwind composition, not the shared `bt-button` class.

## Layout

Form rows use a three-column grid on small screens and above:

```html
sm:grid sm:grid-cols-3 sm:items-start sm:gap-4 sm:border-t sm:border-slate-200 sm:pt-5
```

## Audit Notes

| Finding | Status |
| --- | --- |
| Labels are explicitly associated with inputs. | Observed |
| Contact does not use `bt-article` or the shared article shell. | Needs decision |
| Submit button should either use `bt-button` or become a documented form-specific variant. | Needs decision |
| Error and validation states were not audited in this pass. | Needs audit |
