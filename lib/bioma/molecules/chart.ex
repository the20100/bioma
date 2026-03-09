defmodule Bioma.Molecules.Chart do
  @moduledoc """
  A chart component.

  Renders charts using a lightweight SVG-based approach via a JS hook.
  Supports line, bar, pie, and area chart types.

  ## Examples

      <.chart
        id="revenue-chart"
        type="bar"
        data={[
          %{label: "Jan", value: 100},
          %{label: "Feb", value: 200},
          %{label: "Mar", value: 150}
        ]}
      />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :id, :string, required: true, doc: "Unique identifier for the chart."

  attr :type, :string,
    default: "bar",
    values: ~w(line bar pie area),
    doc: "The chart type."

  attr :data, :list,
    required: true,
    doc: "List of %{label: String.t(), value: number()} data points."

  attr :height, :string, default: "350px", doc: "The chart height."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders a chart container with data passed to the JS hook."
  def chart(assigns) do
    chart_data = Jason.encode!(assigns.data)
    assigns = assign(assigns, :chart_data, chart_data)

    ~H"""
    <div
      id={@id}
      phx-hook="Chart"
      data-chart-type={@type}
      data-chart-data={@chart_data}
      style={"min-height: #{@height}"}
      class={cn(["w-full", @class])}
      {@rest}
    >
      <div class="flex h-full w-full items-center justify-center text-sm text-muted-foreground">
        Loading chart...
      </div>
    </div>
    """
  end
end
