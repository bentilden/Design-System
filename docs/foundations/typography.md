---
title: Typography
type: foundation
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com-css/src/bentilden.css
  - bentilden.com-css/src/elements/type.css
  - bentilden.com-css/src/fonts/inter/inter.css
  - bentilden.com/templates/_layout.twig
  - bentilden.com/templates/_components/entry-header.twig
  - bentilden.com/templates/_matrix/text.twig
  - bentilden.com/templates/_matrix/featuredImage2.twig
classes:
  - font-sans
  - font-display
  - font-micro
  - text-xs
  - bt-dropcap
accessibility:
  reviewed: false
  notes: Metadata and drop-cap source changes are recorded below; broader heading and assistive-technology review remains separate.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Typography

Inter is the website typeface for text, display and compact metadata. It was deployed and verified on 2026-10-20, preserving the existing style and lighter homepage statement.

## Font Families

| Role | Tailwind token | Font family |
| --- | --- | --- |
| Body | `font-sans` | `InterVariable`, then Arial and system sans fallbacks |
| Display | `font-display` | `InterVariable`, default weight 900 |
| Metadata | `font-micro` | `InterVariable`, default weight 500 |
| Code | n/a | System monospace stack |

!!! note "Webfont licensing"
    The website self-hosts complete Inter variable fonts under the SIL Open Font License. The Interface Field Guide retains licensed Helvetica Now webfont files from `https://cdn.bentilden.com/fonts/helvetica-now/`. The documentation uses Text for prose, Display for headings, and Micro for navigation, metadata, and interface labels.

## Helvetica Baseline Inventory

Scoped source verification, 2026-10-20: `bentilden.com-css/src/elements/type.css` declares all 48 supplied WOFF2 faces, each with its own upright or italic file. The current weight mappings are:

| Weight | Name | Text | Display | Micro |
| ---: | --- | :---: | :---: | :---: |
| 250 | Hairline | — | Yes | — |
| 275 | Thin | Yes | Yes | — |
| 300 | Extra Light | Yes | Yes | Yes |
| 325 | Light | Yes | Yes | Yes |
| 400 | Regular | Yes | Yes | Yes |
| 500 | Medium | Yes | Yes | Yes |
| 700 | Bold | Yes | Yes | Yes |
| 800 | Extra Bold | Yes | Yes | Yes |
| 900 | Black | Yes | Yes | — |
| 950 | Extra Black | — | Yes | — |

Every supplied Helvetica weight has a matching true italic. There is no supplied Helvetica 600/Semibold face. The lighter values reflect this site's explicit CSS mappings: `font-hairline` 250, `font-thin` 275, `font-extralight` 300 and `font-light` 325. `font-normal`, `font-medium`, `font-bold`, `font-extrabold` and `font-black` select 400/500/700/800/900; `font-extrablack` and `font-display` select 950 in the development Helvetica comparison and 900 in the current Inter default. `font-micro` sets 500. The baseline inventory describes the retained original files; it does not limit Inter’s continuous weight range.

## Inter Default

Scoped production review, 2026-10-20: runtime `deb1475` and frontend `9abf647` make Inter the default across environments, verified in production release `20261021005556`. The previous dev-only Inter gate is removed. Only the `?typeface=helvetica` comparison requires Craft `dev`; other environments always use the source Inter profile. Production uses the same complete vendor files as the local comparison.

Complete upright and true-italic variable WOFF2 files preserve weight 100–900, optical size 14–32, character variants, stylistic sets, alternate figures, fractions and other original OpenType features. Automatic optical sizing is enabled and synthesis is disabled. Optional features remain available rather than being globally activated; tabular-number utilities continue to apply. Inter has no dedicated Micro drawing. Frontend `src/fonts/inter/` owns the full files and SIL Open Font License; builds copy them unchanged to runtime `web/assets/fonts/inter/`.

The homepage statement uses `font-home-statement`, backed by `--font-weight-home-statement: 100`. This visually matches the finer strokes of the live Helvetica Display Thin 275 more closely than Inter 275. The dev Helvetica comparison restores 275 for this role. Other `font-thin` uses retain 275. Section headings stay 800, post titles 900 and prose 400. Default ExtraBlack is 900. Sizes, leading, tracking, colors and alignment are retained, with natural family-specific wrapping. Viewer/map chrome inherit the selected family.

Local Chromium verified 24 route/width comparisons at 320/390/1440 px, allowing only statement 275 → 100 and ExtraBlack 950 → 900 weight differences. Both full served-font hashes, native intermediate weights/italics, tabular figures and viewer inheritance passed. All 95 homepage checks and generic font/browser checks passed. Desktop/phone specimens were compared with the live Helvetica treatment. Previous trial checks cover navigation, recipes and viewer interactions; those suites were not repeated for the default/statement follow-up. This does not establish improved page speed, universal reading quality or new cross-browser/accessibility coverage. Production verification additionally passed twelve route/width observations, both complete WOFF2 hashes/MIME/cache headers, native variable italics, viewer inheritance, four generic browser routes, and all 99 homepage checks. The whole-page review date is retained.

## Type Roles

### Article Title

```html
<h1 class="font-display font-black text-5xl mb-3 leading-none">
  <a href="{{ url }}">{{ title }}</a>
</h1>
```

Use the display face for entry titles and major editorial headings. Keep line-height tight.

The [post-title weight chosen on 2026-10-17](../components/article-content.md#entry-header) uses `font-black` (900) in the shared entry header; the current Inter `font-display` default is 900 (950 in the development Helvetica comparison). A 2026-10-20 production browser spot check confirmed 900 on `/recipe-search-engine`; the original undeployed marker no longer describes that sampled route.

### Metadata

```html
<p class="font-micro text-xs uppercase tracking-widest text-slate-600 mt-4 mb-8">
  Posted {{ postDate | date('M d, Y') }}
</p>
```

Local refinement, 2026-10-18: the owner restored entry-specific title/date placement. The Micro date example above records the preceding styling. Post titles use Display Black 900 at 48 px with inherited letter spacing. Subsequent manual edits changed publication dates to normal body Text at 16 px with the Posted prefix, 20 px top margin, and 40 px bottom margin. The current local palette trial uses Neutral 600 for these dates. The intervening 60/72 px title, tightened tracking, and normal-case date experiment is superseded. Placement follows the entry layout. Subsequent mobile refinement centers every post title/date below 768 px through the shared header; desktop text alignment is inherited from the entry layout. The topic icon/label stays centered above it. See [Entry Header](../components/article-content.md#entry-header).

Use the Micro family at 12 px (`text-xs`) with Slate 600 for compact metadata and image details; shared post dates use the Text exception above. Uppercase tracking provides the quiet metadata treatment without relying on a very small size or pale foreground.

### Prose

```html
<div class="bt-text max-w-prose prose prose-p:leading-relaxed prose-li:my-1">
  {{ block.text|typogrify }}
</div>
```

Long-form content uses Tailwind Typography with `max-w-prose` to keep line length readable.

## Drop Cap

The author-supplied `bt-dropcap` class remains a content hook in stored rich text. Its styling is applied by inline descendant utilities on the `_matrix/text.twig` wrapper, so existing content needs no migration.

```html
<div class="bt-text max-w-prose prose [&_.bt-dropcap]:first-letter:text-[5.25em] [&_.bt-dropcap]:first-letter:leading-[0.9] [&_.bt-dropcap]:first-letter:font-bold [&_.bt-dropcap]:first-letter:text-neutral-500 [&_.bt-dropcap]:first-letter:mr-3 [&_.bt-dropcap]:first-letter:float-left">
  ...
</div>
```

Use the hook only on narrative openings. The bold Neutral 500 letter uses `5.25em` with `0.9` line-height, scaling to the surrounding prose. With the sampled 16 px body text, this computes to 84 px type and a 75.6 px line box. The float and 12 px right spacing wrap body text around the initial. In the current local trial, the former negative 12 px bottom margin is removed. Firefox also receives a 0.1em top margin through a `supports-[-moz-appearance:none]` descendant utility; the owner reports the reviewed Firefox example now looks fixed; broader Firefox coverage remains unverified.

Scoped source review, 2026-09-28: uncommitted changes above website `b1cf61e` and frontend `f3f709f` update shared/listing dates, matrix/recipe image details, and the rich-text wrapper. The unused `.bt-datePublished`, `.bt-image-details`, and `.bt-dropcap` CSS definitions are removed; stored `bt-dropcap` content hooks remain supported by the template. Local Chromium checks at 320/390/1280 px verified the 12 px dates and large drop caps. Date contrast is 6.15–7.25:1 across the article gradient endpoints; actual drop-cap background samples measured 4.21–4.40:1. Image/recipe details remain source-only verification because the sampled live fields had no matching metadata. The earlier page review date is retained because unrelated type and heading behavior was not re-audited.

Scoped alignment refinement, 2026-09-28: the inline rich-text wrapper replaces the earlier fixed 90 px / unit line-height treatment with the relative size and tighter line-height above. Local Chromium checks at 320/390/1280 px found no overflow; visual inspection at 390 px showed the glyph top aligned with the first text line and its bottom at the third-line baseline. The earlier contrast checks retain their original scope. The implementation agent also reviewed before/after crops at all three widths, and the coordinating agent inspected the 320/390 px results. These checks do not establish cross-browser, physical-device, or assistive-technology coverage.

Scoped Firefox investigation, 2026-10-18: the owner reports that the drop cap on `/recipe-search-engine` no longer spans three text lines in Firefox. Runtime `be1a8a2` retains the 5.25em / 0.9 / -12 px floated-first-letter geometry; recent post-header changes did not alter it. Chromium checks at 390/1280 px still show three-line wrapping, including a temporary zero-bottom-margin experiment. Firefox automation could not initialize in the local macOS environment, so neither reproduction nor a Firefox fix is established. Mozilla's [first-letter sizing discussion](https://bugzilla.mozilla.org/show_bug.cgi?id=290125) supports float/margin sensitivity as a candidate mechanism, not proof of a current browser defect. Verify the zero-margin alternative in actual Firefox before changing the shared styling.

Owner-authorized margin trial, 2026-10-18: local uncommitted runtime changes above `be1a8a2` remove the negative first-letter bottom-margin utility from the shared Text renderer. Chromium 148 and WebKit 26.4 paragraph screenshots and character positions were identical before/after within each engine on four real posts and two fixtures at 390/1280 px (24 route/width/engine comparisons). The 84 px font, 0.9 line-height, color and right spacing are retained. This is a local review trial; it does not yet establish a Firefox fix or a deployment.

Firefox alignment follow-up, 2026-10-18: the owner’s follow-up screenshot shows three lines wrapping after margin removal, but the initial remains above the adjoining text’s cap height. A local trial adds `supports-[-moz-appearance:none]:[&_.bt-dropcap]:first-letter:mt-[0.1em]` (about 8.4 px at the current 84 px size). The compiled rule is enclosed in `@supports ((-moz-appearance:none))`; Chromium and WebKit do not match that condition. A bounded attempt to start an isolated visible Firefox window also failed locally, so the adjustment requires owner Firefox review rather than being marked verified.

Owner Firefox review, 2026-10-18: after the 0.1em top-margin adjustment, the owner reported that `/recipe-search-engine` looks fixed. This supplies a visual spot check of the reported example; the earlier automated Firefox startup limitation and broader verification limits remain. The change is local and uncommitted.

Commit record, 2026-10-18: the owner approved and requested committing the drop-cap correction, now saved locally in runtime `9df63e7`. Earlier uncommitted/trial descriptions record the state at verification time. Owner Firefox confirmation and the unchanged Chromium/WebKit comparisons retain their separate scopes. No push or deployment was performed.
