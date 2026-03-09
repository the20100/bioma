# Component Reference

## Atoms

### Button
```heex
<.button variant="default" size="default">Click me</.button>
<.button variant="destructive" size="sm">Delete</.button>
<.button variant="outline" size="icon">+</.button>
```
Variants: `default`, `destructive`, `outline`, `secondary`, `ghost`, `link`
Sizes: `default`, `sm`, `lg`, `icon`

### Input
```heex
<.input type="text" placeholder="Enter text..." />
<.input type="email" errors={["is required"]} />
```

### Textarea
```heex
<.textarea placeholder="Type here..." rows={3} />
<.textarea autosize placeholder="Auto-growing..." />
```

### Badge
```heex
<.badge variant="default">New</.badge>
<.badge variant="success">Active</.badge>
```
Variants: `default`, `secondary`, `destructive`, `outline`, `success`, `warning`

### Avatar
```heex
<.avatar>
  <.avatar_image src="/photo.jpg" alt="User" />
  <.avatar_fallback>JD</.avatar_fallback>
</.avatar>
```
Sizes: `default`, `sm`, `lg`

### Other Atoms
- `label` - Form label
- `separator` - Horizontal/vertical divider
- `skeleton` - Loading placeholder
- `spinner` - Loading indicator (sizes: sm/md/lg)
- `switch` - Toggle switch with hidden input
- `checkbox` - Checkbox with hidden input
- `toggle` - Pressable on/off button
- `tooltip` - Hover tooltip (positions: top/bottom/left/right)
- `kbd` - Keyboard shortcut display
- Typography: `h1`, `h2`, `h3`, `h4`, `p`, `lead`, `large`, `small`, `muted`, `prose`

---

## Molecules

### Card
```heex
<.card>
  <.card_header>
    <.card_title>Title</.card_title>
    <.card_description>Description</.card_description>
  </.card_header>
  <.card_content>Content here</.card_content>
  <.card_footer>Footer</.card_footer>
</.card>
```

### Alert
```heex
<.alert variant="success">
  <.alert_title>Success</.alert_title>
  <.alert_description>Operation completed.</.alert_description>
</.alert>
```
Variants: `default`, `destructive`, `success`, `warning`

### Tabs
```heex
<.tabs id="my-tabs" default="tab1">
  <.tabs_list>
    <.tabs_trigger value="tab1" tabs_id="my-tabs">Tab 1</.tabs_trigger>
    <.tabs_trigger value="tab2" tabs_id="my-tabs">Tab 2</.tabs_trigger>
  </.tabs_list>
  <.tabs_content value="tab1" tabs_id="my-tabs" default="tab1">Content 1</.tabs_content>
  <.tabs_content value="tab2" tabs_id="my-tabs" default="tab1">Content 2</.tabs_content>
</.tabs>
```

### Other Molecules
- `toast` / `toast_group` - Flash notifications (variants: default/success/error/warning/info)
- `progress` - Progress bar (value 0-100)
- `dropdown` - Button-triggered dropdown menu
- `popover` - Rich content popup
- `scroll_area` - Styled scrollable container
- `command` - Command palette / search

---

## AI Organisms

### Chat Message
```heex
<.chat_message role="user" content="Hello!" name="Vincent" />
<.chat_message role="assistant" content="Hi there!" name="Claude" thinking="Let me think..." />
<.chat_message role="system" content="You are a helpful assistant." />
<.chat_message role="tool" content="{\"result\": 42}" name="calculator" />
```

### Chat Thread + Chat Input
```heex
<.chat_thread id="thread">
  <.chat_message :for={msg <- @messages} role={msg.role} content={msg.content} />
</.chat_thread>
<.chat_input id="input" phx-submit="send_message" />
```

### Tool Call Display
```heex
<.tool_call_display
  id="tool-1"
  name="search_database"
  status="success"
  parameters={~s({"query": "elixir"})}
  result={~s({"count": 42})}
  duration_ms={125}
/>
```
Statuses: `pending`, `running`, `success`, `error`

### Code Block
```heex
<.code_block code="defmodule Foo do\nend" language="elixir" />
```

### Other AI Organisms
- `markdown` - Markdown renderer (prose wrapper)
- `streaming_text` - Progressive text with cursor
- `thinking_indicator` - Animated thinking display
- `agent_card` - Agent identity card
- `agent_status` - Status indicator (idle/running/error/offline)
- `token_counter` - Token usage display
- `model_selector` - Model dropdown
- `conversation_sidebar` / `conversation_item` - Conversation list
