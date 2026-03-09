defmodule Bioma.Atoms.Skeleton do
  @moduledoc """
  A skeleton component following shadcn/ui design patterns.

  Renders a pulsing placeholder element used to indicate loading state.
  Pair with width/height classes to match the shape of the content being loaded.

  ## Examples

      <.skeleton class="h-4 w-[250px]" />
      <.skeleton class="h-12 w-12 rounded-full" />
      <.skeleton class="h-[125px] w-full" />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply (typically dimensions)."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the skeleton element."

  @doc """
  Renders a skeleton loading placeholder element.
  """
  def skeleton(assigns) do
    ~H"""
    <div
      class={
        cn([
          "animate-pulse rounded-md bg-muted",
          @class
        ])
      }
      {@rest}
    />
    """
  end
end
