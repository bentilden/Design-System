---
title: Page Template
type: guideline
status: approved
source_of_truth: design system decision
audience:
  - design
  - development
  - governance
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: active
---

# Page Template

Copy this front matter for new pages and remove fields that do not apply.

```yaml
---
title: Page Title
type: component
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
source:
  - bentilden.com/templates/example.twig
related:
  - foundations/typography.md
classes:
  - bt-example
tokens:
  - slate
dependencies:
  - Alpine.js
accessibility:
  reviewed: false
  notes: Needs keyboard and semantic review.
environments:
  observed:
    - prod
    - dev
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---
```

Suggested page body:

```markdown
# Page Title

Short description of the pattern and when to use it.

## Anatomy

Name the parts.

## Behavior

Describe states, responsive behavior, and dependencies.

## Implementation

Link to source and include small snippets when helpful.

## Accessibility

Record requirements and known gaps.

## Open Questions

List decisions needed before this becomes approved guidance.
```
