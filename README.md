# Bioma

A composable Phoenix LiveView component library for AI agentic platforms.

Inspired by [shadcn/ui](https://ui.shadcn.com), built for Elixir.

## Features

- Atomic design: atoms, molecules, organisms
- AI-first: chat interfaces, streaming text, tool call displays, agent status
- Tailwind CSS v4 with CSS variable theming
- Dark mode support
- Phoenix Storybook for component documentation
- Accessible (ARIA attributes, keyboard navigation)

## Installation

Add to your `mix.exs`:

```elixir
{:bioma, "~> 0.1"}
```

## Usage

```elixir
# Import all components
use Bioma

# Or import specific groups
use Bioma, only: [:atoms]

# Or import individual components
import Bioma.Atoms.Button
```

## Development

```bash
mix setup
mix dev
# Storybook at http://localhost:4000/storybook
```

## License

MIT
