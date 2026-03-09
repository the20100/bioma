defmodule Bioma.Molecules.Calendar do
  @moduledoc """
  A calendar component.

  Renders a date grid for single date or date range selection.
  Pure Elixir implementation using the `Date` module.

  ## Examples

      <.calendar
        id="my-calendar"
        selected={@selected_date}
        month={@current_month}
      />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :id, :string, required: true, doc: "Unique identifier for the calendar."

  attr :selected, :any,
    default: nil,
    doc: "The selected date (Date) or date range ({start, end})."

  attr :month, :any,
    default: nil,
    doc: "The month to display (Date). Defaults to today's month."

  attr :min, :any, default: nil, doc: "The minimum selectable date."
  attr :max, :any, default: nil, doc: "The maximum selectable date."

  attr :mode, :string,
    default: "single",
    values: ~w(single range),
    doc: "Selection mode: single date or date range."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click phx-target phx-value-date), doc: "Additional HTML attributes."

  @doc "Renders a calendar date grid."
  def calendar(assigns) do
    today = Date.utc_today()
    month = assigns.month || today
    first_of_month = Date.beginning_of_month(month)
    last_of_month = Date.end_of_month(month)

    # Day of week for the first day (1=Monday, 7=Sunday)
    start_dow = Date.day_of_week(first_of_month)
    # Pad with previous month days
    pad_start = rem(start_dow - 1, 7)

    # Build list of all days to display (6 weeks max)
    start_date = Date.add(first_of_month, -pad_start)

    weeks =
      Enum.chunk_every(
        Enum.map(0..41, fn i -> Date.add(start_date, i) end),
        7
      )

    prev_month = month |> Date.add(-1) |> Date.beginning_of_month()
    next_month = month |> Date.end_of_month() |> Date.add(1)

    assigns =
      assigns
      |> assign(:today, today)
      |> assign(:month_date, month)
      |> assign(:weeks, weeks)
      |> assign(:first_of_month, first_of_month)
      |> assign(:last_of_month, last_of_month)
      |> assign(:prev_month, prev_month)
      |> assign(:next_month, next_month)

    ~H"""
    <div class={cn(["p-3", @class])} {@rest}>
      <%!-- Header: month navigation --%>
      <div class="flex items-center justify-between mb-4">
        <button
          type="button"
          aria-label="Previous month"
          phx-click="calendar_prev_month"
          phx-value-month={Date.to_iso8601(@prev_month)}
          phx-target={assigns[:rest][:"phx-target"]}
          class="inline-flex items-center justify-center rounded-md h-7 w-7 bg-transparent hover:bg-accent hover:text-accent-foreground"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-4 w-4"><path d="m15 18-6-6 6-6" /></svg>
        </button>
        <div class="text-sm font-medium">
          {Calendar.strftime(@month_date, "%B %Y")}
        </div>
        <button
          type="button"
          aria-label="Next month"
          phx-click="calendar_next_month"
          phx-value-month={Date.to_iso8601(@next_month)}
          phx-target={assigns[:rest][:"phx-target"]}
          class="inline-flex items-center justify-center rounded-md h-7 w-7 bg-transparent hover:bg-accent hover:text-accent-foreground"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-4 w-4"><path d="m9 18 6-6-6-6" /></svg>
        </button>
      </div>
      <%!-- Day headers --%>
      <table class="w-full border-collapse">
        <thead>
          <tr>
            <th :for={day <- ~w(Mo Tu We Th Fr Sa Su)} class="text-muted-foreground text-xs font-normal h-9 w-9 text-center">
              {day}
            </th>
          </tr>
        </thead>
        <tbody>
          <tr :for={week <- @weeks}>
            <td :for={day <- week} class="text-center p-0">
              <button
                type="button"
                phx-click="calendar_select_date"
                phx-value-date={Date.to_iso8601(day)}
                phx-target={assigns[:rest][:"phx-target"]}
                disabled={date_disabled?(day, @min, @max, @first_of_month, @last_of_month)}
                class={
                  cn([
                    "inline-flex items-center justify-center rounded-md h-9 w-9 text-sm font-normal transition-colors",
                    "hover:bg-accent hover:text-accent-foreground",
                    "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring",
                    "disabled:pointer-events-none disabled:opacity-50",
                    day == @today && "bg-accent text-accent-foreground",
                    date_selected?(day, @selected) && "bg-primary text-primary-foreground hover:bg-primary hover:text-primary-foreground",
                    !in_current_month?(day, @first_of_month, @last_of_month) && "text-muted-foreground opacity-50"
                  ])
                }
              >
                {day.day}
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    """
  end

  defp date_selected?(day, %Date{} = selected), do: Date.compare(day, selected) == :eq
  defp date_selected?(day, {start_date, end_date}) when not is_nil(start_date) and not is_nil(end_date) do
    Date.compare(day, start_date) in [:eq, :gt] and Date.compare(day, end_date) in [:eq, :lt]
  end
  defp date_selected?(_day, _selected), do: false

  defp date_disabled?(day, min, max, first, last) do
    outside = !in_current_month?(day, first, last)
    before_min = min && Date.compare(day, min) == :lt
    after_max = max && Date.compare(day, max) == :gt
    outside || before_min || after_max
  end

  defp in_current_month?(day, first, last) do
    Date.compare(day, first) in [:eq, :gt] and Date.compare(day, last) in [:eq, :lt]
  end
end
