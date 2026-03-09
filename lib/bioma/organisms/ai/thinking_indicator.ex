defmodule Bioma.Organisms.AI.ThinkingIndicator do
  @moduledoc """
  A thinking indicator component for AI conversations.

  Displays an animated "thinking" state with bouncing dots, customizable text,
  and an optional expandable area that reveals thinking content (e.g. chain-of-thought
  reasoning). Uses AI semantic colors for consistent theming.

  ## Examples

      <.thinking_indicator />

      <.thinking_indicator text="Analyzing..." />

      <.thinking_indicator text="Reasoning..." expanded={@show_thinking}>
        <p>Let me think about this step by step...</p>
      </.thinking_indicator>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :text, :string, default: "Thinking...", doc: "The text displayed next to the animated dots."

  attr :expanded, :boolean,
    default: false,
    doc: "Whether the thinking content area is expanded."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the container."

  slot :inner_block,
    required: false,
    doc: "Optional content shown when expanded, such as chain-of-thought reasoning."

  @doc """
  Renders a thinking indicator with animated dots and optional expandable content.
  """
  def thinking_indicator(assigns) do
    assigns = assign(assigns, :toggle_id, "thinking-content-#{System.unique_integer([:positive])}")

    ~H"""
    <div
      class={
        cn([
          "rounded-lg bg-ai-thinking p-3",
          @class
        ])
      }
      {@rest}
    >
      <%!-- Header row with animated dots, text, and toggle chevron --%>
      <div
        class="flex items-center gap-2 cursor-pointer"
        phx-click={toggle_content(@toggle_id)}
      >
        <%!-- Animated pixel blocks --%>
        <div class="flex items-end gap-[1.5px]">
          <span class="w-1 h-1 rounded-none bg-ai-thinking-foreground animate-pixel-bounce" />
          <span class="w-1 h-1 rounded-none bg-ai-thinking-foreground animate-pixel-bounce-delay-1" />
          <span class="w-1 h-1 rounded-none bg-ai-thinking-foreground animate-pixel-bounce-delay-2" />
        </div>
        <%!-- Thinking text --%>
        <span class="text-sm text-ai-thinking-foreground font-medium">
          {@text}
        </span>
        <%!-- Chevron icon (rotates when expanded) --%>
        <svg
          :if={@inner_block != []}
          class={
            cn([
              "ml-auto h-4 w-4 text-ai-thinking-foreground transition-transform duration-200",
              @expanded && "rotate-180"
            ])
          }
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="m6 9 6 6 6-6" />
        </svg>
      </div>
      <%!-- Expandable content area --%>
      <div
        :if={@inner_block != []}
        id={@toggle_id}
        class="mt-2 text-sm text-ai-thinking-foreground/80"
        style={if !@expanded, do: "display: none;", else: ""}
      >
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  defp toggle_content(id) do
    Phoenix.LiveView.JS.toggle(
      %Phoenix.LiveView.JS{},
      to: "##{id}",
      in: {"ease-out duration-200", "opacity-0 -translate-y-1", "opacity-100 translate-y-0"},
      out: {"ease-in duration-150", "opacity-100 translate-y-0", "opacity-0 -translate-y-1"}
    )
  end
end
