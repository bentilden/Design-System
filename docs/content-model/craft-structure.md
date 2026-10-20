---
title: Craft Structure
type: content_model
status: observed
source_of_truth: observed production code
audience:
  - development
  - content
source:
  - bentilden.com/config/project/sections
  - bentilden.com/config/project/entryTypes
  - bentilden.com/config/project/fields
  - bentilden.com/config/project/imageTransforms
  - bentilden.com/config/project/volumes
  - bentilden.com/docs/craft-authoring-standards.md
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: needs audit
---

# Craft Structure

Craft structure is a design-system input. Entry type controls content shape, Areas of Interest control broad subject identity, and Matrix blocks control article composition.

## Sections

| Handle | Type | URI | Template |
| --- | --- | --- | --- |
| `homepage` | Single | `__home__` | `index` |
| `about` | Single | `about` | `_entry.twig` |
| `posts` | Channel | `{slug}` | `_entry.twig` |
| `areasOfInterest` | Structure, one level | `{slug}` | `category` |
| `siteSettings` | Single | No public URL | None |

## Taxonomy And Navigation

| Handle | Type | Role |
| --- | --- | --- |
| `areasOfInterest` | Structure entries | Drives topic pages, article icons, broad navigation, and `bt-article-topic-*` classes. |
| `globalHeader` | Navigation | Primary header and mobile navigation. |
| `globalFooter` | Navigation | Footer links. |

Use Areas of Interest for broad lanes such as Blog, Cooking, Design, and Places (the `photography` identity). Use tags for narrower cross-cutting subjects.

## Entry Types

| Entry type | Role |
| --- | --- |
| `story` | Prose-led article composed from Matrix blocks. |
| `gallery` | Image-led entry that can render dense gallery layouts. |
| `featuredImage` | Single-image entry with text alongside media. |
| `recipe` | Cooking entry with shared introduction and locally implemented Overview/Ingredients/Steps/Notes/Nutrition sections. |
| `about` | Static about page content. |
| `areaOfInterest` | Topic identity, label, URL, and optional Lucide icon. |
| `siteSettings` | Shared site description, avatar, signatures, and footer wording. |
| `homepage` | Curated homepage statement, introduction, and ordered sections. |
| `homePhotography`, `homeWork`, `homeCooking`, `homeRecent` | Nested homepage sections, at most one of each kind. |
| `homeFeature` | Selected post and overrides scoped to a homepage placement. |
| `text`, `button`, `html`, `heading`, `callout` | Nested Matrix block entries. |
| `ingredient`, `step`, `stepIngredient` | Native recipe rows, steps and linked per-step ingredient usages (local addition, October 20). |

## Matrix Fields

| Field | Entry types | Notes |
| --- | --- | --- |
| `story` | Text, Button, HTML | Main article composition field; configured authoring options are narrower than the available legacy templates. |
| `gallery` | Gallery | One gallery block for gallery entry type layouts. |
| `featuredImage` | Featured Image | One featured-image block for featured-image entry type layouts. |
| `ingredients` | Ingredient | Recipe ingredient rows. |
| `steps` | Step | Recipe instruction rows with optional heading, ingredient references and inline Captioned images; legacy process image retained. |
| `homeSections` | Homepage section types | Ordered, independently enabled sections on the Homepage single. |
| `homeFeatures` | Homepage feature | Ordered post placements inside Photography, Work, and Cooking sections. |

## Homepage Composition

The Homepage single keeps its root URI and `index` template. Its Introduction tab contains `homeStatement` and `homeIntroduction`; Sections contains `homeComposition` and `homeSections`. The composition choice pairs adjacent Photography and Work sections on desktop or keeps them stacked. Section order is also the mobile reading order. Duplicate section kinds must be removed before publishing; disabling one does not make the duplicate valid.

Each curated placement selects an existing published post through `homePost`. Optional copy, image, crop, alt text, and destination overrides affect this placement only. Photography and Cooking expose layout presets; Work preserves complete artwork. Recently Added derives a chronological list with count, area, date, and featured-post controls. See [Homepage](../patterns/homepage.md) for layout rules and renderer sources.

Scoped source review, 2026-09-29: the Homepage and nested-type rows above were checked against deployed `bentilden.com` release `5871297`, including `modules/homepage/Schema.php`, `Validation.php`, `ViewModel.php`, and the corresponding project configuration. The public homepage renders this model; see [Homepage verification](../patterns/homepage.md#implementation-and-verification). Other content-model tables retain their earlier review scope.

Rendering update, 2026-10-17: the homepage refactor in runtime `ad8ae26`, verified in deployed `816d084`, removes the historical `ViewModel.php` layer while retaining the native content model. Twig uses the actual field handles; PHP retains validation, CP controls, and narrow shared rules. See [Where To Edit](../patterns/homepage.md#where-to-edit) and the [field traceability rule](../contributing.md#craft-field-traceability). This preserves the existing native field handles and schema.

## Layout And Classification Fields

| Field | Type | Notes |
| --- | --- | --- |
| `alignment` | Position field | Enables `center`, `left`, and `right`; inactive options include `drop-left`, `drop-right`, and `full`. |
| `areaOfInterest` | Entries | Maps posts to broad subject lane and icon treatment. |
| `hideFromStream` | Lightswitch | Excludes posts from stream pages. |
| `previewImage` | Assets | Optional listing/share override before template fallback logic runs. |

## Asset Fields

| Field | Type | Notes |
| --- | --- | --- |
| `mainImage` | Asset, max 1 | Primary recipe image. |
| `image` | Asset, max 1 | Featured image block image. |
| `images` | Assets | Gallery block images. |
| `image2` | Asset, max 1 | Optional recipe step image in current project config. |
| `caption` | Plain text | Visible image caption metadata. |
| `details` | Plain text | Micro metadata shown below captions. |
| `optimizedImages` | ImageOptimize | Responsive editorial image source set. |
| `optimizedThumbnails` | ImageOptimize | Responsive thumbnail source set. |

## Location Fields

Released revision, 2026-10-20 (runtime `e00d55e`): `locations` is a Structure with native titles and `locationPosition` (Maps). `photoPlace` is a single Entries relation on gallery blocks and photo assets; the gallery labels it Default location. Asset `photoLocationSource` now exposes Automatic / Use location’s map position / Set custom position. `photoLocation` appears only for custom mode. `placeName` and `galleryLocation` remain hidden migration storage, not editing controls. Location selectors show ancestry to distinguish repeated names. See [hierarchy behavior](../patterns/places.md#local-hierarchical-locations-revision). The table below describes the preceding production model.

| Field | Type | Placement |
| --- | --- | --- |
| `galleryLocation` | Maps | Gallery block; inherited when the photo uses Gallery location or Automatic without GPS. |
| `photoLocationSource` | Dropdown | Photos asset Location tab; Automatic, Embedded GPS, Gallery location, or Custom location. |
| `photoLocation` | Maps | Photos asset Location tab; shown and used for Custom location, applying to every use of that asset. |
| `placeName` | Plain text | Gallery and Photos layouts; public label independent of coordinates, hidden on the asset when Gallery location is selected. |

The Photos Location tab also displays read-only embedded-GPS status. This status comes from the GPS index; it is not an editable location field.

See [Photo Locations](assets-media.md#photo-locations) and [Places](../patterns/places.md) for precedence, shared assets, and public eligibility.

Scoped source review, 2026-09-28: the location fields/layouts, category label, and Story block list were checked against the first-release `bentilden.com` source at `b1cf61ef358dc56cce21402f973740ca5d6ad174`. Story permits Text, Button, and HTML; older templates alone do not establish authoring availability. Other tables retain their prior review scope.

## Image Transforms

| Handle | Width | Height | Mode |
| --- | ---: | ---: | --- |
| `largeImage` | 1800 | auto | fit |
| `featuredImage` | 1200 | auto | crop |
| `galleryThumbnails` | 500 | 500 | crop |
| `inStoryLarge` | 700 | auto | fit |
| `inStorySmall` | 300 | auto | fit |
| `avatar` | 250 | 250 | crop |

## Authoring Standards

- Entry type defines shape.
- Area of Interest defines broad subject identity.
- Tags define specific subjects, places, tools, people, events, or series.
- Matrix and nested entries should have useful title formats and card previews.
- Raw HTML blocks should be rare and clearly labeled.
- Images should be uploaded into entry-owned folders and carry native alt text when public.

## Audit Notes

- The content model is tightly coupled to template naming conventions.
- Matrix block v2 names (`gallery2`, `featuredImage2`) appear to be current even though display names remain "Gallery" and "Featured Image".
- Asset metadata fields are important design-system inputs because captions, details, alt behavior, and responsive image output depend on them.

## Related Pages

- [Matrix Blocks](../components/matrix-blocks.md) connects entry types with template resolution.
- [Areas of Interest](../patterns/areas-of-interest.md) explains the taxonomy contract.
- [Assets & Media](assets-media.md) expands on image metadata, ownership, and delivery.
- [Content QA](../operations/content-qa.md) describes repeatable checks for content-model drift.

## Identity Icon Field

Local approved implementation, 2026-10-18: optional `identityIcon` is a Verbb Icon Picker field on the Areas of Interest entry layout and Homepage entry type, in an Identity tab. It is restricted to the complete local Lucide SVG set. Each topic/page stores its own selection. Navigation reads its linked destination's selection; posts read their native `areaOfInterest` topic entry. About and Contact layouts are unchanged. Schema and set definitions travel through Project Config; icon selections and navigation-node links are content values. See [Areas of Interest](../patterns/areas-of-interest.md) and [Icons](../components/icons.md). Sources: local uncommitted `modules/identityicons/Schema.php`, `Seed.php`, and corresponding Project Config above runtime `0221ddc`.


## Entrification

Scoped local review, 2026-10-18: uncommitted runtime changes above `9df63e7` convert the four existing Areas of Interest categories into Structure entries and Site Settings into a URL-less Single, using Craft 5.11.5.1 native entrify commands through a content migration. This supersedes the category/global model in earlier dated evidence. The Single hides title/status controls; `preloadSingles` keeps direct `siteSettings` Twig access. Both topic relation fields are Entries fields, retaining their handles and field identities.

Editors use **Entries → Areas of Interest** and **Entries → Site Settings**. Topic icon ownership and rendering stay the same. Navigation nodes link to the topic entries; existing topic IDs, UIDs, URLs, fields, post relations, and saved homepage links are preserved. No styling changes accompany this conversion. Craft's [entrify commands](https://craftcms.com/docs/5.x/reference/cli.html#entrify) perform the native element conversion; `modules/content/Entrification.php` preserves plugin references and typed content links. Deployment requires the matching content migration as well as Project Config. These observations establish local behavior, not deployment.

Commit update, 2026-10-18: runtime `325a94f` contains the entrification implementation described above. The earlier uncommitted wording records the verification point. Staging deployment is separately authorized; production promotion is not.


### Recipe model update, October 20

Uncommitted local Project Config and `modules/recipes/` above runtime `73e495d` add `stepHeading`, `stepIngredients`, `recipeIngredient` and `stepIngredientQuantity`. The existing optional `story` field is labeled Overview only in the Recipe layout. Step's existing contextual `text` (`text2` globally) gains native CKEditor Captioned image entries; `image` (`image2` globally) remains a legacy fallback. [Recipe Content](../components/recipe-content.md#step-anatomy-and-authoring) documents ownership constraints, quantities, authoring order and rendering. The existing Recipe requirements remain. This is a dev implementation; no production application is claimed.
