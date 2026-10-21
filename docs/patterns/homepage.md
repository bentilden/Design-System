---
title: Homepage
type: pattern
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/index.twig
  - bentilden.com/templates/_home
  - bentilden.com/modules/homepage/Schema.php
  - bentilden.com/modules/homepage/Rules.php
  - bentilden.com/modules/homepage/HomepageVariable.php
  - bentilden.com-css/src/bentilden.css
  - bentilden.com-css/scripts/qa-homepage-preview-browser.mjs
owner: Documentation owner
created: 2026-09-29
last_reviewed: 2026-09-29
review_status: active
accessibility:
  reviewed: false
  notes: Local Chromium checks cover keyboard navigation, responsive layout, and no-JavaScript links; a full accessibility audit remains separate.
---

# Homepage

The homepage at `/` introduces the site's interests through selected Photography, Work, and Cooking features, followed by a compact recent-post list. The complete chronological stream lives at [`/archive`](stream-pages.md). The signature and navigation remain part of the shared [site chrome](../components/navigation.md).

## Content Controls

The existing Homepage single in Craft owns the statement, introduction, and section list. Authors can order, enable, or remove Photography, Work, Cooking, and Recently Added sections. Each kind can appear once, including disabled sections. The Sections tab also controls whether adjacent Photography and Work sections pair on desktop; their authored order is preserved.

Curated features reference published posts in the corresponding Area of Interest: Photography, Design for Work, or Cooking. Posts hidden from streams are ineligible. A placement may override the title, description, image, crop position, alternative text, small label, action text, and destination without changing the source post. Description choices are inherit, custom, and hide; image choices are inherit, existing-image override, and none.

Recently Added selects 1–12 published posts, newest first, with optional area filters, dates, and exclusion of already featured posts. Section browse links have editable destinations and labels. An empty browse field hides the link. See [Craft Structure](../content-model/craft-structure.md#homepage-composition) for field ownership.

## Responsive Composition

| Element | Composition rule |
| --- | --- |
| Desktop pair | From `lg`, Photography receives five shares and Work three, with a 21 rem minimum for Work. The gutter is 32 px, increasing to 48 px from `xl`. Nonadjacent sections and the stacked preset remain separate. |
| Photography mosaic | Exactly three imaged features with titles up to 48 characters and no description, small label, or action text. The lead spans both rows; column and row proportions are 3:2, with 12 px gutters increasing to 16 px from `sm`. Photographs crop using the selected position. |
| Shared mosaic height | When paired with two imaged Work features, the mosaic follows Work's natural height from `lg`. The outer edges align without a fixed desktop height. |
| Photography fallback | Other counts, missing images, or longer copy use a natural grid that retains every feature. Rich copy gets one column below `sm`; short titles can use two. |
| Work | The paired layout uses a large lead and compact image/text rows for later imaged projects. Artwork keeps its full proportions. |
| Cooking | Choose a lead feature with resource links or equal cards. Missing images leave text content without placeholder media. |
| Recently Added | Compact rows with optional dates. The archive browse link appears after the list below `md` and beside the heading from `md`. |

Mobile follows the authored section order. Pairing never moves sections past intervening content. Longer photo copy switches to natural height instead of truncating text to preserve the mosaic.

## Typography And Interaction

Typography release, 2026-10-17: the statement uses Helvetica Now Display Thin (`font-thin`, **275**) at **44 px**, **66 px** from `md`, and **88 px** from `lg`, with **1.06** line height and **−0.0125 em** letter spacing. Statement and introduction use Slate 500 (`text-slate-500`). The introduction has a **50ch** maximum width (`max-w-[50ch]`) at every breakpoint, constrained by the available width. Section headings use Display ExtraBold (`font-extrabold`, **800**) at 30 px. The heading-to-content gap remains 12 px, increasing to 24 px from `md`; major sections remain 48 px apart, increasing to 64 px.

Scoped production update, 2026-10-20: Inter is now the deployed default. The statement uses `font-home-statement` at 100 to match the lightness of live Helvetica Display Thin 275. Sizes 44/66/88 px, leading 1.06, tracking −0.0125 em and the current Neutral 500 color remain. Section headings stay 800. This supersedes the family/weight treatment above. Runtime `deb1475` / frontend `9abf647` are verified in production release `20261021005556`: all 99 public homepage checks and twelve production route/width typography observations passed, with no sampled overflow. Earlier local checks covered 24 baseline comparisons. See [Inter Default](../foundations/typography.md#inter-default).

Scoped evidence: runtime `cf236e0` updates `templates/_home/preview.twig` and `templates/_home/heading.twig`, with generated CSS; frontend `8776744` includes the updated homepage browser checks. The existing faces are declared in `bentilden.com-css/src/elements/type.css`. Local and production browser checks at 390/768/1024/1440 px verified the final typography without horizontal overflow, and production deployment matches the committed template and CSS files. The desktop header was visually reviewed, and all 98 production homepage browser checks passed, including navigation without JavaScript. This is a partial typography review; the page-wide review date remains unchanged.

Keep links native, with visible keyboard focus. The first keyboard link skips to homepage content. Browse links have a 44 px minimum height. Underlines belong to text-only spans so arrows remain plain; decorative arrows are hidden from assistive technology. New-tab destinations announce that behavior. The page content and destinations remain available without JavaScript.

## Where To Edit

Presentation stays in readable Twig partials with literal inline Tailwind utilities. Keep actual Craft handles visible at their output, following the [field traceability rule](../contributing.md#craft-field-traceability). New website behavior follows the [Alpine.js implementation rule](../contributing.md#frontend-implementation-rule).

Rendering release, 2026-10-17, runtime `ad8ae26`: the homepage refactor passes native Craft entries into Twig and removes the `ViewModel.php` page-data normalization. Searching `homeIntroduction` and `homeStatement` leads directly to `_home/preview.twig`. Display queries and simple placement overrides belong in Twig; narrow `craft.homepage` helpers retain draft-aware relations, enabled/public eligibility checks, and native Link validity. The existing `craft.contentImages.previewImage()` retains shared image fallback. Validation and CP editing controls remain in PHP. The refactor is deployed and verified through runtime `816d084` in production release `20261017153152`; the homepage renderer remains identical to `ad8ae26`. The typography evidence above records the preceding separate release.

`preview.twig` resolves each feature's native Post and displayed Asset once, then passes render-local collections to section partials. Layout checks and card markup reuse those objects; scalar fields retain their real handles beside the output. This preserves query reuse without introducing another normalized page-data model.

Local refactor verification passed 95 public-homepage and 90 preview browser checks, 35 isolated renderer checks, and 37 native homepage checks. The isolated cases cover relation/image lookup reuse; desktop and mobile screenshots were visually reviewed. These were predeployment checks of the source later committed as `ad8ae26`. Production subsequently passed all 98 public homepage browser checks at 320/390/768/1024/1440 px, with desktop visual review; native homepage, authoring, and isolated renderer checks passed 37/37, 24/24, and 35/35. Exact deployed source and unchanged authored content were verified. This is not a new full accessibility or authenticated CP editing audit.

| Source under `bentilden.com/templates/` | Owns |
| --- | --- |
| `index.twig`, `_home/page.twig` | Public entry point, shared shell, skip link, and homepage SEO integration. |
| `_home/preview.twig` | Statement, introduction, page width, spacing, and section order. The filename is shared by the public renderer and preview. |
| `_home/heading.twig` | Section type, divider, following gap, and browse links. |
| `_home/paired.twig` | Desktop column proportions and shared mosaic height. |
| `_home/photography.twig`, `_home/work.twig`, `_home/cooking.twig`, `_home/recent.twig` | Section composition and responsive layout. |
| `_home/image.twig` | Responsive image output, usable-variant fallback, and crop-position utilities. |

Adjust image `sizes` when changing geometry. Keep mosaic eligibility checks in `paired.twig` and `photography.twig` consistent. `_home/README.md` includes the renderer contract and focused editing guidance. The `data-home-*` attributes support QA; they do not define styling.

## Implementation And Verification

Reviewed on 2026-09-29 against `bentilden.com` release `5871297` and frontend source at `cc7347b`. Inspected the sources listed above, section partials, `_home/README.md`, and `_archive/index.twig`. The homepage and archive are deployed at `https://www.bentilden.com/`.

Local Chromium checks passed on `/` and `/homepage-preview` at 320, 390, 768, 1024, and 1440 px, including image loading, mosaic alignment, complete Work artwork, keyboard access, native destinations, and no-JavaScript content. Desktop and phone screenshots were visually reviewed. `npm run qa:homepage` passed 93 checks, `qa:homepage-preview` 88, `qa:homepage-launch` 38, and `qa:navigation` 27. The frontend build and all 48 declared font checks passed. These observations do not establish Safari, physical-device, or screen-reader behavior.

Production verification on the same date passed all **98 homepage**, **38 launch HTTP/SEO**, and **27 navigation** checks at `https://www.bentilden.com`. The homepage was checked at the same five widths, with desktop and phone screenshots visually reviewed. Public pages have the expected indexable canonicals; ordinary access to the preview route and an unsigned preview flag both return 404. The [sanitized production QA receipt](../assets/reports/homepage-v1-2026-09-29.json) records source revisions, commands, scope, and limits.

For future changes, exercise paired and stacked layouts, both section orders, each preset, missing or additional items, missing images, and long copy. Run `templates/_home/tests/render-fixtures.php` for the isolated Twig cases and the frontend homepage/browser checks against the running site. Production launch checks require indexable robots and a correct canonical URL; local noindex environments may omit canonicals under the existing SEO policy.
