defmodule Bioma.Atoms.Slider do
  @moduledoc """
  A slider component.

  Renders a styled range input for selecting numeric values within a range.

  ## Examples

      <.slider name="volume" value={50} />
      <.slider name="brightness" value={75} min={0} max={100} step={5} />
      <.slider disabled={true} value={30} />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :name, :string, default: nil, doc: "The form field name."
  attr :value, :integer, default: 50, doc: "The current value."
  attr :min, :integer, default: 0, doc: "The minimum value."
  attr :max, :integer, default: 100, doc: "The maximum value."
  attr :step, :integer, default: 1, doc: "The step increment."
  attr :disabled, :boolean, default: false, doc: "Whether the slider is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-change phx-throttle), doc: "Additional HTML attributes."

  @doc """
  Renders a range slider input with custom styling.
  """
  def slider(assigns) do
    ~H"""
    <input
      type="range"
      name={@name}
      value={@value}
      min={@min}
      max={@max}
      step={@step}
      disabled={@disabled}
      class={
        cn([
          "w-full h-2 cursor-pointer appearance-none rounded-full bg-secondary",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "disabled:pointer-events-none disabled:opacity-50",
          "[&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:h-5 [&::-webkit-slider-thumb]:w-5",
          "[&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-primary",
          "[&::-webkit-slider-thumb]:border-2 [&::-webkit-slider-thumb]:border-primary",
          "[&::-webkit-slider-thumb]:ring-offset-background",
          "[&::-webkit-slider-thumb]:transition-colors",
          "[&::-webkit-slider-thumb]:hover:bg-primary/90",
          "[&::-moz-range-thumb]:appearance-none [&::-moz-range-thumb]:h-5 [&::-moz-range-thumb]:w-5",
          "[&::-moz-range-thumb]:rounded-full [&::-moz-range-thumb]:bg-primary",
          "[&::-moz-range-thumb]:border-2 [&::-moz-range-thumb]:border-primary",
          "[&::-moz-range-thumb]:transition-colors",
          @class
        ])
      }
      {@rest}
    />
    """
  end
end
