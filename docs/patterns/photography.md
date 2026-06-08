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
  - bentilden.com/config/project/imageTransforms/galleryThumbnails--711bbe2c-38f9-48b8-be8a-d5a6d5f762a2.yaml
  - bentilden.com/config/project/imageTransforms/largeImage--d5f7dfc1-b45f-4111-8871-6e4160757b4e.yaml
dependencies:
  - lightGallery
accessibility:
  reviewed: false
  notes: Native alt coverage and lightbox keyboard behavior need rendered audit; lightbox captions now use asset caption/details rather than alt text.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-08
review_status: needs audit
---

# Photography

Photography pages need to support both immersive single images and scannable grids.

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

Images use native responsive-image markup, hover shadow, and lightGallery zoom.

```twig
<img
  class="bt-image-file transition hover:shadow-2xl shadow-slate-500/70 cursor-zoom-in border-2 border-transparent hover:border-white"
  alt="{{ imageAlt }}"
  loading="lazy"
  decoding="async"
/>
```

The current templates build `imageAlt` from native asset alt text, then title, then file name.

Lightbox-visible text is separate: matrix image wrappers provide `data-sub-html` from asset caption/details when those fields exist.

## Inline Images

Inline or single-image galleries use larger image sources and a `90vw` size hint.

```twig
sizes="90vw"
style="width: 100%; height: auto;"
```

## Thumbnail Galleries

Multi-image galleries use optimized thumbnails and a `20vw` size hint.

```twig
sizes="20vw"
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
| Legacy `gallery` and `featuredImage` templates still exist. | Needs decision |
| Templates now include alt fallbacks, but native asset alt coverage remains a content cleanup issue. | Needs content cleanup |
| Lightbox captions now use caption/details instead of alt fallback text. | Implemented |
| lightGallery is used for image zoom behavior; keyboard behavior needs manual confirmation. | Needs audit |
