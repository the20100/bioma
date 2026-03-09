defmodule Bioma.Atoms.Toggle do
  @moduledoc """
  A toggle button component.

  Renders a button that can be toggled between pressed and unpressed states,
  with support for different variants and sizes.

  ## Examples

      <.toggle phx-click="toggle_bold">
        <strong>B</strong>
      </.toggle>

      <.toggle pressed={true} variant="outline" phx-click="toggle_italic">
        <em>I</em>
      </.toggle>

      <.toggle size="sm" phx-click="toggle_underline">
        <u>U</u>
      </.toggle>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :pressed, :boolean, default: false
  attr :variant, :string, default: "default", values: ~w(default outline)
  attr :size, :string, default: "default", values: ~w(default sm lg)
  attr :disabled, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(phx-click phx-value-key phx-value-value)

  slot :inner_block, required: true

  def toggle(assigns) do
    ~H"""
    <button
      type="button"
      aria-pressed={to_string(@pressed)}
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
  defp variant_class("outline"), do: "border border-input bg-transparent hover:bg-accent hover:text-accent-foreground"

  defp size_class("default"), do: "h-10 px-3"
  defp size_class("sm"), do: "h-9 px-2.5"
  defp size_class("lg"), do: "h-11 px-5"
end
