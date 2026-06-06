---
title: Components
type: index
status: draft
source_of_truth: documentation
audience:
  - design
  - development
owner: Ben Tilden
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Components

Components document reusable interface and content building blocks.

The current site mixes Tailwind utility composition with a few named `bt-*` classes. This system should keep that balance:

- Use named components for patterns that repeat across content types.
- Keep one-off layout decisions local to Twig templates.
- Prefer clear source references so future refactors can move from documentation to implementation without guesswork.
