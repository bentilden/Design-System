---
title: Navigation
type: component
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_components/global-header-nav-primary.twig
  - bentilden.com/templates/_components/global-header-nav-mobile.twig
  - bentilden.com/templates/_components/global-footer.twig
dependencies:
  - Alpine.js
accessibility:
  reviewed: false
  notes: Mobile menu keyboard and focus management need rendered audit.
owner: Ben Tilden
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Navigation

Global navigation uses compact uppercase pills and a large signature mark.

## Desktop Navigation

<div class="bt-example" markdown>
<nav class="bt-nav-demo" aria-label="Demo navigation">
  <a aria-current="page" href="#">Photography</a>
  <a href="#">Cooking</a>
  <a href="#">Design</a>
  <a href="#">About</a>
</nav>
</div>

```twig
<li class="inline-block mx-2 uppercase text-xs font-medium tracking-widest">
  <a href="{{ nodeUrl }}" class="block py-1.5 {% if nodeActive %}bg-slate-900 text-white hover:bg-slate-800 px-2.5 rounded-lg{% else %} text-slate-500 hover:text-slate-900{% endif %}">
    {{ nodeTitle }}
  </a>
</li>
```

## Header Shell

The desktop header is fixed, translucent, and blurred:

```html
<header class="hidden md:block fixed top-0 left-0 right-0 bg-white/95 transition-all duration-350 backdrop-blur-xl z-50">
  ...
</header>
```

The scrolled state adds shadow:

```html
:class="{ 'shadow-md shadow-2xl shadow-slate-500/50' : scrolledFromTop }"
```

## Mobile Navigation

Mobile navigation uses a full-screen Slate 900 overlay. Top-level active items use orange text, while child active pills use orange backgrounds.

```twig
<li class="border-t border-slate-600">
  <a class="block px-6 py-8 no-underline text-2xl font-medium">
    {{ nodeTitle }}
  </a>
</li>
```

## Guidance

- Keep desktop labels short enough to remain pill-like.
- Use uppercase tracking for navigation and metadata, not body text.
- Keep the mobile overlay high contrast.
- Preserve the signature as the dominant brand mark in the header.

## Audit Notes

| Finding | Status |
| --- | --- |
| Desktop navigation has consistent uppercase pill styling and active Slate 900 state. | Observed |
| Mobile overlay uses `role="dialog"`, `aria-modal="true"`, and `aria-label="Mobile navigation menu"`. | Observed |
| Icon-only mobile open button lacks an accessible name in the rendered audit. | Needs fix |
| Focus trap, escape key behavior, and return focus after close still need manual verification. | Needs audit |
