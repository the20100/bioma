defmodule Bioma.Organisms.AI.TokenCounter do
  @moduledoc """
  A token counter component for AI conversations.

  Displays the number of tokens used, with an optional limit and progress bar.
  When a limit is provided, a small progress bar shows the proportion consumed
  and turns destructive when usage exceeds 90%. Without a limit, the component
  displays a simple text counter.

  ## Examples

      <.token_counter used={1250} />

      <.token_counter used={3800} limit={4096} />

      <.token_counter used={950} limit={1000} label="Input tokens" />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :used, :integer, required: true, doc: "The number of tokens consumed."

  attr :limit, :integer,
    default: nil,
    doc: "The maximum token limit. When provided, a progress bar is rendered."

  attr :label, :string,
    default: "Tokens",
    doc: "The label displayed alongside the counter."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the container."

  @doc """
  Renders a token counter with an optional progress bar when a limit is specified.
  """
  def token_counter(assigns) do
    assigns =
      if assigns.limit do
        percentage = min(round(assigns.used / assigns.limit * 100), 100)
        over_threshold = percentage > 90
        assign(assigns, percentage: percentage, over_threshold: over_threshold)
      else
        assign(assigns, percentage: 0, over_threshold: false)
      end

    ~H"""
    <span
      class={
        cn([
          "inline-flex items-center gap-2 text-sm",
          @class
        ])
      }
      {@rest}
    >
      <%= if @limit do %>
        <%!-- Progress bar --%>
        <span class="h-1.5 w-20 rounded-full bg-secondary overflow-hidden">
          <span
            class={
              cn([
                "block h-full rounded-full transition-all",
                if(@over_threshold, do: "bg-destructive", else: "bg-primary")
              ])
            }
            style={"width: #{@percentage}%"}
          />
        </span>
        <%!-- Usage text with limit --%>
        <span class="text-xs text-muted-foreground">
          {format_number(@used)} / {format_number(@limit)}
        </span>
      <% else %>
        <%!-- Simple counter without limit --%>
        <span class="text-xs text-muted-foreground">
          {format_number(@used)} {@label}
        </span>
      <% end %>
    </span>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp format_number(n) when n >= 1_000_000 do
    "#{Float.round(n / 1_000_000, 1)}M"
  end

  defp format_number(n) when n >= 1_000 do
    "#{Float.round(n / 1_000, 1)}k"
  end

  defp format_number(n), do: to_string(n)
end
