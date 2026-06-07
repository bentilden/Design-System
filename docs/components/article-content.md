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
  - bentilden.com-css/src/components/article-icon.css
classes:
  - bt-article
  - bt-article-icon
  - bt-title
  - bt-datePublished
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
<p class="font-micro text-2xs uppercase tracking-widest text-slate-400 mt-4 mb-8">
  Posted {{ postDate | date('M d, Y') }}
</p>
```

The CSS source also defines hooks for `bt-title` and `bt-datePublished`, so those should be kept available if templates move more of this styling out of utilities.

## Article Icons

```css
.bt-article-icon {
  height: 3rem;
  width: 3rem;
  margin: 2rem 0;
  opacity: 0.25;
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
}
```

Icons sit above article headers and link back to the Area of Interest route.

## Prose Blocks

```twig
<div class="bt-text max-w-prose prose prose-p:leading-relaxed prose-li:my-1 prose-blockquote:not-italic prose-blockquote:leading-relaxed prose-figure:-mx-8 prose-figure:md:mx-auto">
  {{ block.text|typogrify }}
</div>
```

## Preview Images

Stream/listing preview images use a fallback chain:

1. Preview Image
2. Recipe Main Image
3. Featured Image block image
4. Gallery block first image
5. First image found in story blocks

Preview images use `optimizedThumbnails` when present and fall back to native URLs when needed.

## Captions

<div class="bt-example" markdown>
<p class="bt-caption-demo">
  Late afternoon light across a garden path.
  <small>Kyoto, Japan</small>
</p>
</div>

Captions use Slate 600 body text with micro-style details below.

```twig
<div class="bt-image-caption">
  {{ image.caption }}
  <div class="bt-image-details">
    {{ image.details }}
  </div>
</div>
```

## Audit Notes

| Finding | Status |
| --- | --- |
| `bt-article` is the dominant shell for posts and content streams. | Observed |
| Topic and schema hooks are reliable implementation anchors: `bt-article-topic-*`, `bt-article-schema-*`. | Observed |
| The shared shell is not used by contact/form content. | Needs decision |
| Templates now include image alt fallbacks, but asset-native alt coverage is still incomplete. | Needs content cleanup |
| Mobile navigation headings appear in DOM on every page and should be checked in the accessibility tree. | Needs accessibility work |
