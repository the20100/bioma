defmodule Bioma.Atoms.Separator do
  @moduledoc """
  A separator component following shadcn/ui design patterns.

  Renders a visual divider line in either horizontal or vertical orientation.
  Uses the semantic color system for consistent theming.

  ## Examples

      <.separator />
      <.separator orientation="vertical" class="h-6" />
      <.separator class="my-4" />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :orientation, :string,
    default: "horizontal",
    values: ~w(horizontal vertical),
    doc: "The orientation of the separator."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the separator element."

  @doc """
  Renders a separator element with the specified orientation.
  """
  def separator(assigns) do
    ~H"""
    <div
      role="separator"
      aria-orientation={@orientation}
      class={
        cn([
          "shrink-0 bg-border",
          orientation_classes(@orientation),
          @class
        ])
      }
      {@rest}
    />
    """
  end

  defp orientation_classes("horizontal"), do: "h-[1px] w-full"
  defp orientation_classes("vertical"), do: "h-full w-[1px]"
end
