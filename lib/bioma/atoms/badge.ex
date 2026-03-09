defmodule Bioma.Atoms.Badge do
  @moduledoc """
  A badge component following shadcn/ui design patterns.

  Displays a small status indicator or label with multiple visual variants.
  Uses the semantic color system for consistent theming.

  ## Examples

      <.badge>Default</.badge>
      <.badge variant="destructive">Error</.badge>
      <.badge variant="success">Active</.badge>
      <.badge variant="outline" class="ml-2">v1.0</.badge>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :variant, :string,
    default: "default",
    values: ~w(default secondary destructive outline success warning),
    doc: "The visual style variant of the badge."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the badge element."

  slot :inner_block, required: true, doc: "The content of the badge."

  @doc """
  Renders a badge element with the specified variant.
  """
  def badge(assigns) do
    ~H"""
    <div
      class={
        cn([
          base_classes(),
          variant_classes(@variant),
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  defp base_classes do
    "inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2"
  end

  defp variant_classes("default"), do: "border-transparent bg-primary text-primary-foreground hover:bg-primary/80"
  defp variant_classes("secondary"), do: "border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80"
  defp variant_classes("destructive"), do: "border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80"
  defp variant_classes("outline"), do: "text-foreground"
  defp variant_classes("success"), do: "border-transparent bg-green-500/15 text-green-700 dark:text-green-400"
  defp variant_classes("warning"), do: "border-transparent bg-yellow-500/15 text-yellow-700 dark:text-yellow-400"
end
