defmodule Bioma.Molecules.Empty do
  @moduledoc """
  An empty state component.

  Displays a placeholder when content is absent, with optional icon,
  title, description, and action slots.

  ## Examples

      <.empty>
        <:icon>
          <svg class="h-12 w-12" ...>...</svg>
        </:icon>
        <:title>No results found</:title>
        <:description>Try adjusting your search or filters.</:description>
        <:action>
          <button class="btn">Clear filters</button>
        </:action>
      </.empty>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :icon, doc: "An icon or illustration to display."
  slot :title, doc: "The empty state title."
  slot :description, doc: "The empty state description."
  slot :action, doc: "An action button or link."

  @doc "Renders an empty state placeholder."
  def empty(assigns) do
    ~H"""
    <div
      class={
        cn([
          "flex min-h-[200px] flex-col items-center justify-center space-y-3 rounded-md border border-dashed p-8 text-center",
          @class
        ])
      }
      {@rest}
    >
      <div :if={@icon != []} class="text-muted-foreground">
        {render_slot(@icon)}
      </div>
      <h3 :if={@title != []} class="text-lg font-semibold tracking-tight">
        {render_slot(@title)}
      </h3>
      <p :if={@description != []} class="text-sm text-muted-foreground max-w-sm">
        {render_slot(@description)}
      </p>
      <div :if={@action != []} class="mt-2">
        {render_slot(@action)}
      </div>
    </div>
    """
  end
end
