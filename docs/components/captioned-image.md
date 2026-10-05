---
title: Captioned Image
type: component
status: observed
source_of_truth: observed dev code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/config/project/fields/text--446b3f75-5307-4018-a570-55c1023929f8.yaml
  - bentilden.com/config/project/entryTypes/captionedImage--11339bcd-cf2d-4620-b627-1f5c92f9ff46.yaml
  - bentilden.com/config/project/fields/captionedImageAsset--a8b3744c-5b0e-4c7f-b363-6b2d539954ec.yaml
  - bentilden.com/config/project/fields/hideCredit--2f99d0b5-5f0d-4c66-b93c-4cd29ead6437.yaml
  - bentilden.com/templates/_matrix/text.twig
  - bentilden.com/templates/_components/text-content.twig
  - bentilden.com/templates/_partials/entry/captionedImage.twig
  - bentilden.com/templates/_components/responsive-image.twig
  - bentilden.com/templates/_components/photo-viewer-item.twig
  - bentilden.com/templates/feed.rss.twig
  - bentilden.com/modules/content/Images.php
  - bentilden.com/modules/places/Payload.php
  - bentilden.com/templates/_components/entry-social-image.twig
  - bentilden.com/templates/dev-test/captioned-image.twig
  - bentilden.com/scripts/content-images-qa.php
dependencies:
  - Craft CKEditor
  - ImageOptimize
  - Alpine.js
  - shared photo viewer
accessibility:
  reviewed: false
  notes: Native alt text, semantic figure/caption markup, and ordinary image links are present; this is not a full accessibility audit.
environments:
  observed:
    - dev
owner: Documentation owner
created: 2026-10-04
last_reviewed: 2026-10-04
review_status: needs audit
---

# Captioned Image

Captioned image inserts one editorial image into [Story Text](matrix-blocks.md#embedded-captioned-images). The Text editor retains its existing **Image** button. Native nested-entry image mode creates one placement per selected asset; multiple selected images become separate entries in order, rather than a gallery. It is implemented in development and staging; production remains unchanged.

## Authoring Contract

| Control | Meaning |
| --- | --- |
| Image | Required single image from Content Images, the existing `photos` volume. |
| Caption override | Optional plain text. Blank inherits the asset caption. |
| Hide caption | Deliberately suppresses this placement's caption, including inherited text. |
| Credit / details override | Optional plain text. Blank inherits asset details. |
| Hide credit / details | Independently suppresses this placement's credit/details, including inherited text. Default off. |

Editor cards derive their title and thumbnail from the asset. Editor uploads default to `rich-text/story/`; the native toolbar library modal uploads into its selected Content Images folder. The full Content Images library remains available. Native asset Alternative Text remains the accessibility source, with the existing asset-title/file-name fallback. Alt text never becomes a visible caption.

Caption and credit are placement metadata: editing them does not alter the asset or another use of it. The two hide switches work independently in article, viewer, and RSS output. Hiding both omits `figcaption` while retaining the image and native alt text. Shared asset edits still affect every use. There are no placement crop, alignment, arbitrary width, or location controls.

## Rendering Contract

Text markup and entries retain authored order. Typogrify processes the complete rich-text markup once using collision-safe placeholders; independently rendered component HTML is inserted afterward. Images therefore retain their authored blockquote, list-item, or table-cell structure, while placement captions remain untouched by typography. The component renders its own semantic `figure` and optional `figcaption`. Existing text typography, Drop cap, code, lists, and the single table-enhancement template remain. Legacy ordinary image markup stays supported without automatic conversion.

Images use the shared responsive-image component, native dimensions, eager/priority behavior for the first prioritized image, and lazy loading elsewhere. Standard article width and natural proportions preserve graphic artwork. Captions and normal-case credit/details preserve line breaks and wrap long words.

An ordinary image link opens the shared viewer with the resolved placement caption/credit, source fallback, and explicit parent-page title/URL and listing context. Native entry rendering can walk the owner chain when the page was not supplied; a nested Text block is not treated as the public Post. Image links remain usable without JavaScript and on modified clicks.

RSS uses the same wrapper-preserving process with feed typography, absolute image URLs, and escaped figure/caption HTML, without Alpine controls or editor-card titles. Both hide switches and blank-inheritance rules match article output.

## Discovery Contract

One bounded helper follows enabled, referenced **Story Text → Captioned image** entries in content order. Listing previews, Homepage inheritance, social-image fallback, and content QA retain existing Preview Image, recipe Main Image, Featured Image, and Gallery precedence before this Story fallback. Missing, disabled, trashed, and unreferenced entries/images are omitted.

Places keeps its live, visible photography-Post/category and public `photos` volume rules. Design-only Posts remain excluded; an illustration in an eligible photography Post still qualifies as content from that Post. Eligible unlocated images may enter Mosaic, while Map requires an existing usable asset location. Global Places viewer captions/details remain asset-based because those collections deduplicate assets across placements.

## Review Evidence

Source review, 2026-10-04: inspected the files listed above in website `cad9448` on branch `codex/ckeditor-captioned-image`. Native project configuration is applied locally. The dev/staging-only fixture `/dev-test/captioned-image` exercises inherited, overridden, and hidden captions, repeated assets, mixed prose, tables, and feed output through the actual renderer without saving entries. This documentation records local implementation; staging and production release verification remain separate. Authenticated local tests cover single/batch insertion, placement metadata, legacy markup, card operations, draft save/reopen and rendered Preview, replacement, and native modal/editor file uploads. Anonymous HTTP checks establish article/OG/Twitter/RSS output. Targeted Chromium checks at desktop/320/390 px establish responsive containment, caption wrapping, keyboard activation/focus return, modified clicks, and usable image links without JavaScript. Existing content and native-alt fingerprints remain unchanged after test cleanup. Physical drag/drop, restricted-role UI (no local nonadmin accounts/groups), Safari, physical devices, and assistive technology remain unverified.

Scoped local rendering correction, 2026-10-04: `cad9448` preserves wrappers spanning embedded entries. Unsaved native Entry/FieldData fixtures passed all six blockquote/list/table cases in article and feed modes, including deliberately colliding authored comments; the existing 21 rendering checks also passed. The full 65-check discovery/rendering suite and HTTP/browser checks passed after this correction. `scripts/content-images-qa.php` includes read-only feed regressions for these wrappers. Native new-Post upload, draft save/reopen, and rendered Preview also passed, and the temporary content and test session were cleaned. These checks establish local behavior only.

Credit/staging follow-up, 2026-10-05: website `bdb5b4f` adds the independent Hide credit / details switch with default off. All four visibility combinations passed local save/reopen, Preview, actual viewer UI/data, and feed functional checks; native sidebar submissions still emitted overlapping-submit warnings, so this is not a warning-free CP pass. Actual local article/RSS checks passed 35 assertions. Staging release `20261005141751` matches all changed source hashes, reports the intended native field/layout configuration, and passed 72 server rendering/discovery/persistence checks with complete fixture cleanup and preserved existing content.

Staging browser verification, 2026-10-05: public rendering passed 10 Chromium assertions and targeted keyboard/link behavior passed five, including desktop and 320/390 px containment, caption wrapping, focus return, modified clicks, and usable image links without JavaScript. All four visibility combinations passed 16 native save/reopen, actual Preview, viewer UI/data, and feed functional assertions. Six additional native editor functional assertions passed for the Content Images selector, single/batch insertion, save/reopen identity/order, new-placement defaults, and deletion. Disposable entries were removed and existing content/asset/native-alt fingerprints remained unchanged.

The same native sidebar/parent overlapping-submit warnings occurred; a warning-free CP pass is not claimed. Staging uploads/automatic-alt generation, restricted roles, physical drag/drop, Safari, physical devices, and assistive technology remain unverified; earlier native upload evidence is local. Production remains unchanged.

## Related Pages

- [Assets & Media](../content-model/assets-media.md) defines content/chrome ownership, upload paths, and shared asset metadata.
- [Article Content](article-content.md) supplies the surrounding prose and media presentation.
- [Galleries](galleries.md#unified-photo-viewer) documents the shared viewer.
- [Places](../patterns/places.md#which-photos-appear) documents collection eligibility and location behavior.
