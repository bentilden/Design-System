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

Images use lazy loading, hover shadow, and lightGallery zoom.

```twig
<img
  class="lazyload bt-image-file transition hover:shadow-2xl shadow-slate-500/70 cursor-zoom-in border-2 border-transparent hover:border-white"
  alt="{{ image.title }}"
/>
```

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
- Preserve `alt` text on grid thumbnails.
- Keep zoom interaction discoverable through hover and cursor treatment.
