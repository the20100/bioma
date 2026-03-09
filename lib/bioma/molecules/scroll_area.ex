defmodule Bioma.Molecules.ScrollArea do
  @moduledoc """
  A scroll area component following shadcn/ui design patterns.

  Provides a scrollable container with styled scrollbars using Tailwind CSS
  scrollbar utilities. Supports vertical, horizontal, or both scroll orientations.

  ## Examples

      <.scroll_area class="h-[200px] w-[350px]">
        <div class="p-4">
          <p>Long content that scrolls vertically...</p>
        </div>
      </.scroll_area>

      <.scroll_area orientation="horizontal" class="w-96">
        <div class="flex space-x-4 p-4">
          <div class="w-48 shrink-0">Item 1</div>
          <div class="w-48 shrink-0">Item 2</div>
          <div class="w-48 shrink-0">Item 3</div>
        </div>
      </.scroll_area>

      <.scroll_area orientation="both" class="h-[300px] w-[400px]">
        <div class="w-[800px] p-4">
          Wide and tall content...
        </div>
      </.scroll_area>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :orientation, :string,
    default: "vertical",
    values: ~w(vertical horizontal both),
    doc: "The scroll orientation: vertical, horizontal, or both."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The scrollable content."

  @doc """
  Renders a scrollable area with styled scrollbars.

  The scrollbar is styled using Tailwind scrollbar utilities for a minimal,
  consistent appearance across browsers.
  """
  def scroll_area(assigns) do
    ~H"""
    <div
      class={
        cn([
          "relative overflow-hidden",
          @class
        ])
      }
      {@rest}
    >
      <div class={
        cn([
          "h-full w-full",
          overflow_classes(@orientation),
          "scrollbar-thin scrollbar-track-transparent scrollbar-thumb-border hover:scrollbar-thumb-muted-foreground/50"
        ])
      }>
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp overflow_classes("vertical"), do: "overflow-y-auto overflow-x-hidden"
  defp overflow_classes("horizontal"), do: "overflow-x-auto overflow-y-hidden"
  defp overflow_classes("both"), do: "overflow-auto"
end
