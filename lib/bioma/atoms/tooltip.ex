defmodule Bioma.Atoms.Tooltip do
  @moduledoc """
  A tooltip component.

  Renders a tooltip that appears on hover around a trigger element,
  with configurable positioning.

  ## Examples

      <.tooltip text="Add to library">
        <button>+</button>
      </.tooltip>

      <.tooltip text="Delete item" position="bottom">
        <button>Delete</button>
      </.tooltip>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  attr :text, :string, required: true
  attr :position, :string, default: "top", values: ~w(top bottom left right)
  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def tooltip(assigns) do
    tooltip_id = "tooltip-#{System.unique_integer([:positive])}"
    assigns = assign(assigns, :tooltip_id, tooltip_id)

    ~H"""
    <div
      class="relative inline-flex"
      phx-mouseenter={JS.show(to: "##{@tooltip_id}", transition: {"ease-out duration-100", "opacity-0 scale-95", "opacity-100 scale-100"})}
      phx-mouseleave={JS.hide(to: "##{@tooltip_id}", transition: {"ease-in duration-75", "opacity-100 scale-100", "opacity-0 scale-95"})}
      {@rest}
    >
      {render_slot(@inner_block)}
      <div
        id={@tooltip_id}
        role="tooltip"
        class={
          cn([
            "absolute z-50 hidden overflow-hidden rounded-md border bg-popover px-3 py-1.5 text-sm text-popover-foreground shadow-md",
            "animate-in fade-in-0 zoom-in-95",
            position_class(@position),
            @class
          ])
        }
      >
        {@text}
      </div>
    </div>
    """
  end

  defp position_class("top"), do: "bottom-full left-1/2 -translate-x-1/2 mb-2"
  defp position_class("bottom"), do: "top-full left-1/2 -translate-x-1/2 mt-2"
  defp position_class("left"), do: "right-full top-1/2 -translate-y-1/2 mr-2"
  defp position_class("right"), do: "left-full top-1/2 -translate-y-1/2 ml-2"
end
