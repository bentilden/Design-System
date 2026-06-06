# Ben Tilden Design System

This design system documents the visual language, reusable patterns, and front-end conventions emerging from `bentilden.com`.

The current website is a Craft CMS site rendered with Twig templates and styled with Tailwind CSS. The design language is editorial, image-forward, and restrained: large expressive titles, compact uppercase metadata, Slate neutrals, quiet interaction states, and flexible image presentation for photography, cooking, design, and blog content.

## What This System Covers

- Foundations: color, typography, spacing, and responsive layout.
- Components: buttons, navigation, article structure, captions, and content blocks.
- Patterns: content type treatment, galleries, editorial pages, and image-heavy storytelling.
- Implementation notes: Tailwind classes and source references from the current site.

## Source Context

The first pass is based on these source files:

| Area | Source |
| --- | --- |
| Tailwind theme | `bentilden.com-css/tailwind.config.js` |
| CSS entrypoint | `bentilden.com-css/src/bentilden.css` |
| Typefaces and drop cap | `bentilden.com-css/src/elements/type.css` |
| Grid utilities | `bentilden.com-css/src/elements/grid.css` |
| Button utility | `bentilden.com-css/src/components/button.css` |
| Global layout | `bentilden.com/templates/_layout.twig` |
| Article layout | `bentilden.com/templates/_entry-content/default.twig` |
| Matrix content blocks | `bentilden.com/templates/_matrix/*.twig` |

## Operating Principles

1. Document what exists before inventing what is missing.
2. Prefer composable Tailwind utilities when a pattern is local to one template.
3. Promote a utility to a named `bt-*` class when it repeats or carries design intent.
4. Keep the system editorial first: content and images should lead, interface chrome should recede.
5. Treat accessibility and responsive behavior as part of the component, not an afterthought.
