---
title: Components
type: index
status: draft
source_of_truth: documentation
audience:
  - design
  - development
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Components

Components document reusable interface and content building blocks.

The current site mixes Tailwind utility composition with existing named `bt-*` classes. The implementation rule accepted on 2026-09-28 governs new work:

- Implement new styling with inline Tailwind utilities and new behavior with Alpine.js; ask the site owner before introducing an exception.
- Reuse Twig components where patterns repeat while keeping styling inline. Existing named classes remain documented observations rather than permission to create new ones.
- Prefer clear source references so future refactors can move from documentation to implementation without guesswork.

See [Contributing](../contributing.md#frontend-implementation-rule) for the durable implementation rule.

The highest-priority components are the ones with both visual impact and source coupling: article content, matrix blocks, galleries, recipe content, navigation, and forms.
