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
  - bentilden.com/templates/_components/global-header.twig
  - bentilden.com/templates/_components/global-header-nav-mobile.twig
  - bentilden.com/templates/contact.twig
  - bentilden.com/templates/_entry-content/recipe/recipe.twig
  - bentilden.com/docs/assets.md
  - bentilden.com/scripts/content-qa.php
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-08
review_status: needs audit
---

# Accessibility

Accessibility is a component contract, not a separate polish pass. These are the current rules the design system should preserve as templates evolve.

## Image Alt Text

- Public editorial images should have meaningful native Craft alt text.
- Templates should render native alt text first, then a safe title or file-name fallback.
- Decorative SVGs inside labeled links or buttons should use `aria-hidden="true"`.
- Visible captions and details do not replace alt text.
- AI-generated alt text should be treated as editable draft content, not as a reason to skip author review.

## Navigation And Dialogs

- Navigation controls need an accessible name; mobile navigation uses visible Menu and Close labels.
- The Personal Index follow-up accepted on 2026-09-28 replaces the inline disclosure with a named modal overlay. Menu exposes `aria-haspopup="dialog"`, `aria-expanded`, and `aria-controls`; the overlay uses `role="dialog"` and `aria-modal="true"`.
- Closed overlay links must leave the keyboard sequence. When open, focus remains inside the overlay, the background is excluded, and page scrolling is locked. Close/Escape returns focus to Menu without moving the underlying page. The 24 px Close icon sits within a target at least 44 px high.
- Preserve a meaningful current-page state and the same CMS destinations across desktop and mobile. The former mobile `Posts` heading is not part of this pattern.
- Source inspected on 2026-09-28 uses Alpine teleport and `x-trap.inert.noscroll.noreturn`, with explicit focus return. The `.inert` modifier applies `aria-hidden` background isolation, not the native `inert` attribute. Desktop resize closes the overlay and focuses the visible home link; page restoration resets it without requesting focus. Equivalent inline `noscript` links remain available. All 27 updated local navigation checks passed; see [Navigation](../components/navigation.md#review-evidence) for scope and assistive-technology limits. Historical disclosure checks remain separate.
- The photo viewer and recipe nutrition retain their own focus and modal contracts.

## Focus Appearance

Scoped first-release review, 2026-09-28: `bentilden.com/templates/_layout.twig` at released website `b1cf61e` tracks input mode in the existing body Alpine state. With Alpine active, focus outlines and Tailwind rings are suppressed until Tab or Shift+Tab is pressed; pointer interaction suppresses them again. Keyboard mode permits the existing native/component focus treatment rather than replacing it. The suppression selector requires the Alpine-bound attribute, so existing focus styling remains when JavaScript or Alpine is unavailable. Focus itself, navigation order, and focus return are unchanged. This is an implementation observation, not a completed assistive-technology audit.

## Color And Contrast

The contrast follow-up approved on 2026-09-28 uses Slate 600 for small text on light surfaces, 12 px Micro type for editorial dates/image details, and Slate 400 copyright text on the dark footer. Counts inherit their parent text color without reduced opacity. Functional category icons use solid Slate 500 with Slate 700 hover, and large drop caps use Slate 500.

Contact fields use Slate 500 resting borders and Slate 700 focus borders/rings. The Places Map | Posts switcher uses a reversed selected state—white text on Slate 900, without an underline—distinct from inactive Slate 600 text and Slate 200 hover. Decorative section rules retain their accepted visual hierarchy; they are not substitutes for visible functional control boundaries.

Review actual rendered colors and backgrounds, including opacity, gradients, hover, selection, keyboard focus, and dark surfaces. A palette ratio or a passing automated sample does not establish complete accessibility conformance.

Scoped local verification, 2026-09-28: all 38 focused Chromium checks passed on the uncommitted website/frontend changes above `b1cf61e` / `f3f709f`. Twenty checks sampled editorial dates, photography/cooking icons, drop caps, contact boundaries/focus, and footer copyright at 320/390/1280 px. Eighteen sampled Places selection/hover, counts, captions, totals, keyboard switching, and no-JavaScript selection at 390/1440 px. Those checks used the initial underline treatment. The later reversed-color correction passed four desktop/mobile cases and two no-JavaScript routes, plus keyboard switching/focus checks and scoped Map/Posts release QA; see [Places](../patterns/places.md#navigation-and-views). No runtime errors were reported. Image/recipe detail typography remains source-only verification because matching metadata was absent from the sampled live fields; other category SVG variants were inspected in source. These checks do not replace screen-reader or physical-device review. A separate seven-route release run passed content, asset/environment, build, and font checks but failed browser QA on an external Google DNS error at `/recipe-search-engine`; no full release pass is claimed. Related guidance lives in [Color](../foundations/color.md), [Typography](../foundations/typography.md), [Forms](../components/forms.md), and [Places](../patterns/places.md).

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
- Lightbox visible captions should come from caption/details, not alt text.
- Lightbox keyboard behavior and focus movement still need rendered verification.
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

## Related Pages

- [Navigation](../components/navigation.md), [Galleries](../components/galleries.md), [Forms](../components/forms.md), and [Recipe Content](../components/recipe-content.md) record component-specific requirements and open checks.
- [Render Audit](../audit/render-audit.md) contains historical browser findings; its missing temporary artifacts limit what can be verified from that pass.
- [Content QA](../operations/content-qa.md) covers authored content checks that complement interaction testing.
