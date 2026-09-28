---
title: Photography
type: pattern
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_matrix/gallery.twig
  - bentilden.com/templates/_matrix/gallery2.twig
  - bentilden.com/templates/_matrix/featuredImage.twig
  - bentilden.com/templates/_matrix/featuredImage2.twig
  - bentilden.com/templates/_components/photo-viewer.twig
  - bentilden.com-css/src/photo-viewer.js
  - bentilden.com/config/project/imageTransforms/galleryThumbnails--711bbe2c-38f9-48b8-be8a-d5a6d5f762a2.yaml
  - bentilden.com/config/project/imageTransforms/largeImage--d5f7dfc1-b45f-4111-8871-6e4160757b4e.yaml
dependencies:
  - lightGallery
accessibility:
  reviewed: false
  notes: Native alt coverage and full viewer accessibility need audit; captions and details remain separate from alt text.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-08
review_status: needs audit
---

# Photography

Photography pages support immersive single images and scannable grids. The [Places browser](places.md) adds Map and Mosaic discovery. The 2026-09-28 implementation uses one [photo viewer](../components/galleries.md#unified-photo-viewer) for these views and individual posts; release verification is recorded with the viewer. The patterns below describe photographs within posts.

## Gallery Grid

```twig
{% set gridCols = "grid-cols-2 lg:grid-cols-3" %}
{% if galleryStyle == "inline" or images|length == 1 %}
  {% set gridCols = "" %}
{% endif %}

<div class="grid {{ gridCols }} gap-6 mb-12" id="lightgallery_{{ block.id }}">
  ...
</div>
```

## Image Interaction

Images use native responsive-image markup and hover shadow. Native image links open the shared Alpine viewer, with LightGallery transitions, gestures, and zoom. Modified clicks and no-JavaScript links remain usable.

```twig
<img
  class="bt-image-file transition hover:shadow-2xl shadow-slate-500/70 border-2 border-transparent hover:border-white"
  alt="{{ imageAlt }}"
  loading="lazy"
  decoding="async"
/>
```

The current templates build `imageAlt` from native asset alt text, then title, then file name.

Visible viewer text is separate: native image links supply plain `data-caption` and `data-details` values from the asset fields. Captions sit below the photograph, with a Details disclosure for longer context. Blank fields reserve no caption space. The shared header contains the count, post context, and icon-only Close. See [Galleries](../components/galleries.md#unified-photo-viewer) for desktop/mobile controls and current verification limits.

## Inline Images

Inline or single-image galleries use larger image sources and a `90vw` size hint.

```twig
sizes="90vw"
style="width: 100%; height: auto;"
```

## Thumbnail Galleries

Multi-image galleries use optimized thumbnails and responsive size hints:

```twig
sizes="(min-width: 1024px) 28vw, 50vw"
```

## Guidance

- Use grids when the set is browsable.
- Use inline treatment when one image deserves the reader's full attention.
- Keep captions close to the image and visually secondary.
- Preserve useful alt text on grid thumbnails and large images.
- Keep zoom interaction discoverable through hover and cursor treatment.

## Audit Notes

| Finding | Status |
| --- | --- |
| Photography is the densest and most repeated visual pattern in the current site. | Observed |
| `gallery2` and `featuredImage2` appear to be the current matrix block variants. | Observed |
| Both gallery and featured-image template variants remain supported through shared implementations. | Released, 2026-09-28 |
| Templates now include alt fallbacks, but native asset alt coverage remains a content cleanup issue. | Needs content cleanup |
| Lightbox captions now use caption/details instead of alt fallback text. | Implemented |
| One Alpine interface uses LightGallery for rendering, transitions, and zoom across photo views. | Released; full accessibility audit open |

Scoped source review, 2026-09-28: the unified-viewer and responsive-size claims were checked against website `fcfbf500678f6c156155234846eac75e3c1bb232` and frontend `ddf33f7506eca4513b0755574ccfcb1e35d73ae0`, including the matrix templates, shared viewer components, `PhotoViewerMedia.php`, and `src/photo-viewer.js`. The page-wide historical review date is unchanged; production verification is recorded with the viewer, and no complete accessibility audit is claimed.
