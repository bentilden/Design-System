---
title: Contributing
type: guideline
status: draft
source_of_truth: documentation
audience:
  - design
  - development
owner: Documentation owner
created: 2026-06-06
last_reviewed: 2026-06-06
review_status: active
---

# Contributing

This design system should stay close to the live website.

## Update Workflow

1. Make or inspect the website change in `bentilden.com` or `bentilden.com-css`.
2. Find the affected foundations, components, patterns, content models, and operations pages using source paths and existing links.
3. Update the matching Markdown page and any related claims elsewhere. If an answer or investigation establishes a reusable rule, save it on the relevant page with its evidence.
4. Add source references and record the repository commit, inspected files, environment, and any uncommitted changes for claims you checked. Keep implemented behavior, rendered observations, and future proposals distinct.
5. Add useful relative Markdown links between related pages. Update the relevant index or `mkdocs.yml` navigation when adding a page.
6. Check metadata against the [schema](meta/page-metadata.md), review source references and related pages, and run `mkdocs build --strict`.
7. Review the documentation diff and commit it with a message that describes the knowledge changed.

## Documentation Standards

- Document current behavior first.
- Mark future ideas as proposals.
- Use code snippets from source files when they clarify implementation.
- Prefer short guidance over long prose.
- Keep examples accessible and responsive.
- Apply the design system to the documentation site itself: Slate-first surfaces, compact metadata, readable prose widths, quiet controls, and visible page status.
- Keep this public guide focused on reusable site behavior and design guidance. Do not copy private operational notes, credentials, unpublished plans, or internal-only evidence into it.

## Evidence And Review Dates

Use a dated review note for the specific claims checked. Include the source repository and commit, the files or sections inspected, and whether the checkout had uncommitted changes. For rendered checks, also record the environment, routes, viewports, and commands used. A local source inspection does not establish what is deployed or how it behaves in a browser.

Advance `last_reviewed` only after reviewing the page's substantive claims together. For a correction to one section, keep the previous date and add a scoped note. Leave unresolved claims marked for audit or decision instead of implying that an edit verified them.

Retain sanitized evidence needed to reproduce an audit in a durable location. Commit small public reports with the documentation, or link a stable public artifact with its source revision and test context. Temporary paths are working locations, not durable citations. If evidence is missing, say so and keep the result labeled as historical until it is checked again.

## Periodic Knowledge Review

Review affected pages after material template, CSS, content-model, or dependency changes. At release preparation, also scan the [source inventory](audit/source-inventory.md) and [open questions](audit/open-questions.md) for changes that earlier edits may have missed. These are review practices, not scheduled automation.

- Compare implementation claims with the cited source files and revisions; flag unsupported or contradictory statements.
- Check links and source references, metadata values, and pages whose review dates predate relevant changes.
- Follow related pages to update repeated claims, including component guidance, authoring contracts, and audit findings.
- Resolve questions with a dated decision and supporting evidence, or keep them open with the next verification needed.
- Record the scope and outcome of the review. Keep historical findings separate from current verification.

`mkdocs build --strict` checks the documentation build and reported warnings. It does not establish that claims match implementation. The render verifier checks the guide's presentation; it does not replace a website accessibility audit or semantic review of these pages.

See the [Page Template](meta/page-template.md), [Audit](audit/index.md), and [Content QA](operations/content-qa.md) for the page structure, historical evidence, and content checks that support this workflow.

## Publishing Checklist

- GitHub Pages source is set to GitHub Actions.
- Pull requests can use the CI workflow to run `mkdocs build --strict` before merge.
- `mkdocs build --strict` passes.
- The workflow runs successfully on `main`.
- The deployed URL resolves at `https://bentilden.github.io/Design-System/`.
