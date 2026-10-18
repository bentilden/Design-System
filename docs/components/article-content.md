---
title: Article Content
type: component
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_entry-content/default.twig
  - bentilden.com/templates/_components/entry-header.twig
  - bentilden.com/scripts/post-header-layout-qa.php
  - bentilden.com/templates/dev-test/topic-layouts.twig
  - bentilden.com-css/scripts/qa-topic-layouts-browser.mjs
  - bentilden.com/templates/_components/entry-preview-image.twig
  - bentilden.com/templates/_matrix/text.twig
  - bentilden.com/templates/_components/text-content.twig
  - bentilden.com/templates/_partials/entry/captionedImage.twig
  - bentilden.com/modules/content/Images.php
  - bentilden.com/templates/svg/photography.twig
  - bentilden.com/templates/svg/cooking.twig
  - bentilden.com/templates/_matrix/featuredImage2.twig
  - bentilden.com-css/src/components/site.css
classes:
  - bt-article
  - bt-title
  - bt-text
accessibility:
  reviewed: false
  notes: Heading hierarchy, icon semantics, mobile hidden content, and rendered image alt behavior need audit.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Article Content

Local update, 2026-10-18: the approved topic header replaces the previously retained filled category artwork with the CMS-selected [Lucide identity](icons.md). This implementation is uncommitted above runtime `0221ddc` and frontend `f2ff4d5`; it has not been deployed.

Article content is the central pattern for the site. It brings together Area of Interest icons, display titles, metadata, prose, media, and galleries.

## Article Shell

```twig
<article class="bg-neutral-50 pt-8 pb-14 md:pt-12 bt-article bt-article-topic-{{ entryCategory.slug }} bt-article-schema-{{ entry.type }}">
  <div class="px-8 lg:container mx-auto">
    ...
  </div>
</article>
```

The post shell uses a vertical white-to-Neutral-100 gradient during the [Neutral palette trial](../foundations/color.md), spanning the full height of each post. Listing containers add a 1 px Neutral 200 divider only between adjacent articles, as described in [Stream Pages](../patterns/stream-pages.md#visual-rules). The shared post template does not add top/bottom borders to individual posts. About retains its separate Neutral 50-to-200 gradient surface.

Article classes include Area of Interest and entry type hooks:

- `bt-article-topic-photography`
- `bt-article-topic-cooking`
- `bt-article-schema-story`
- `bt-article-schema-gallery`
- `bt-article-schema-featuredImage`
- `bt-article-schema-recipe`

## Entry Header

Local refinement, 2026-10-18: the owner restored the previous title/date presentation and placement. The new centered treatment applies only to the topic icon and label, independently of the title layout.

`_components/entry-header.twig` supplies a Display Black 900 title at 48 px with line-height 1 and the former inherited letter spacing, followed by the owner-edited normal body date (`Posted` plus `M d, Y`) in Neutral 600 with 20 px above and 40 px below. The later manual edits supersede the restored Micro date styling, while placement remains entry-specific. It keeps a semantic `time` and keyboard focus treatment. The earlier 60/72 px title sizing, tightened tracking, and normal-case 16/18 px date experiment are superseded. No reading time is added.

Placement belongs to the entry template and its native settings:

| Entry view | Title/date placement |
| --- | --- |
| Story | Centered within the prose-width column |
| Featured image | Centered above its media/content layout, as before |
| Gallery | Above a centered or inline gallery; within the accompanying text column for left/right thumbnail grids |
| Recipe landing/detail | In the existing five-column introduction/header area beside the image |
| Default | Within its body header |
| About | Retains its own separate heading |

Gallery conditions render the title/date once, including a left/right gallery set to Inline. Recipe detail title links preserve their recipe URL. Category selection, body layouts, and authored alignment values remain native Craft fields.

## Article Icons

`_components/topic-identity.twig` sits above the entry-specific content layout and receives the native related category's `identityIcon`, title, and URL. The icon is 32 px mobile / 36 px desktop inside a 56/64 px Neutral 200 circle. Its Neutral 950 linework uses a fixed 1.5 px visual stroke via non-scaling geometry. The owner-selected 24 px Neutral 400 label begins 10 px below the circle. The group is centered, with 40/48 px below it before the entry-specific content layout.

Icon and visible label form one topic link with a keyboard focus outline. The SVG is decorative and hidden from assistive technology. Hover darkens the label and changes the circle to Neutral 300; the label moves to Neutral 500. If no icon is selected, the visible topic link still renders. The identity group is hidden for print. The default Places icon is plain `map`, matching the supplied reference.

Local verification, 2026-10-18: photo, gallery, recipe landing, and recipe detail views passed centered topic-identity, one-header/date, 48 px title/owner-edited 16 px body date, 900-weight, and no-overflow checks at 320/390/768/1440 px. Ten native unsaved cases verify entry-specific header placement, including all six left/right/center and inline/grid gallery combinations. The restored desktop Kyoto header was visually reviewed. See [Icons](icons.md#verification-scope) for source and delivery evidence. Broader article/a11y audits below retain their earlier scope.

## Topic Layout Review Fixture

`/dev-test/topic-layouts` is available in development and staging with noindex/no-store directives; other environments return 404. It pairs the current shared topic identity and title/date components with eight synthetic compositions: centered story, wide image, portrait image, galleries on the left/right/center, inline gallery, and recipe introduction.

A normal GET form chooses a native CMS topic and standard/long sample title. Each topic's `identityIcon` and title come from its category, so CP selections appear in the fixture. Jump links lead to full-width examples. Prose uses the shared Story Text renderer; media is local inline vector illustration. The layout compositions are representative visual previews, with actual native entry-setting behavior covered separately by `scripts/post-header-layout-qa.php`. Viewing the fixture saves no content.

Local verification, 2026-10-18: all eight compositions passed at 320/390/768/1440 px, including topic/title controls, centered identities, gallery-side placement, one title/date per sample, and no overflow/runtime errors. JavaScript-free form submission and invalid-choice fallback passed. The request guard passed 56 environment/path cases. Mobile and desktop right-gallery examples were visually reviewed. Sources are local uncommitted runtime/frontend changes; no deployment claimed.

## Prose Blocks

The Text renderer retains one `bt-text` prose wrapper and its existing table controller/template. Inside that wrapper, the Captioned image implementation renders markup and nested entries deliberately:

```twig
{% include '_components/text-content' with {
  textValue: block.text,
  ownerEntry: ownerEntry ?? entry ?? null,
  isListing: isListing ?? false,
  prioritizeFirstImage: isFirstBlock ?? false,
} only %}
```

Scoped local source update, 2026-10-04: website `cad9448` on `codex/ckeditor-captioned-image` processes complete rich-text markup through Typogrify once using collision-safe placeholders for embedded entries. Independently rendered [Captioned image](captioned-image.md) HTML is inserted afterward. This preserves authored order and blockquote, list-item, and table-cell structure, alongside existing Drop cap, table, list, and code treatment. The owner page and listing context are explicit viewer inputs. This observation does not establish a staging or production release; the overall review date remains unchanged.

## Preview Images

Stream/listing preview images use a fallback chain:

1. Preview Image
2. Recipe Main Image
3. Featured Image block image
4. Gallery block first image
5. First image found in story blocks

Preview images use `optimizedThumbnails` when present and fall back to native URLs when needed.

Local discovery update, 2026-10-04: `modules/content/Images.php` includes enabled Captioned image entries within Text in the existing Story fallback, after the explicit sources above. It follows referenced entries in authored order rather than traversing arbitrary nested fields.

## Captions

Existing gallery, featured-image, and recipe captions use Neutral 600 body text during the palette trial. Their details use 12 px Micro type in Slate 600, with uppercase tracking and spacing below the caption.

```twig
<div class="text-neutral-600 text-base mt-2.5 max-w-md leading-none px-8 md:px-0">
  {{ image.caption }}
  {% if image.details %}
    <div class="font-micro text-xs uppercase tracking-wide text-neutral-600 mt-2">{{ image.details }}</div>
  {% endif %}
</div>
```

The matrix and recipe templates use inline utilities for details; the unused `bt-image-details` definition is removed. Visible caption/detail text remains separate from image alt text.

Captioned image figures use standard article width, natural image proportions, Neutral 600 captions, and smaller normal-case credit/details text. Both placement fields preserve line breaks and wrap long words. Blank overrides inherit asset caption/details; independent Hide caption and Hide credit / details switches suppress either value for this placement. The article viewer receives those same resolved values. The 2026-10-05 credit switch extends the scoped 2026-10-04 implementation without changing the legacy detail typography shown above.

Scoped source review, 2026-09-28: the date, SVG, caption/detail, and rich-text changes were inspected in uncommitted website changes above `b1cf61e` and frontend changes above `f3f709f`. The stored drop-cap content hook is retained and styled by inline wrapper utilities; see [Typography](../foundations/typography.md#drop-cap). Local Chromium checks at 320/390/1280 px verified 12 px dates, solid photography/cooking icons, hover fills, and actual drop caps. Image/recipe details and the other three SVG variants remain source-only verification; matching detail metadata was absent from the sampled live fields. See [Accessibility](../accessibility/index.md#color-and-contrast) for the scoped result. Broader article audit questions below remain open.

Captioned image production follow-up, 2026-10-05: website `bdb5b4f` is active in release `20261005152908`, including this Text renderer, bounded media discovery, and independent caption/credit hiding. Fresh native configuration and 48 production-safe unsaved rendering/discovery assertions passed. Public RSS, responsive routes, existing viewer focus return, and delivery checks passed; broader browser/editor warning limits are retained in [Captioned Image verification](captioned-image.md#review-evidence). This is a scoped update; the page's overall review date remains unchanged.

## Audit Notes

| Finding | Status |
| --- | --- |
| `bt-article` is the dominant shell for posts and content streams. | Observed |
| Topic and schema hooks are reliable implementation anchors: `bt-article-topic-*`, `bt-article-schema-*`. | Observed |
| The shared shell is not used by contact/form content. | Needs decision |
| Templates now include image alt fallbacks, but asset-native alt coverage is still incomplete. | Needs content cleanup |
| The [Personal Index mobile navigation](navigation.md) is a named modal and adds no navigation heading; the previous `Posts` heading remains removed. | Scoped source update, 2026-09-28 |

## Related Pages

- [Matrix Blocks](matrix-blocks.md) describes the content assembled inside the article shell.
- [Stream Pages](../patterns/stream-pages.md) shows how articles form listing pages.
- [Assets & Media](../content-model/assets-media.md) and [Content QA](../operations/content-qa.md) cover image metadata and preview fallback checks.
