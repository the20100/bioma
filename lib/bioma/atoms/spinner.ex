defmodule Bioma.Atoms.Spinner do
  @moduledoc """
  A pixel-style loading indicator.

  Renders three small hard-edged blocks that animate in an equalizer-wave
  pattern with staggered timing. Pure CSS animation, no JavaScript required.

  ## Examples

      <.spinner />
      <.spinner size="sm" />
      <.spinner size="lg" class="text-primary" />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :size, :string, default: "md", values: ~w(sm md lg)
  attr :class, :string, default: nil
  attr :rest, :global

  def spinner(assigns) do
    ~H"""
    <span
      role="status"
      aria-label="Loading"
      class={cn(["inline-flex items-end", gap_class(@size), @class])}
      {@rest}
    >
      <span class={cn([block_class(@size), "animate-pixel-bounce"])} />
      <span class={cn([block_class(@size), "animate-pixel-bounce-delay-1"])} />
      <span class={cn([block_class(@size), "animate-pixel-bounce-delay-2"])} />
    </span>
    """
  end

  defp block_class("sm"), do: "w-[3px] h-[3px] bg-current rounded-none"
  defp block_class("md"), do: "w-1 h-1 bg-current rounded-none"
  defp block_class("lg"), do: "w-[5px] h-[5px] bg-current rounded-none"

  defp gap_class("sm"), do: "gap-[1px]"
  defp gap_class("md"), do: "gap-[1.5px]"
  defp gap_class("lg"), do: "gap-0.5"
end
