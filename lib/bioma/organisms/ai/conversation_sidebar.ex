defmodule Bioma.Organisms.AI.ConversationSidebar do
  @moduledoc """
  A conversation sidebar component for AI chat applications.

  Provides a sidebar layout with a customizable header slot (for titles and
  "new chat" buttons), a built-in search input, and a scrollable list of
  conversation items. Each conversation item supports title, subtitle,
  timestamp, and active state.

  ## Examples

      <.conversation_sidebar id="sidebar">
        <:header>
          <div class="flex items-center justify-between">
            <h2 class="font-semibold">Chats</h2>
            <button class="btn btn-sm">New Chat</button>
          </div>
        </:header>
        <.conversation_item
          :for={conv <- @conversations}
          id={conv.id}
          title={conv.title}
          subtitle={conv.last_message}
          timestamp={conv.updated_at}
          active={conv.id == @active_conversation_id}
          phx-click="select_conversation"
          phx-value-id={conv.id}
        />
      </.conversation_sidebar>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ===========================================================================
  # conversation_sidebar/1
  # ===========================================================================

  attr :id, :string,
    default: "conversation-sidebar",
    doc: "The HTML id attribute for the sidebar container."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the sidebar container."

  slot :header,
    required: false,
    doc: "Optional header slot for a title, new-chat button, or other controls."

  slot :inner_block,
    required: true,
    doc: "The main content area, typically a list of conversation_item components."

  @doc """
  Renders a conversation sidebar with header, search input, and scrollable conversation list.
  """
  def conversation_sidebar(assigns) do
    ~H"""
    <aside
      id={@id}
      class={
        cn([
          "flex flex-col h-full bg-card border-r",
          @class
        ])
      }
      {@rest}
    >
      <%!-- Header slot --%>
      <div :if={@header != []} class="p-4 border-b">
        {render_slot(@header)}
      </div>

      <%!-- Search input --%>
      <div class="mx-4 mt-4">
        <div class="relative">
          <svg
            class="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          >
            <circle cx="11" cy="11" r="8" />
            <line x1="21" y1="21" x2="16.65" y2="16.65" />
          </svg>
          <input
            type="text"
            placeholder="Search conversations..."
            class="flex h-9 w-full rounded-md border border-input bg-background pl-9 pr-3 py-1 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
          />
        </div>
      </div>

      <%!-- Scrollable conversation list --%>
      <div class="flex-1 overflow-y-auto p-2 space-y-1">
        {render_slot(@inner_block)}
      </div>
    </aside>
    """
  end

  # ===========================================================================
  # conversation_item/1
  # ===========================================================================

  attr :id, :string, required: true, doc: "A unique identifier for the conversation item."

  attr :title, :string, required: true, doc: "The conversation title or name."

  attr :subtitle, :string,
    default: nil,
    doc: "A secondary line of text, such as the last message preview."

  attr :timestamp, :string,
    default: nil,
    doc: "A formatted timestamp string (e.g. \"2 hours ago\")."

  attr :active, :boolean,
    default: false,
    doc: "Whether this item is the currently active/selected conversation."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global,
    include: ~w(phx-click phx-value-id),
    doc: "Additional HTML attributes, including phx-click for selection handling."

  @doc """
  Renders a single conversation item within the sidebar list.
  """
  def conversation_item(assigns) do
    ~H"""
    <div
      id={@id}
      class={
        cn([
          "flex flex-col gap-1 rounded-md px-3 py-2 text-sm cursor-pointer transition-colors hover:bg-accent",
          @active && "bg-accent text-accent-foreground",
          @class
        ])
      }
      {@rest}
    >
      <div class="flex items-center justify-between gap-2">
        <span class="font-medium truncate">{@title}</span>
        <span :if={@timestamp} class="text-xs text-muted-foreground shrink-0">
          {@timestamp}
        </span>
      </div>
      <span :if={@subtitle} class="text-xs text-muted-foreground truncate">
        {@subtitle}
      </span>
    </div>
    """
  end
end
