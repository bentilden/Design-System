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
  - bentilden.com/templates/_matrix/text.twig
  - bentilden.com-css/src/components/article-icon.css
classes:
  - bt-article
  - bt-article-icon
  - bt-text
accessibility:
  reviewed: false
  notes: Heading hierarchy, icon semantics, and image alt behavior need rendered audit.
owner: Ben Tilden
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Article Content

Article content is the central pattern for the site. It brings together category icons, display titles, metadata, prose, media, and galleries.

## Article Shell

```twig
<article class="pt-12 pb-14 bg-gradient-to-b from-slate-50 to-slate-200 bt-article bt-article-topic-{{ entryCategory.slug }} bt-article-schema-{{ entry.type }}">
  <div class="px-8 lg:container mx-auto">
    ...
  </div>
</article>
```

Article classes include content type and entry type hooks:

- `bt-article-topic-photography`
- `bt-article-topic-cooking`
- `bt-article-schema-story`
- `bt-article-schema-gallery`

## Entry Header

```twig
<h1 class="font-display text-5xl mb-3 leading-none">
  <a href="{{ url }}">{{ title }}</a>
</h1>
<p class="font-micro text-2xs uppercase tracking-widest text-slate-400 mt-4 mb-8">
  Posted {{ postDate | date('M d, Y') }}
</p>
```

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

Icons sit above article headers and link back to the category.

## Prose Blocks

```twig
<div class="bt-text max-w-prose prose prose-p:leading-relaxed prose-li:my-1 prose-blockquote:not-italic prose-blockquote:leading-relaxed prose-figure:-mx-8 prose-figure:md:mx-auto">
  {{ block.text|typogrify }}
</div>
```

## Captions

<div class="bt-example" markdown>
<p class="bt-caption-demo">
  Late afternoon light across a garden path.
  <small>Kyoto, Japan</small>
</p>
</div>

Captions use Slate 600 body text with micro-style details below.

```twig
<div class="text-slate-600 text-base mt-2.5 max-w-md leading-none">
  {{ image.caption }}
  <div class="font-micro text-2xs uppercase tracking-wide text-slate-400 mt-2">
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
| Image alt text is incomplete in article-adjacent image templates. | Needs accessibility work |
| Mobile navigation headings appear in DOM on every page and should be checked in the accessibility tree. | Needs accessibility work |
