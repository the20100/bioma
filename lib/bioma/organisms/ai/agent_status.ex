defmodule Bioma.Organisms.AI.AgentStatus do
  @moduledoc """
  An agent status indicator component.

  Renders a small inline status badge with a colored dot and label. Supports
  multiple agent states (idle, running, error, offline) and two sizes. Uses
  AI semantic colors for consistent theming.

  ## Examples

      <.agent_status status="idle" />

      <.agent_status status="running" />

      <.agent_status status="error" label="Failed" size="sm" />

      <.agent_status status="offline" label="Disconnected" />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :status, :string,
    required: true,
    values: ~w(idle running error offline),
    doc: "The current status of the agent."

  attr :label, :string,
    default: nil,
    doc: "A custom label to display. When nil, the status name is shown (capitalized)."

  attr :size, :string,
    default: "md",
    values: ~w(sm md),
    doc: "The size variant of the status indicator."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the container."

  @doc """
  Renders an inline status indicator with a colored dot and text label.
  """
  def agent_status(assigns) do
    assigns = assign_new(assigns, :display_label, fn ->
      assigns.label || String.capitalize(assigns.status)
    end)

    ~H"""
    <span
      class={
        cn([
          "inline-flex items-center gap-1.5",
          @class
        ])
      }
      {@rest}
    >
      <%!-- Status dot --%>
      <span class={
        cn([
          "rounded-full",
          dot_size(@size),
          dot_color(@status)
        ])
      } />
      <%!-- Label --%>
      <span class={
        cn([
          "text-muted-foreground",
          label_size(@size)
        ])
      }>
        {@display_label}
      </span>
    </span>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp dot_size("sm"), do: "h-1.5 w-1.5"
  defp dot_size("md"), do: "h-2 w-2"

  defp dot_color("idle"), do: "bg-muted-foreground"
  defp dot_color("running"), do: "bg-ai-running-foreground animate-pulse"
  defp dot_color("error"), do: "bg-ai-error-foreground"
  defp dot_color("offline"), do: "bg-border"

  defp label_size("sm"), do: "text-xs"
  defp label_size("md"), do: "text-sm"
end
