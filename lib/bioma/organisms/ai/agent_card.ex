defmodule Bioma.Organisms.AI.AgentCard do
  @moduledoc """
  An agent card component for displaying AI agent information.

  Renders a card showing an AI agent's avatar, name, model, description,
  status indicator, and optional capabilities and action slots. Uses AI
  semantic colors for status indication and follows shadcn/ui card patterns.

  ## Examples

      <.agent_card name="Research Assistant" model="claude-opus-4-6" status="idle" />

      <.agent_card
        name="Code Reviewer"
        model="gpt-4"
        description="Analyzes code for bugs and best practices."
        status="running"
      >
        <:capabilities>
          <ul class="text-xs text-muted-foreground space-y-1">
            <li>Static analysis</li>
            <li>Security scanning</li>
          </ul>
        </:capabilities>
        <:actions>
          <button class="btn btn-sm">Configure</button>
          <button class="btn btn-sm">Stop</button>
        </:actions>
      </.agent_card>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :name, :string, required: true, doc: "The display name of the agent."

  attr :model, :string,
    default: nil,
    doc: "The AI model the agent is powered by (e.g. \"claude-opus-4-6\")."

  attr :description, :string,
    default: nil,
    doc: "A short description of the agent's purpose."

  attr :avatar, :string,
    default: nil,
    doc: "URL of the agent's avatar image. Falls back to the first letter of the name."

  attr :status, :string,
    default: "idle",
    values: ~w(idle running error),
    doc: "The current operational status of the agent."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the card container."

  slot :capabilities,
    required: false,
    doc: "Optional slot for listing the agent's capabilities."

  slot :actions,
    required: false,
    doc: "Optional slot for action buttons (e.g. configure, stop, restart)."

  @doc """
  Renders an agent card with avatar, identity, status, and optional capability/action slots.
  """
  def agent_card(assigns) do
    ~H"""
    <div
      class={
        cn([
          "rounded-lg border bg-card p-4",
          @class
        ])
      }
      {@rest}
    >
      <%!-- Header: avatar, name/model, status dot --%>
      <div class="flex items-center gap-3">
        <%!-- Avatar --%>
        <div class="relative h-10 w-10 shrink-0 rounded-full bg-muted flex items-center justify-center overflow-hidden">
          <img
            :if={@avatar}
            src={@avatar}
            alt={@name}
            class="h-full w-full object-cover"
          />
          <span :if={!@avatar} class="text-sm font-medium text-muted-foreground">
            {String.first(@name)}
          </span>
        </div>
        <%!-- Name and model --%>
        <div class="min-w-0 flex-1">
          <div class="font-semibold text-sm truncate">{@name}</div>
          <div :if={@model} class="text-xs text-muted-foreground truncate">{@model}</div>
        </div>
        <%!-- Status dot --%>
        <span class={
          cn([
            "h-2.5 w-2.5 shrink-0 rounded-full",
            status_dot_class(@status)
          ])
        } />
      </div>

      <%!-- Description --%>
      <p :if={@description} class="text-sm text-muted-foreground mt-2">
        {@description}
      </p>

      <%!-- Capabilities slot --%>
      <div :if={@capabilities != []} class="mt-3">
        {render_slot(@capabilities)}
      </div>

      <%!-- Actions slot --%>
      <div :if={@actions != []} class="mt-3 flex gap-2">
        {render_slot(@actions)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp status_dot_class("idle"), do: "bg-muted-foreground"
  defp status_dot_class("running"), do: "bg-ai-running-foreground animate-pulse"
  defp status_dot_class("error"), do: "bg-ai-error-foreground"
end
