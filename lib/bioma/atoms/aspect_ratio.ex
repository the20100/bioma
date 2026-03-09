defmodule Bioma.Atoms.AspectRatio do
  @moduledoc """
  An aspect ratio component.

  Maintains a consistent width-to-height ratio for its content.

  ## Examples

      <.aspect_ratio ratio={16/9}>
        <img src="/landscape.jpg" class="object-cover w-full h-full" />
      </.aspect_ratio>

      <.aspect_ratio ratio={1.0}>
        <div class="flex items-center justify-center bg-muted">Square</div>
      </.aspect_ratio>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :ratio, :float, default: 16 / 9, doc: "The desired width-to-height ratio (e.g. 16/9, 4/3, 1.0)."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The content to display within the aspect ratio container."

  @doc """
  Renders a container that maintains the specified aspect ratio.
  """
  def aspect_ratio(assigns) do
    ~H"""
    <div
      style={"aspect-ratio: #{@ratio}"}
      class={cn(["relative overflow-hidden", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end
end
