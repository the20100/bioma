# Changelog

## v0.1.1 (2026-03-09)

### New Molecules
- **Tree** — recursive file/skill browser with expand/collapse, icon slot, selected & disabled states. Pure JS via `Phoenix.LiveView.JS`, no hook required.
- **Markdown Editor** — textarea with 10-action formatting toolbar (bold, italic, strikethrough, code, code block, link, blockquote, bullet list, numbered list, heading). Supports Edit / Preview / Split modes. Requires `MarkdownEditor` JS hook; live preview via `phx-change` + `MDEx.to_html!/1`.
- **Kanban** — multi-column drag-and-drop board using native HTML5 DnD (no external deps). Fires `kanban_card_moved` LiveView event on drop. Cards support label badge, priority dot, description, and assignee avatar.

### JS Hooks
- `MarkdownEditor` — toolbar text insertion, Tab-key indent, mode pane switching
- `Kanban` — full DnD lifecycle, drop placeholder, column highlight

---

## v0.1.0 (2026-03-09)

Initial release.

### Atoms
- Button, Input, Textarea, Label, Badge, Avatar, Separator, Skeleton, Spinner,
  Switch, Checkbox, Toggle, Tooltip, Kbd, Typography

### Molecules
- Card, Alert, Tabs, Toast, Progress, Dropdown Menu, Popover, Scroll Area,
  Command Palette

### AI Organisms
- Chat Message, Chat Thread, Chat Input, Code Block, Markdown Renderer,
  Streaming Text, Thinking Indicator, Tool Call Display, Agent Card,
  Agent Status, Token Counter, Model Selector, Conversation Sidebar
