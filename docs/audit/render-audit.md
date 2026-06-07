---
title: Render Audit
type: audit
status: observed
source_of_truth: audit finding
audience:
  - design
  - development
source:
  - https://www.bentilden.com/
  - https://bentilden.com.ddev.site/
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: active
---

# Render Audit

The first render audit used Playwright to inspect representative dev and prod pages. Some findings have since been addressed in source; this page now separates rendered observations from current follow-up work.

## Scope

| Environment | Pages | Viewports |
| --- | --- | --- |
| Dev | `/`, `/photography`, `/cooking`, `/design`, `/about`, `/contact`, `/the-gherkin`, `/kyoto-in-fall`, `/kinkaku-ji-golden-pavilion`, `/recipe-search-engine` | Desktop and mobile |
| Prod | `/`, `/photography`, `/cooking`, `/design`, `/about` | Desktop |

Initial `curl` checks saw a transient `503` from production, but the subsequent Playwright pass returned `200` for all sampled prod pages.

## Summary

| Metric | Result |
| --- | ---: |
| Page/viewport checks | 25 |
| Successful responses | 25 |
| Failed requests | 0 |
| Horizontal overflow cases | 0 |
| Console warning cases | 2 |
| Missing/empty image alt attributes in first snapshot | 52 |

The two console warnings were Chromium GPU `ReadPixels` warnings during screenshots, not site JavaScript errors.

## Accessibility Findings

| Finding | Current status | Recommendation |
| --- | --- | --- |
| Image alt coverage was incomplete in the first render sample. | Template fallbacks now exist, but native asset alt text is still missing broadly. | Keep fallback logic and clean up native asset alt text. |
| Mobile menu button had no accessible name in the first render sample. | Current source includes `aria-label`, `aria-controls`, and `aria-expanded`. | Re-run rendered audit to verify browser output and focus behavior. |
| Mobile dialog has basic ARIA metadata. | Current source also uses Alpine focus trapping. | Verify focus trap, escape handling, return focus, and hidden-state behavior. |
| Heading counts need accessibility-tree verification. | Still open. | Confirm hidden Alpine content is not exposed to assistive technology when closed. |

## Responsive Findings

| Finding | Evidence |
| --- | --- |
| No horizontal overflow in audited viewports. | `maxScrollWidth` matched viewport width across sampled pages. |
| Stream pages adapt cleanly to mobile. | Desktop side-by-side media/text stacks into single-column article flow. |
| Footer remains consistent across pages. | Same footer links and Slate 900 band observed in all sampled pages. |
| Contact is an outlier. | Contact page renders as `article.pt-12.pb-14` with no `bt-article` hooks. |

## Visual Pattern Findings

| Pattern | Evidence |
| --- | --- |
| Article stream | Home/category pages are stacked sequences of `bt-article` blocks. |
| Photography galleries | `bt-control-gallery2`, `bt-control-image`, and `bt-image-file` dominate rendered class counts. |
| Featured image entries | `bt-control-featuredImage2` appears frequently and needs first-class documentation. |
| Recipe intro pages | Present in dev sample and now documented as part of the recipe component. |
| Metadata typography | Dates and image details use micro text, uppercase, wide tracking, and low-contrast Slate. |

## Page-Level Notes

| Page | Notes |
| --- | --- |
| `/` | Prod and dev share the same stream template but content differs. |
| `/photography` | Highest image density in the sample; strongest candidate for gallery and image-card guidance. |
| `/cooking` | Dev includes recipe intro pages; prod sample showed story/featured-image entries. |
| `/design` | Compact gallery stream, visually consistent between dev and prod. |
| `/about` | Uses article shell without an Area of Interest icon. |
| `/contact` | Uses a custom form layout and should become a documented form pattern or an explicit exception. |

## Local Artifacts

Temporary screenshots and `results.json` are available locally at:

```text
/private/tmp/bentilden-design-system-audit
```
