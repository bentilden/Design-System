# Buttons

Buttons are compact, quiet, and utility-driven.

## Primary Button

<div class="bt-example" markdown>
<span class="bt-button-demo">Read more</span>
</div>

```css
.bt-button {
  @apply inline-flex items-center rounded-lg border border-transparent bg-slate-600 px-6 py-3 text-base font-medium text-white shadow-sm hover:bg-slate-700 focus:outline-none focus:ring-2 focus:ring-slate-500 focus:ring-offset-2;
}
```

## Usage

```twig
<a class="bt-button" href="{{ block.buttonUrl }}">{{ block.label }}</a>
```

Use primary buttons for explicit content actions in matrix blocks. Avoid using them for ordinary inline links.

## States

| State | Treatment |
| --- | --- |
| Default | `bg-slate-600`, white text, subtle shadow |
| Hover | `bg-slate-700` |
| Focus | Slate focus ring with offset |

## Guidance

- Keep labels short and verb-led.
- Use links styled as buttons when the action navigates.
- Preserve visible focus styling.
- Do not introduce decorative color variants until there is a repeated content need.
