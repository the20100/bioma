# Bioma Architecture

## Project Structure

Single Mix library with a dev-only Phoenix app for Storybook.

```
lib/bioma/
  atoms/          # 16 fundamental UI elements (Button, Input, Badge, etc.)
  molecules/      # 9 composed components (Card, Alert, Tabs, etc.)
  organisms/
    ai/           # 13 AI/Agent-specific components (ChatMessage, ToolCallDisplay, etc.)
    layout/       # Layout components (Sidebar, Dialog, etc.) [Priority 2]
  helpers.ex      # cn/1 class merger utility
  theme.ex        # [future] Theme helpers

dev/              # Dev-only Phoenix app (not shipped)
storybook/        # Phoenix Storybook .story.exs files
assets/           # CSS (Tailwind theme) + JS hooks
```

## Design Principles

### Atomic Design
- **Atoms**: Indivisible UI elements (Button, Input, Badge, Avatar, etc.)
- **Molecules**: Functional combinations of atoms (Card, Alert, Tabs, Toast, etc.)
- **Organisms**: Complex, feature-complete components (ChatThread, ToolCallDisplay, etc.)

### Component Conventions
- `use Phoenix.Component`
- `import Bioma.Helpers, only: [cn: 1]`
- `attr :class, :string, default: nil` for class overrides
- `attr :rest, :global` for HTML attribute passthrough
- Pattern-matched private functions for variant/size classes
- Slot-based composition for flexible layouts

### Theming
- CSS custom properties (variables) in OKLCH color space
- Semantic color tokens: primary, secondary, muted, accent, destructive
- AI-specific tokens: ai-user, ai-assistant, ai-system, ai-tool, ai-thinking, ai-error, ai-success, ai-running
- Dark mode via `.dark` class on `<html>`
- Defined in `assets/css/app.css`

### JS Hooks
Shipped in `assets/js/hooks/`:
- `ScrollBottom` - Auto-scroll chat threads
- `CopyToClipboard` - Code block copy button
- `StreamingText` - Progressive text rendering
- `TextareaAutosize` - Auto-growing textarea

## Component List

### Atoms (16)
Button, Input, Textarea, Label, Badge, Avatar, Separator, Skeleton, Spinner, Switch, Checkbox, Toggle, Tooltip, Kbd, Typography (h1-h4, p, lead, large, small, muted, prose)

### Molecules (9)
Card, Alert, Tabs, Toast, Progress, DropdownMenu, Popover, ScrollArea, CommandPalette

### AI Organisms (13)
CodeBlock, MarkdownRenderer, StreamingText, ChatMessage, ChatInput, ChatThread, ThinkingIndicator, ToolCallDisplay, AgentCard, AgentStatus, TokenCounter, ModelSelector, ConversationSidebar

## Dependencies
- `phoenix` + `phoenix_live_view` + `phoenix_html` - Core framework
- `heroicons` (optional) - Icon set
- `mdex` (optional) - Markdown rendering with syntax highlighting
- `jason` - JSON encoding/decoding
