defmodule Bioma.Molecules.HoverCard do
  @moduledoc """
  A hover card component.

  Displays rich preview content when hovering over a trigger element.

  ## Examples

      <.hover_card id="user-card">
        <:trigger>
          <span class="underline cursor-pointer">@alice</span>
        </:trigger>
        <:content>
          <div class="space-y-2">
            <h4 class="text-sm font-semibold">Alice</h4>
            <p class="text-sm">Software Engineer</p>
          </div>
        </:content>
      </.hover_card>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  attr :id, :string, required: true, doc: "Unique identifier for the hover card."

  attr :position, :string,
    default: "bottom",
    values: ~w(top bottom left right),
    doc: "The position of the card relative to the trigger."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :trigger, required: true, doc: "The hover trigger element."
  slot :content, required: true, doc: "The hover card content."

  @doc "Renders a hover card with trigger and content."
  def hover_card(assigns) do
    ~H"""
    <div
      id={@id}
      class={cn(["relative inline-block", @class])}
      {@rest}
    >
      <div phx-mouseenter={show_content(@id)} phx-mouseleave={hide_content(@id)}>
        {render_slot(@trigger)}
      </div>
      <div
        id={"#{@id}-content"}
        phx-mouseenter={show_content(@id)}
        phx-mouseleave={hide_content(@id)}
        class={cn([
          "hidden",
          "absolute z-50 w-64 rounded-md border bg-popover p-4 text-popover-foreground shadow-md outline-none",
          position_classes(@position)
        ])}
      >
        {render_slot(@content)}
      </div>
    </div>
    """
  end

  defp show_content(id) do
    JS.show(
      to: "##{id}-content",
      transition: {"transition ease-out duration-200", "opacity-0 scale-95", "opacity-100 scale-100"}
    )
  end

  defp hide_content(id) do
    JS.hide(
      to: "##{id}-content",
      transition: {"transition ease-in duration-150", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
  end

  defp position_classes("bottom"), do: "top-full left-1/2 -translate-x-1/2 mt-2"
  defp position_classes("top"), do: "bottom-full left-1/2 -translate-x-1/2 mb-2"
  defp position_classes("left"), do: "right-full top-1/2 -translate-y-1/2 mr-2"
  defp position_classes("right"), do: "left-full top-1/2 -translate-y-1/2 ml-2"
end
