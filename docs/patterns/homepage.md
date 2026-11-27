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

## Homepage Evolution

Partial production review, 2026-11-26: runtime `87b6ac9` deploys the presentation and layout-control configuration below. Production content was preserved: Photo strip and Story and Cheat Sheet collection are available choices, while the saved Mosaic and Feature list selections remain until the owner changes them. The older observations below describe the preceding presentation.

- `homePhotoLayout` adds **Photo strip** (`strip`): three equal images with captions, cropped at 2:3 below `lg` and 1:2 from `lg`, with the same three-image/short-copy eligibility as Mosaic. Other selections retain the natural-grid fallback. Strip does not force shared height with Work. Paired Mosaic shares its heading/media rows with Work and reserves a third row for the discovery links. The owner retained the taller desktop photographs on 2026-11-26 and subsequently restored the secondary Work story to its previous size: later imaged projects use the original 2:3 image/text column split on desktop. At 640–1023 px, Work uses two columns and matching 1.6:1 media frames with contained, uncropped artwork.
- The photo section exposes Map, Mosaic and Posts through native discovery links. By color keeps the palette icon and uses horizontal spectrum-gradient text. Discovery links have no arrows. Other homepage arrows retain the existing Lucide `arrow-right` geometry.
- `homeCookingLayout` adds **Story and Cheat Sheet collection** (`editorial`). The first non-Cheat Sheet placement leads, with no overlaid format label on its image; selected Cheat Sheets appear in a black reference collection; remaining placements become resources in a separate row below the lead/reference pair. Resources use two columns from `sm` and the shared desktop tracks from `lg`; their height does not set the lead row height. References use two columns at 768–1023 px, reverting to one on desktop. Each group retains authored order. The lead and reference rows resolve their images once; supporting text resources skip image lookup. Reference rows use 64 px squares below 400 px, 96 px at 400–639 px, 128 px from `sm`, compact 40 px squares from `lg` (1024 px) through 1535 px, and 128 px again from `2xl` (1536 px). They display the selected/inherited photograph or a book icon: 20 px in the compact range and 32 px elsewhere. Squares and text align at their vertical centers, following the owner's final alignment choice. The responsive square-size refinement is runtime `af66930`. Native image-hide, cover, crop and alternative-text overrides remain available. Missing/empty groups collapse naturally. The same native field overrides, draft-preview behavior and publication/stream rules remain in force; no unpublished-content placeholders are rendered.
- Individual photo, project, food, reference and recent-post links have no arrows. Arrows are reserved for section browse/explore links, including Explore cheat sheets. Photo, Work and lead Food image surfaces use a transparent 2 px border, changing to white with the established neutral shadow on fine-pointer hover. Reduced motion sets `transition-property: none`.
- The statement is 44/56/72 px with 21 px opening padding. Recent rows add content-format labels. The RSS icon and Follow along via RSS link replace the existing shared footer link; they do not appear below the recent list. Site Settings retains control of the RSS label.

Paired-section divider refinement, 2026-11-26: from `lg`, Photography/Work and both two-column Kitchen arrangements use the same 8:5 tracks and 40 px gutter from `_home/layout.twig`. A decorative 1 px Neutral 200 vertical rule spans the paired band and is positioned absolutely at the gutter center. It consumes no grid space, so the column edges align with Kitchen whether the rule is present or removed. The rule is hidden for stacked sections and ignored by assistive technology. Authored order is preserved; the leading column remains the wider track. This follow-up is deployed in runtime `3b17851`; the reference-square refinement entered production in `81f477d`.

Browse placement follow-up, 2026-11-26, runtime `8bee65f`: Recently added now uses the same shared header as every other section at all widths. One archive link stays beside/beneath the heading, including when the list is empty; the separate mobile link after the list is removed. The isolated renderer passed 52 fixtures, and 568 local homepage checks passed across 22 widths.

Owner-selected recent-list refinement, 2026-11-26: from `md`, columns read Date → Type → Title. Date and type use compact 8 rem/6 rem tracks with 24 px gaps; type is left aligned rather than placed at the far page edge. With dates hidden, the order is Type → Title. Phones retain date/type above the title. Source: deployed `_home/recent.twig` and generated CSS; desktop coordinates and phone wrapping were reviewed before release.

Responsive follow-up, 2026-11-26: section browse links consistently follow headings below 480 px. The tablet Work/reference arrangements and separate supporting-resource row above are deployed in runtime `881e58e`; the 1024–1535 px compact reference squares and 1536+ large squares remain. Only narrow phones reduce to 64 px, with smaller panel padding and image/text gaps. The Recent table now begins at 768 px. The exact stylesheet referenced by the live homepage matches the committed build. All 590 public-homepage Chromium checks passed at 22 widths from 320 to 1920 px, with no horizontal overflow; phone, tablet and desktop layouts were visually reviewed. The isolated renderer passed 52 fixtures. This remains a partial review, without new physical-device or other-engine coverage.

Kitchen presentation release, 2026-11-26, runtime `5e97990`: the owner preferred the deployed Kitchen arrangement after reviewing Reference band. Dev has been restored to the lead/reference pair followed by the supporting-resource row described above; the Reference band trial was never deployed. The approved spacing correction adds a 20 px gap between desktop supporting-story rows from `lg`, balancing the existing 20 px below each divider without adding a gap after the final row or changing the shared column alignment. Source: deployed `editorial.twig`. This release also increases the dark Cheat Sheets panel’s horizontal insets by 4 px for optical balance with its heading/footer: 20/24/28 px horizontally versus 16/20/24 px vertically below 400 px, from 400 px, and from `md` respectively. Icon/photo square dimensions remain unchanged. The owner then requested equal-width supporting-story columns: this independent list now keeps two equal tracks from `sm`, a 40 px desktop gutter, and the 20 px desktop row gap. The lead/reference pair retains the shared 8:5 tracks.

Photo strip release, 2026-11-26, runtime `5e97990`: `photography.twig` now honors Strip with one, two, or three imaged features, using that many columns. Descriptions, small labels, action text and long titles remain below the cropped media without overriding the layout. Strip titles keep uniform caption sizing and 8 px image spacing. Two/three-image strips retain 2:3 crops below `lg` and 1:2 crops from `lg`; one image retains 2:3 and a 28 rem maximum width. Image `sizes` follows the selected count. Empty/extra selections and missing/hidden images retain natural-grid fallbacks; Mosaic's existing eligibility remains unchanged. This supersedes Strip’s initial three-image/short-copy restrictions above. Verification passed 84 renderer fixtures and 256 isolated Strip browser combinations across eight widths; the final approved Kitchen/homepage composition passed 579 checks across 22 local widths. Native content was not changed. The alternate selections use isolated Twig output with synthetic media; this is not physical-device or other-engine coverage.

Release verification, 2026-11-26: all 598 public-homepage browser checks passed across 22 widths, and the live versioned CSS matches runtime `5e97990`. Public homepage and RSS content were unchanged. The rejected dark icon/text control is retained only as a reference in [Buttons](../components/buttons.md#icon-and-text-link-pattern).

Header and wide-list presentation release, 2026-11-26, runtime `95d5803`: Photography replaces its single section browse link with Browse: plus On the map / By color / Travel posts in the section header. The prefix is regular 14 px Neutral 500; links match other section browse links at 14 px / weight 500 / Neutral 600, with Neutral 950 hover and a more saturated spectrum exception for By color. A named inline-size container switches the entire group from a vertical stack to a single row at 25 rem (400 px) of section width, following Food’s jump-menu approach without JavaScript or partial wrapping. Paired secondary Work thumbnails use a 1:2 desktop image/text split instead of 2:3, retaining uncropped artwork and the prior phone/tablet treatments.

The same release gives Recently added two equal columns from `2xl` (1536 px), with a 40 px gutter, newest-first order across rows and aligned row dividers. Below `2xl` it stays a single list; a single result stays full width. Native Date → Type → Title and authored feed controls remain. Production content/post-count changes are excluded; the owner will set the desired count in Craft. Local verification passed 90 renderer fixtures and 625 browser checks across 22 widths with six authored Dev posts. The live header, smaller thumbnail, row-or-stack browsing and two-column boundary are verified; native content/count settings were not written by the release.

Source: `_home/preview.twig`, `photography.twig`, `paired.twig`, `work.twig`, `cooking.twig`, new `editorial.twig`/`editorial-item.twig`, `recent.twig`, native dropdown configuration and `modules/homepage/Schema.php`. The renderer guide in `templates/_home/README.md` maps native field handles to output. Local fixtures cover old/new presets and mixed/reference-only/no-image compositions; browser checks cover responsive rendering, focus, no-JavaScript navigation and hover/reduced-motion behavior. This is not a full accessibility audit.

## Content Controls

The existing Homepage single in Craft owns the statement, introduction, and section list. Authors can order, enable, or remove Photography, Work, Cooking, and Recently Added sections. Each kind can appear once, including disabled sections. The Sections tab also controls whether adjacent Photography and Work sections pair on desktop; their authored order is preserved.

Curated features reference published posts in the corresponding Area of Interest: Photography, Design for Work, or Cooking. Posts hidden from streams are ineligible. A placement may override the title, description, image, crop position, alternative text, small label, action text, and destination without changing the source post. Description choices are inherit, custom, and hide; image choices are inherit, existing-image override, and none.

Recently Added selects 1–12 published posts, newest first, with optional area filters, dates, and exclusion of already featured posts. Other section browse links have editable destinations and labels; an empty browse field hides them. Photography’s approved header treatment uses its three fixed discovery destinations instead of the single section browse link. See [Craft Structure](../content-model/craft-structure.md#homepage-composition) for field ownership.

## Responsive Composition

| Element | Composition rule |
| --- | --- |
| Desktop pair | From `lg`, paired features and two-column Kitchen arrangements share 8:5 tracks and a 40 px gutter. Authored order is preserved, with the leading column wider. The paired divider is outside grid flow. Nonadjacent sections and the stacked preset remain separate. |
| Photography mosaic | Exactly three imaged features with titles up to 48 characters and no description, small label, or action text. The lead spans both rows; column and row proportions are 3:2, with 12 px gutters increasing to 16 px from `sm`. Photographs crop using the selected position. |
| Shared mosaic height | When paired with two imaged Work features, the mosaic follows Work's natural height from `lg`. The outer edges align without a fixed desktop height. |
| Photography strip | One to three imaged features use that many equal columns. Caption copy remains below media; a single image is capped at 28 rem. |
| Photography fallback | Mosaic selections outside its count/copy rules, Strip counts outside 1–3, or missing images use a natural grid retaining every feature. Rich natural-grid copy gets one column below `sm`; short titles can use two. |
| Work | The paired layout uses a large lead and compact image/text rows for later imaged projects, with a 1:2 image/text split on desktop. Artwork keeps its full proportions. |
| Cooking | Choose a lead feature with resource links or equal cards. Missing images leave text content without placeholder media. |
| Recently Added | Native date/type/title rows with one column below 1536 px, two equal columns above, a 40 px gutter, and newest-first order across rows. A single result stays full width. The archive link remains in the shared section header, below its heading under 480 px and alongside when space permits above that. |

Mobile follows the authored section order. Pairing never moves sections past intervening content. Longer Mosaic copy switches to natural height instead of truncating text; Strip retains its columns with caption copy below its images.

## Typography And Interaction

Deployed follow-up, 2026-11-24, runtime `c3b955d` included in combined release `417ae70`: use the shared [preview title/summary sets](../foundations/typography.md#preview-title-and-summary-sets). Work leads and ordinary cards use Standard; compact Work rows and secondary Food links use Compact; equal Food cards use Standard; the lead feature/list Food item uses Featured. Photography with a description uses Compact, while title-only mosaic captions keep their existing small responsive role. Native field overrides, omission rules, layout selection and links remain unchanged.


Typography release, 2026-10-17: the statement uses Helvetica Now Display Thin (`font-thin`, **275**) at **44 px**, **66 px** from `md`, and **88 px** from `lg`, with **1.06** line height and **−0.0125 em** letter spacing. Statement and introduction use Slate 500 (`text-slate-500`). The introduction has a **50ch** maximum width (`max-w-[50ch]`) at every breakpoint, constrained by the available width. Section headings use Display ExtraBold (`font-extrabold`, **800**) at 30 px. The heading-to-content gap remains 12 px, increasing to 24 px from `md`; major sections remain 48 px apart, increasing to 64 px.

Scoped production update, 2026-10-20: Inter is now the deployed default. The statement uses `font-home-statement` at 100 to match the lightness of live Helvetica Display Thin 275. Sizes 44/66/88 px, leading 1.06, tracking −0.0125 em and the current Neutral 500 color remain. Section headings stay 800. This supersedes the family/weight treatment above. Runtime `deb1475` / frontend `9abf647` are verified in production release `20261021005556`: all 99 public homepage checks and twelve production route/width typography observations passed, with no sampled overflow. Earlier local checks covered 24 baseline comparisons. See [Inter Default](../foundations/typography.md#inter-default).

Scoped evidence: runtime `cf236e0` updates `templates/_home/preview.twig` and `templates/_home/heading.twig`, with generated CSS; frontend `8776744` includes the updated homepage browser checks. The existing faces are declared in `bentilden.com-css/src/elements/type.css`. Local and production browser checks at 390/768/1024/1440 px verified the final typography without horizontal overflow, and production deployment matches the committed template and CSS files. The desktop header was visually reviewed, and all 98 production homepage browser checks passed, including navigation without JavaScript. This is a partial typography review; the page-wide review date remains unchanged.

Keep links native, with visible keyboard focus. The first keyboard link skips to homepage content. Browse links have a 44 px minimum height. Underlines belong to text-only spans so arrows remain plain; decorative arrows are hidden from assistive technology. New-tab destinations announce that behavior. The page content and destinations remain available without JavaScript.

Deployed update, 2026-11-26, runtime `b61c3fd`: homepage browse and explore links use a **4 px** label-to-arrow gap. The full-width Explore cheat sheets link keeps its native hit area while the arrow sits beside its label. See [Directional arrows in links](../components/icons.md#directional-arrows-in-links).

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
