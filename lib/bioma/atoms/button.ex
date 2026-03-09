defmodule Bioma.Atoms.Button do
  @moduledoc """
  A button component following shadcn/ui design patterns.

  Supports multiple variants and sizes with full Tailwind CSS styling
  using the semantic color system.

  ## Examples

      <.button>Click me</.button>
      <.button variant="destructive" size="lg">Delete</.button>
      <.button variant="outline" disabled>Disabled</.button>
      <.button variant="ghost" phx-click="handle_click">Ghost</.button>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :variant, :string,
    default: "default",
    values: ~w(default destructive outline secondary ghost link),
    doc: "The visual style variant of the button."

  attr :size, :string,
    default: "default",
    values: ~w(default sm lg icon),
    doc: "The size of the button."

  attr :disabled, :boolean, default: false, doc: "Whether the button is disabled."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global,
    include: ~w(type form name value phx-click phx-disable-with),
    doc: "Additional HTML attributes to apply to the button element."

  slot :inner_block, required: true, doc: "The content of the button."

  @doc """
  Renders a button element with the specified variant and size.
  """
  def button(assigns) do
    ~H"""
    <button
      class={
        cn([
          base_classes(),
          variant_classes(@variant),
          size_classes(@size),
          @class
        ])
      }
      disabled={@disabled}
      {@rest}
    >
      {render_slot(@inner_block)}
    </button>
    """
  end

  defp base_classes do
    "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50"
  end

  defp variant_classes("default"), do: "bg-primary text-primary-foreground hover:bg-primary/90"
  defp variant_classes("destructive"), do: "bg-destructive text-destructive-foreground hover:bg-destructive/90"
  defp variant_classes("outline"), do: "border border-input bg-background hover:bg-accent hover:text-accent-foreground"
  defp variant_classes("secondary"), do: "bg-secondary text-secondary-foreground hover:bg-secondary/80"
  defp variant_classes("ghost"), do: "hover:bg-accent hover:text-accent-foreground"
  defp variant_classes("link"), do: "text-primary underline-offset-4 hover:underline"

  defp size_classes("default"), do: "h-10 px-4 py-2"
  defp size_classes("sm"), do: "h-9 rounded-md px-3"
  defp size_classes("lg"), do: "h-11 rounded-md px-8"
  defp size_classes("icon"), do: "h-10 w-10"
end
