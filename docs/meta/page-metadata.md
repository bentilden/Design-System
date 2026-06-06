---
title: Page Metadata Schema
type: guideline
status: approved
source_of_truth: design system decision
audience:
  - design
  - development
  - governance
owner: Ben Tilden
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: active
---

# Page Metadata Schema

Every design system page should begin with YAML front matter.

## Required Fields

| Field | Purpose | Example |
| --- | --- | --- |
| `title` | Human-readable page title. | `Article Header` |
| `type` | Taxonomy bucket. | `component` |
| `status` | Maturity of the documented item. | `observed` |
| `source_of_truth` | Where the claim comes from. | `observed production code` |
| `audience` | Primary users of the page. | `design`, `development` |
| `owner` | Person accountable for review. | `Ben Tilden` |
| `created` | Date first documented. | `2026-06-06` |
| `last_reviewed` | Date last checked. | `2026-06-06` |
| `review_status` | Current review state. | `needs audit` |

## Recommended Fields

| Field | Purpose |
| --- | --- |
| `source` | Source files, URLs, screenshots, or design files that back the page. |
| `related` | Related docs pages. |
| `classes` | CSS classes, Tailwind utilities, or component hooks. |
| `tokens` | Design tokens or token families referenced by the page. |
| `dependencies` | JavaScript, Craft plugins, CSS plugins, or rendering dependencies. |
| `accessibility` | Review state and known accessibility notes. |
| `environments` | Environments where the behavior was observed. |
| `since` | First release or site era where the pattern appeared. |
| `deprecated_in` | Release or decision that deprecated the pattern. |

## Types

Use one of these values:

| Type | Use for |
| --- | --- |
| `foundation` | Color, typography, layout, spacing, motion, assets. |
| `component` | Reusable UI or content block. |
| `pattern` | A composition or behavioral convention. |
| `template` | A page-level or Craft template structure. |
| `content_model` | Craft sections, entry types, fields, assets, categories. |
| `asset` | Icons, images, fonts, transforms, media rules. |
| `decision` | Governance or design direction. |
| `guideline` | Process or usage guidance. |
| `audit` | Inventory, findings, and review output. |
| `index` | Navigation/landing page for a section. |

## Status Values

| Status | Meaning |
| --- | --- |
| `observed` | Exists in the current site but is not yet endorsed as the future pattern. |
| `approved` | Accepted as design system guidance. |
| `draft` | Useful but incomplete. |
| `proposed` | Recommended future change, not implemented. |
| `deprecated` | Exists but should not be reused. |
| `needs review` | Requires decision before documentation can be trusted. |

## Source Of Truth Values

Use plain language. Common values:

- `observed production code`
- `observed dev code`
- `design system decision`
- `documentation`
- `proposal`
- `legacy implementation`
- `audit finding`

## Review Status Values

| Review status | Meaning |
| --- | --- |
| `active` | Current and usable. |
| `needs audit` | Needs deeper source/render/accessibility review. |
| `needs decision` | Requires a design or implementation decision. |
| `blocked` | Cannot move forward without missing input or dependency. |
| `retired` | Kept for history only. |
