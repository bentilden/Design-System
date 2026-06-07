---
title: Accessibility
type: guideline
status: draft
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_layout.twig
  - bentilden.com/templates/_components/global-header-nav-mobile.twig
  - bentilden.com/templates/contact.twig
  - bentilden.com/templates/_entry-content/recipe/recipe.twig
  - bentilden.com/docs/assets.md
  - bentilden.com/scripts/content-qa.php
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Accessibility

Accessibility is a component contract, not a separate polish pass. These are the current rules the design system should preserve as templates evolve.

## Image Alt Text

- Public editorial images should have meaningful native Craft alt text.
- Templates should render native alt text first, then a safe title or file-name fallback.
- Decorative SVGs inside labeled links or buttons should use `aria-hidden="true"`.
- Visible captions and details do not replace alt text.

## Navigation And Dialogs

- Icon-only navigation controls need an accessible name.
- Mobile navigation uses a dialog pattern with `role="dialog"`, `aria-modal="true"`, `aria-label`, escape handling, and Alpine focus trapping.
- Closed navigation content should not be exposed as active page structure.
- Return focus after closing the mobile menu still needs rendered/manual verification.

## Forms

- Every input needs an explicit label.
- Error messages should be connected with `aria-describedby`.
- Invalid fields should set `aria-invalid="true"`.
- Form-level errors should be announced with `role="alert"`.
- Honeypot and spam-prevention fields must stay hidden from normal navigation and screen-reader flow.

## Tables

- Data tables need captions, even when the caption is visually hidden.
- Recipe ingredients and nutrition facts should preserve meaningful row/column relationships.
- Layout-only tabular markup should be avoided.

## Media And Lightboxes

- Gallery thumbnails need useful alt text.
- Lightbox keyboard behavior, focus movement, and caption exposure need rendered verification.
- Image links that open larger media should not hide the existence of the destination from assistive technology.

## Print

Recipe print behavior is part of the recipe component contract. Print-only and screen-only content should preserve the same essential information.

## Review Bar

A component can move from `observed` to `approved` only after these checks are known:

- Keyboard operation
- Focus visibility
- Screen-reader names and roles
- Image alt behavior
- Mobile and desktop heading structure
- Reduced-motion or animation impact where relevant
