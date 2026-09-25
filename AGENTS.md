# Design System

If `../AGENTS.md` exists in the shared website workspace, read it for the shared workflow. In a standalone checkout, use the guidance below.

Read `docs/contributing.md` and `docs/meta/page-metadata.md` before editing. Keep this public documentation grounded in inspected source, distinguish observations from approved rules, and update related pages when behavior changes. Keep private operational context and credentials out of this repository.

Run `.venv/bin/mkdocs build --strict` after documentation changes. Run `node bin/verify-render` when changing the documentation site's layout or styles.
