# Components

Components document reusable interface and content building blocks.

The current site mixes Tailwind utility composition with a few named `bt-*` classes. This system should keep that balance:

- Use named components for patterns that repeat across content types.
- Keep one-off layout decisions local to Twig templates.
- Prefer clear source references so future refactors can move from documentation to implementation without guesswork.
