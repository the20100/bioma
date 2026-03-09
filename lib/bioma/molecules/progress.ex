defmodule Bioma.Molecules.Progress do
  @moduledoc """
  A progress bar component following shadcn/ui design patterns.

  Displays a horizontal progress indicator with a track and animated fill.
  The fill percentage is calculated from the `value` and `max` attributes.

  ## Examples

      <.progress value={50} />
      <.progress value={75} max={100} />
      <.progress value={3} max={10} class="h-2" />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :value, :integer, required: true, doc: "The current progress value."
  attr :max, :integer, default: 100, doc: "The maximum progress value."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc """
  Renders a progress bar with a track and indicator.

  The indicator width is calculated as a percentage of `value / max` and applied
  via a CSS `translateX` transform for smooth animation.
  """
  def progress(assigns) do
    percentage = min(100, max(0, round(assigns.value / assigns.max * 100)))
    assigns = assign(assigns, :percentage, percentage)

    ~H"""
    <div
      role="progressbar"
      aria-valuemin="0"
      aria-valuemax={@max}
      aria-valuenow={@value}
      class={
        cn([
          "relative h-4 w-full overflow-hidden rounded-full bg-secondary",
          @class
        ])
      }
      {@rest}
    >
      <div
        class="h-full w-full flex-1 bg-primary transition-all"
        style={"transform: translateX(-#{100 - @percentage}%)"}
      />
    </div>
    """
  end
end
