---
title: Areas of Interest
type: pattern
status: observed
source_of_truth: observed production code
audience:
  - design
  - development
  - content
source:
  - bentilden.com/templates/_entry-content/default.twig
  - bentilden.com/templates/category.twig
  - bentilden.com/templates/_components/topic-identity.twig
  - bentilden.com/modules/identityicons/Catalog.php
  - bentilden.com/config/project/categoryGroups/areasOfInterest--6880db45-0db6-4ee0-99de-1599392237bd.yaml
  - bentilden.com/config/project/fields/areaOfInterest--fca4117f-c2a9-4d87-8c39-31d385b36c3e.yaml
classes:
  - bt-article-topic-*
accessibility:
  reviewed: false
  notes: Category icon links have labels in source; rendered icon semantics still need audit.
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Areas of Interest

Areas of Interest are the broad subject lanes for posts. They replaced the older "content type" language and are the current source of topic icons, listing routes, article topic classes, and broad navigation.

## Destination-Owned Identity

Local approved implementation, 2026-10-18, uncommitted above runtime `0221ddc`: the existing category records own the optional `identityIcon` field and visible topic title. The public defaults are:

| Category title | Preserved slug | Initial Lucide icon |
| --- | --- | --- |
| Places | `photography` | `map` |
| Food | `cooking` | `cooking-pot` |
| Work | `design` | `pen-tool` |
| Blog | `blog` | `notebook-pen` |

The setup changes only the old Photography/Cooking/Design titles to their existing public labels. Category IDs, routes, slugs, post relations, and `bt-article-topic-*` hooks remain intact. Places continues to open the [map](places.md).

## Template Contract

Posts obtain the native category through `entry.areaOfInterest.one()` and read its `identityIcon`, title, and URL. The shared [topic identity](../components/article-content.md#article-icons) renders the selected icon above the post title. Slug-to-SVG includes and title-keyword icon guessing are removed from the ordinary renderer.

Verbb Icon Picker exposes the complete pinned [Lucide catalog](../components/icons.md#source-and-updates). The Homepage single owns its own `house` choice using the same field definition; Home is not a category. Navigation links to these existing destination records and inherits their icon. Removing or relabeling a menu link does not remove a topic's identity.

Editor path: **Categories → Areas of Interest → category → Identity → Identity icon**. Homepage: **Entries → Homepage → Identity → Identity icon**. Selecting or clearing an icon affects every place that reads that record. Styling remains contextual, not a field setting.

## Guidance

- Use Areas of Interest for broad subject identity only.
- Use entry type for content shape, such as story, gallery, featured image, or recipe.
- Use tags for specific cross-cutting subjects, places, tools, projects, or series.
- Keep identity icons single-color; retain the visible topic label and keyboard focus treatment. Navigation uses compact line icons; post headers use the circle treatment.
- Do not reintroduce `contentType` naming in new docs, templates, or Craft instructions unless documenting older migration history.
