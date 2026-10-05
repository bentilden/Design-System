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

Article content is the central pattern for the site. It brings together Area of Interest icons, display titles, metadata, prose, media, and galleries.

## Article Shell

```twig
<article class="pt-12 pb-14 bg-gradient-to-b from-slate-50 to-slate-200 bt-article bt-article-topic-{{ entryCategory.slug }} bt-article-schema-{{ entry.type }}">
  <div class="px-8 lg:container mx-auto">
    ...
  </div>
</article>
```

Article classes include Area of Interest and entry type hooks:

- `bt-article-topic-photography`
- `bt-article-topic-cooking`
- `bt-article-schema-story`
- `bt-article-schema-gallery`
- `bt-article-schema-featuredImage`
- `bt-article-schema-recipe`

## Entry Header

```twig
<h1 class="font-display text-5xl mb-3 leading-none">
  <a href="{{ url }}">{{ title }}</a>
</h1>
<p class="font-micro text-xs uppercase tracking-widest text-slate-600 mt-4 mb-8">
  Posted {{ postDate | date('M d, Y') }}
</p>
```

Dates use 12 px Micro type and Slate 600 in inline Tailwind utilities. The old unused `bt-datePublished` definition is removed; new styling follows the [inline utility rule](../contributing.md#frontend-implementation-rule). The existing `bt-title` hook remains separate.

## Article Icons

Category SVGs are 48 px square with `my-8`, solid `fill-slate-500`, and `hover:fill-slate-700`. They use full opacity and a color transition. These inline utilities replace the former `bt-article-icon` CSS, which used reduced opacity.

Icons sit above article headers and link back to the Area of Interest route. The surrounding link supplies the accessible label; each SVG stays `aria-hidden="true"` and `focusable="false"`. A useful accessible name does not remove the need for a visible functional icon.

## Prose Blocks

The Text renderer retains one `bt-text` prose wrapper and its existing table controller/template. Inside that wrapper, the local Captioned image implementation renders markup and nested entries deliberately:

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

Existing gallery, featured-image, and recipe captions use Slate 600 body text. Their details use 12 px Micro type in Slate 600, with uppercase tracking and spacing below the caption.

```twig
<div class="text-slate-600 text-base mt-2.5 max-w-md leading-none px-8 md:px-0">
  {{ image.caption }}
  {% if image.details %}
    <div class="font-micro text-xs uppercase tracking-wide text-slate-600 mt-2">{{ image.details }}</div>
  {% endif %}
</div>
```

The matrix and recipe templates use inline utilities for details; the unused `bt-image-details` definition is removed. Visible caption/detail text remains separate from image alt text.

Local Captioned image figures use standard article width, natural image proportions, Slate 600 captions, and smaller normal-case credit/details text. Both placement fields preserve line breaks and wrap long words. Blank overrides inherit asset caption/details; Hide caption deliberately suppresses the caption while credit/details can remain. The article viewer receives those same resolved values. This scoped 2026-10-04 implementation does not change the legacy detail typography shown above.

Scoped source review, 2026-09-28: the date, SVG, caption/detail, and rich-text changes were inspected in uncommitted website changes above `b1cf61e` and frontend changes above `f3f709f`. The stored drop-cap content hook is retained and styled by inline wrapper utilities; see [Typography](../foundations/typography.md#drop-cap). Local Chromium checks at 320/390/1280 px verified 12 px dates, solid photography/cooking icons, hover fills, and actual drop caps. Image/recipe details and the other three SVG variants remain source-only verification; matching detail metadata was absent from the sampled live fields. See [Accessibility](../accessibility/index.md#color-and-contrast) for the scoped result. Broader article audit questions below remain open.

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
