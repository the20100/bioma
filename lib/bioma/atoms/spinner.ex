defmodule Bioma.Atoms.Spinner do
  @moduledoc """
  A loading spinner component.

  Renders an animated SVG spinner with configurable size.

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
    <svg
      class={
        cn([
          "animate-spin",
          size_class(@size),
          @class
        ])
      }
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      {@rest}
    >
      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" />
      <path
        class="opacity-75"
        fill="currentColor"
        d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
      />
    </svg>
    """
  end

  defp size_class("sm"), do: "h-4 w-4"
  defp size_class("md"), do: "h-6 w-6"
  defp size_class("lg"), do: "h-8 w-8"
end
