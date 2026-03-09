defmodule Bioma.Organisms.AI.ChatMessage do
  @moduledoc """
  A chat message component for rendering messages in AI conversations.

  Supports multiple roles (user, assistant, system, tool) with distinct visual
  treatments using the AI semantic color system. Each role has its own alignment,
  background color, and styling.

  ## Role Styles

    - **user** - Right-aligned with `bg-ai-user` background
    - **assistant** - Left-aligned with `bg-ai-assistant` background, optional thinking block
    - **system** - Center-aligned with `bg-ai-system` background, italic text
    - **tool** - Left-aligned with `bg-ai-tool` background, monospace text

  ## Examples

      <.chat_message role="user" content="Hello, how are you?" />

      <.chat_message
        role="assistant"
        content={@response}
        name="Claude"
        thinking={@thinking_content}
        timestamp="2:34 PM"
      />

      <.chat_message role="system" content="You are a helpful assistant." />

      <.chat_message role="tool" content={Jason.encode!(@tool_result)} name="search" />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :role, :string,
    required: true,
    values: ~w(user assistant system tool),
    doc: "The role of the message sender."

  attr :content, :string, required: true, doc: "The message content to display."

  attr :avatar, :string,
    default: nil,
    doc: "URL for the sender's avatar image."

  attr :name, :string,
    default: nil,
    doc: "The display name of the sender."

  attr :timestamp, :string,
    default: nil,
    doc: "A formatted timestamp string to display below the message."

  attr :thinking, :string,
    default: nil,
    doc: "Optional thinking/reasoning content to display in a collapsible block (assistant role only)."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the message container."

  @doc """
  Renders a chat message with role-specific styling.
  """
  def chat_message(%{role: "user"} = assigns) do
    ~H"""
    <div
      class={
        cn([
          "flex flex-col items-end",
          @class
        ])
      }
      {@rest}
    >
      <.message_header name={@name} avatar={@avatar} align="right" />
      <div class="bg-ai-user text-ai-user-foreground rounded-lg p-3 max-w-[80%] ml-auto">
        {@content}
      </div>
      <.message_timestamp :if={@timestamp} timestamp={@timestamp} align="right" />
    </div>
    """
  end

  def chat_message(%{role: "assistant"} = assigns) do
    ~H"""
    <div
      class={
        cn([
          "flex flex-col items-start",
          @class
        ])
      }
      {@rest}
    >
      <.message_header name={@name} avatar={@avatar} align="left" />
      <%!-- Thinking block --%>
      <details :if={@thinking} class="max-w-[80%] mb-1">
        <summary class="cursor-pointer text-xs text-muted-foreground hover:text-foreground select-none">
          Show thinking
        </summary>
        <div class="bg-ai-thinking text-ai-thinking-foreground rounded-lg p-2 text-sm mt-1">
          {@thinking}
        </div>
      </details>
      <%!-- Message content --%>
      <div class="bg-ai-assistant text-ai-assistant-foreground rounded-lg p-3 max-w-[80%]">
        {@content}
      </div>
      <.message_timestamp :if={@timestamp} timestamp={@timestamp} align="left" />
    </div>
    """
  end

  def chat_message(%{role: "system"} = assigns) do
    ~H"""
    <div
      class={
        cn([
          "flex flex-col items-center",
          @class
        ])
      }
      {@rest}
    >
      <.message_header name={@name} avatar={@avatar} align="center" />
      <div class="bg-ai-system text-ai-system-foreground rounded-lg p-3 text-sm italic max-w-[90%] mx-auto">
        {@content}
      </div>
      <.message_timestamp :if={@timestamp} timestamp={@timestamp} align="center" />
    </div>
    """
  end

  def chat_message(%{role: "tool"} = assigns) do
    ~H"""
    <div
      class={
        cn([
          "flex flex-col items-start",
          @class
        ])
      }
      {@rest}
    >
      <.message_header name={@name} avatar={@avatar} align="left" />
      <div class="bg-ai-tool text-ai-tool-foreground rounded-lg p-3 text-sm font-mono max-w-[80%]">
        {@content}
      </div>
      <.message_timestamp :if={@timestamp} timestamp={@timestamp} align="left" />
    </div>
    """
  end

  # ── Private Sub-Components ───────────────────────────────────────────

  attr :name, :string, default: nil
  attr :avatar, :string, default: nil
  attr :align, :string, default: "left"

  defp message_header(assigns) do
    ~H"""
    <div
      :if={@name || @avatar}
      class={
        cn([
          "flex items-center gap-2 mb-1",
          @align == "right" && "flex-row-reverse"
        ])
      }
    >
      <%!-- Avatar --%>
      <span
        :if={@avatar || @name}
        class="relative flex shrink-0 overflow-hidden rounded-full h-6 w-6"
      >
        <img :if={@avatar} src={@avatar} alt={@name || "avatar"} class="aspect-square h-full w-full" />
        <span
          :if={!@avatar && @name}
          class="flex h-full w-full items-center justify-center rounded-full bg-muted text-xs font-medium"
        >
          {String.first(@name)}
        </span>
      </span>
      <%!-- Name --%>
      <span :if={@name} class="text-xs font-medium text-muted-foreground">
        {@name}
      </span>
    </div>
    """
  end

  attr :timestamp, :string, required: true
  attr :align, :string, default: "left"

  defp message_timestamp(assigns) do
    ~H"""
    <span
      class={
        cn([
          "text-xs text-muted-foreground mt-1",
          @align == "right" && "text-right",
          @align == "center" && "text-center"
        ])
      }
    >
      {@timestamp}
    </span>
    """
  end
end
