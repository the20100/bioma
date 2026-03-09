defmodule Bioma.Atoms.ToggleGroup do
  @moduledoc """
  A toggle group component.

  Renders a group of toggle buttons where one or multiple items can be selected.
  Reuses the visual styling from the Toggle component.

  ## Examples

      <.toggle_group type="single" variant="outline">
        <.toggle_group_item value="bold" pressed={@bold} phx-click="toggle_bold">
          <strong>B</strong>
        </.toggle_group_item>
        <.toggle_group_item value="italic" pressed={@italic} phx-click="toggle_italic">
          <em>I</em>
        </.toggle_group_item>
      </.toggle_group>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # toggle_group/1
  # ---------------------------------------------------------------------------

  attr :type, :string,
    default: "single",
    values: ~w(single multiple),
    doc: "Whether one or multiple items can be selected."

  attr :variant, :string, default: "default", values: ~w(default outline), doc: "The visual style variant."
  attr :size, :string, default: "default", values: ~w(default sm lg), doc: "The size of all toggle items."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The toggle group items."

  @doc """
  Renders a toggle group container.
  """
  def toggle_group(assigns) do
    ~H"""
    <div
      role="group"
      data-type={@type}
      class={cn(["inline-flex items-center justify-center gap-1", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # toggle_group_item/1
  # ---------------------------------------------------------------------------

  attr :value, :string, required: true, doc: "The value identifying this toggle item."
  attr :pressed, :boolean, default: false, doc: "Whether this item is pressed/active."
  attr :variant, :string, default: "default", values: ~w(default outline), doc: "The visual style variant."
  attr :size, :string, default: "default", values: ~w(default sm lg), doc: "The size of the toggle item."
  attr :disabled, :boolean, default: false, doc: "Whether this item is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click phx-value-value phx-value-align phx-value-key), doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The content of the toggle item."

  @doc """
  Renders a single toggle group item.
  """
  def toggle_group_item(assigns) do
    ~H"""
    <button
      type="button"
      role="radio"
      aria-checked={to_string(@pressed)}
      aria-pressed={to_string(@pressed)}
      data-state={if(@pressed, do: "on", else: "off")}
      disabled={@disabled}
      class={
        cn([
          "inline-flex items-center justify-center rounded-md text-sm font-medium ring-offset-background transition-colors",
          "hover:bg-muted hover:text-muted-foreground",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "disabled:pointer-events-none disabled:opacity-50",
          @pressed && "bg-accent text-accent-foreground",
          variant_class(@variant),
          size_class(@size),
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </button>
    """
  end

  defp variant_class("default"), do: "bg-transparent"

  defp variant_class("outline"),
    do: "border border-input bg-transparent hover:bg-accent hover:text-accent-foreground"

  defp size_class("default"), do: "h-10 px-3"
  defp size_class("sm"), do: "h-9 px-2.5"
  defp size_class("lg"), do: "h-11 px-5"
end
