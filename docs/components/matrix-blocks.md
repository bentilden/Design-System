---
title: Matrix Blocks
type: component
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/config/project/fields/story--82df7a16-b54f-44fd-a55c-53b1b578e478.yaml
  - bentilden.com/config/project/fields/text--446b3f75-5307-4018-a570-55c1023929f8.yaml
  - bentilden.com/config/project/entryTypes
  - bentilden.com/templates/_matrix.twig
  - bentilden.com/templates/_matrix/default.twig
  - bentilden.com/templates/_matrix/text.twig
  - bentilden.com/templates/_components/text-content.twig
  - bentilden.com/templates/_partials/entry/captionedImage.twig
  - bentilden.com/templates/_matrix/heading.twig
  - bentilden.com/templates/_matrix/callout.twig
  - bentilden.com/templates/_matrix/button.twig
  - bentilden.com/templates/_matrix/html.twig
  - bentilden.com/templates/_matrix/featuredImage2.twig
  - bentilden.com/templates/_matrix/gallery2.twig
classes:
  - bt-control-*
  - bt-text
  - bt-callout
  - bt-button
  - bt-control-image
  - bt-image-caption
dependencies:
  - Craft CKEditor
  - Alpine.js
  - Tailwind typography plugin
  - lightGallery
accessibility:
  reviewed: false
  notes: Text, heading, button, image, gallery, and raw HTML blocks need block-by-block rendered audit; image blocks include native responsive markup and alt fallbacks.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-08
review_status: needs audit
---

# Matrix Blocks

Matrix blocks are the main article composition system. The Story field currently offers Text, Button, and HTML entries. Separate Featured Image and Gallery fields compose media entries, while the template directory also retains older Heading and Callout renderers.

## Resolver Contract

The matrix resolver tries the block-specific template first and falls back to the default wrapper:

```twig
{% include [
  "_matrix/" ~ block.type,
  "_matrix/default"
] %}
```

The default wrapper generates a stable control hook:

```twig
bt-control-{{ block.type }}
```

That means every block type can be targeted for styling, audits, and QA even when most of the visual styling lives inside the block-specific template.

## Template Inventory And Authoring Availability

| Block | Template | Authoring availability | Role |
| --- | --- | --- | --- |
| Text | `_matrix/text.twig` | Story | Main prose with `bt-text` and Tailwind typography; local Captioned image inserts render within the text flow. |
| Heading | `_matrix/heading.twig` | Legacy template; no current entry type | Section heading with optional divider. |
| Callout | `_matrix/callout.twig` | Legacy template; no current entry type | Highlighted editorial aside with optional author-supplied class. |
| Button | `_matrix/button.twig` | Story | Centered call to action using the shared `bt-button` class. |
| HTML | `_matrix/html.twig` | Story | Raw HTML escape hatch. Use sparingly. |
| Featured Image | `_matrix/featuredImage2.twig` | Separate Featured Image field | Single editorial image with caption, details, and the shared photo viewer. |
| Gallery | `_matrix/gallery2.twig` | Separate Gallery field | Multi-image or inline gallery with responsive optimized images and the shared photo viewer. |

Scoped source observation, 2026-10-03: website `5871297`, `config/project/fields/story--82df7a16-b54f-44fd-a55c-53b1b578e478.yaml`, and `config/project/entryTypes` confirm that Story enables Text, Button, and HTML only. Heading and Callout have template files but no corresponding current entry-type YAML. Template presence alone does not establish an available authoring option. The inspected configuration and templates were committed; the checkout contained unrelated changes. No rendered check was performed for this observation.

Scoped update, 2026-09-28: both block names remain supported. The `featuredImage2.twig` and `gallery2.twig` templates now extend their corresponding shared `featuredImage.twig` and `gallery.twig` implementations. Source inspected in website `fcfbf500678f6c156155234846eac75e3c1bb232`; this consolidates identical presentation without changing the content model. Production verification is recorded with the viewer. All use the [shared viewer](galleries.md#unified-photo-viewer).

## Authoring Contract

Scoped configuration update, 2026-10-03: the Text field toolbar adds Fullscreen and Tables, groups related writing controls, and uses native overflow at narrow widths. Tables have caption controls and a header row by default; numbered lists support a custom starting number. Link controls offer URL suffix and optional new-tab targeting. H2/H3/H4, Drop cap, purification, and prior toolbar capabilities are retained. This configuration was first applied locally against website `5871297` and is now committed in the production release `1698f62`; authenticated production editor settings and save/reopen behavior were not independently verified. Embedded-entry components were disabled in that release.

- Matrix blocks should be readable when collapsed in Craft.
- Every nested entry type needs a useful title format.
- Media blocks should show a thumbnail in card views.
- Raw HTML blocks should be rare and clearly labeled.
- Calls to action should use the Button block unless a template needs a bespoke link treatment.

## Embedded Captioned Images

Scoped local implementation, 2026-10-04: Text keeps its existing **Image** button and uses Craft CKEditor's native nested-entry image mode. Each selected Content Images asset creates one [Captioned image](captioned-image.md) placement; selecting multiple assets produces separate placements in order. There is no second insertion menu. This adds a component inside Text without changing the outer Story types: Text, Button, and HTML remain the enabled Matrix types, and recipe-step `text2` is unchanged.

`_components/text-content.twig` preserves FieldData markup and entry order. It processes complete rich-text markup through Typogrify once with collision-safe placeholders, then inserts separately rendered component HTML. This keeps images within their authored blockquote, list-item, or table-cell wrappers without applying typography to placement captions. `_partials/entry/captionedImage.twig` renders the structured figure. The existing prose wrapper, Drop cap, lists/code, and one `storyTables` controller/template per Text block remain. Ordinary legacy image markup remains supported by the markup path; no bulk conversion is performed.

Source inspected in website `cad9448` on branch `codex/ckeditor-captioned-image`, checked locally on 2026-10-04; native configuration is applied locally. Authenticated local save/reopen and draft Preview passed with legacy markup and new entries. Unsaved native rendering fixtures verify blockquote/list/table wrappers in article and feed output. This does not establish staging or production behavior and does not refresh the page's overall review date.

## Accessibility Contract

- Text blocks should preserve semantic rich text from authors.
- Heading blocks should not skip levels within the rendered article.
- Image blocks should render native asset alt text first, then title or file-name fallback.
- Gallery and featured-image blocks should keep caption/detail text visually adjacent to the image. The 2026-09-28 contrast update uses Slate 600, with 12 px Micro text for details; see [Article Content](article-content.md#captions) for source and verification scope.
- Viewer captions use editorial caption/details, never alt text fallback. Captioned image resolves placement overrides for its article viewer; global Places views retain asset metadata.
- Raw HTML blocks must be manually reviewed before a page can be treated as accessibility-clean.

## QA Notes

Raw HTML blocks remain a known content risk. The current content QA script reports raw HTML block counts so that escape-hatch usage stays visible.

## Related Pages

- [Article Content](article-content.md) provides the shell around matrix blocks.
- [Craft Structure](../content-model/craft-structure.md) documents the fields and nested entry types behind the resolver.
- [Galleries](galleries.md) and [Buttons](buttons.md) expand on individual block behavior.
- [Captioned Image](captioned-image.md) describes the local nested component available through Text's Image button.
- [Open Questions](../audit/open-questions.md) tracks the unresolved v1/v2 support decision.

## Story Table Rendering

Scoped implementation, 2026-10-04: runtime `1698f62` and frontend `6045175` add contained horizontal scrolling to shared Text-block tables. Twig owns the wrapper, fades, hint, inline Tailwind classes, and Alpine bindings; JavaScript clones the template around stored rich text and manages overflow state. Overflowing tables display edge fades and “Scroll to see more →”; captions remain outside the scroller. Keyboard focus and region descriptions apply only while overflowing.

Table figures use normal text margins and block layout. Table content disables hyphenation, uses 1.375 line-height, and gives header/body cells 10 px vertical padding from 768 px. Mobile padding and paragraph typography retain their existing treatment. Local Chromium checks passed across 320/390/767/768/1280 px for applicable containment, spacing, word wrapping, and cues. Safari and physical devices were not verified. Production CI/deployment workflow succeeded. Public story markup contains the enhancement, live CSS/JavaScript SHA-256 hashes match the release, and production fixtures return 404. Public smoke checks passed; the local air-fryer URL returns 404 on production, so that specific content was not verified there.
