defmodule Bioma.Molecules.DatePicker do
  @moduledoc """
  A date picker component.

  Combines a popover trigger with a calendar for date selection.

  ## Examples

      <.date_picker
        id="due-date"
        name="due_date"
        value={@due_date}
        placeholder="Pick a date"
      />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  attr :id, :string, required: true, doc: "Unique identifier for the date picker."
  attr :name, :string, default: nil, doc: "The form field name."
  attr :value, :any, default: nil, doc: "The selected date (Date struct)."
  attr :month, :any, default: nil, doc: "The current month (Date struct)."
  attr :placeholder, :string, default: "Pick a date", doc: "Placeholder text."
  attr :min, :any, default: nil, doc: "Minimum selectable date."
  attr :max, :any, default: nil, doc: "Maximum selectable date."
  attr :disabled, :boolean, default: false, doc: "Whether the date picker is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-change phx-target), doc: "Additional HTML attributes."

  @doc "Renders a date picker with popover trigger and calendar."
  def date_picker(assigns) do
    display_value =
      case assigns.value do
        %Date{} = d -> Calendar.strftime(d, "%B %d, %Y")
        _ -> nil
      end

    assigns = assign(assigns, :display_value, display_value)

    ~H"""
    <div
      id={@id}
      phx-click-away={hide_calendar(@id)}
      class={cn(["relative inline-block", @class])}
    >
      <input
        type="hidden"
        name={@name}
        value={if(@value, do: Date.to_iso8601(@value), else: "")}
        id={"#{@id}-input"}
      />
      <%!-- Trigger button --%>
      <button
        type="button"
        disabled={@disabled}
        phx-click={toggle_calendar(@id)}
        class={
          cn([
            "flex h-10 w-full items-center justify-start rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background",
            "focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2",
            "disabled:cursor-not-allowed disabled:opacity-50",
            !@display_value && "text-muted-foreground"
          ])
        }
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
          class="mr-2 h-4 w-4"
        >
          <rect width="18" height="18" x="3" y="4" rx="2" ry="2" />
          <line x1="16" x2="16" y1="2" y2="6" />
          <line x1="8" x2="8" y1="2" y2="6" />
          <line x1="3" x2="21" y1="10" y2="10" />
        </svg>
        {@display_value || @placeholder}
      </button>
      <%!-- Calendar dropdown --%>
      <div
        id={"#{@id}-calendar"}
        class="hidden absolute z-50 mt-1 rounded-md border bg-popover text-popover-foreground shadow-md"
      >
        <Bioma.Molecules.Calendar.calendar
          id={"#{@id}-cal"}
          selected={@value}
          month={@month}
          min={@min}
          max={@max}
          {@rest}
        />
      </div>
    </div>
    """
  end

  defp toggle_calendar(id) do
    JS.toggle(
      to: "##{id}-calendar",
      in: {"transition ease-out duration-200", "opacity-0 -translate-y-1", "opacity-100 translate-y-0"},
      out: {"transition ease-in duration-150", "opacity-100 translate-y-0", "opacity-0 -translate-y-1"}
    )
  end

  defp hide_calendar(id) do
    JS.hide(
      to: "##{id}-calendar",
      transition: {"transition ease-in duration-150", "opacity-100 translate-y-0", "opacity-0 -translate-y-1"}
    )
  end
end
