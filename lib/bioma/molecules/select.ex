defmodule Bioma.Molecules.Select do
  @moduledoc """
  A select component.

  Renders a custom dropdown select with searchable options.

  ## Examples

      <.select id="fruit-select" name="fruit" placeholder="Select a fruit">
        <.select_content target="fruit-select">
          <.select_item value="apple" target="fruit-select">Apple</.select_item>
          <.select_item value="banana" target="fruit-select">Banana</.select_item>
          <.select_item value="cherry" target="fruit-select">Cherry</.select_item>
        </.select_content>
      </.select>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # select/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the select."
  attr :name, :string, default: nil, doc: "The form field name."
  attr :value, :string, default: nil, doc: "The currently selected value."
  attr :label, :string, default: nil, doc: "Display label for the currently selected value."
  attr :placeholder, :string, default: "Select...", doc: "Placeholder text when no value is selected."
  attr :disabled, :boolean, default: false, doc: "Whether the select is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-change), doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The select content (options)."

  @doc "Renders a custom select dropdown."
  def select(assigns) do
    ~H"""
    <div
      id={@id}
      phx-click-away={hide_content(@id)}
      class={cn(["relative inline-block", @class])}
      {@rest}
    >
      <%!-- Hidden input for form submission --%>
      <input type="hidden" name={@name} value={@value || ""} id={"#{@id}-input"} />
      <%!-- Trigger button --%>
      <button
        type="button"
        role="combobox"
        aria-expanded="false"
        aria-haspopup="listbox"
        disabled={@disabled}
        phx-click={toggle_content(@id)}
        class={
          cn([
            "flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background",
            "placeholder:text-muted-foreground",
            "focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2",
            "disabled:cursor-not-allowed disabled:opacity-50",
            "[&>span]:line-clamp-1"
          ])
        }
      >
        <span id={"#{@id}-display"} class={if(!@value, do: "text-muted-foreground")}>
          {@label || @value || @placeholder}
        </span>
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
          class="h-4 w-4 opacity-50"
        >
          <path d="m6 9 6 6 6-6" />
        </svg>
      </button>
      <%!-- Content --%>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # select_content/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent select."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The select items."

  @doc "Renders the select dropdown content."
  def select_content(assigns) do
    ~H"""
    <div
      id={"#{@target}-content"}
      role="listbox"
      class={
        cn([
          "hidden",
          "absolute z-50 mt-1 max-h-60 w-full overflow-auto rounded-md border bg-popover p-1 text-popover-foreground shadow-md",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # select_item/1
  # ---------------------------------------------------------------------------

  attr :value, :string, required: true, doc: "The value of this option."
  attr :target, :string, required: true, doc: "The id of the parent select."
  attr :selected, :boolean, default: false, doc: "Whether this item is selected."
  attr :disabled, :boolean, default: false, doc: "Whether this item is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click phx-value-value), doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The option label."

  @doc "Renders a select option item."
  def select_item(assigns) do
    ~H"""
    <div
      role="option"
      aria-selected={to_string(@selected)}
      data-value={@value}
      data-disabled={@disabled}
      phx-click={select_value(@target, @value) |> hide_content(@target)}
      class={
        cn([
          "relative flex w-full cursor-pointer select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none",
          "hover:bg-accent hover:text-accent-foreground",
          "focus:bg-accent focus:text-accent-foreground",
          @disabled && "pointer-events-none opacity-50",
          @selected && "bg-accent",
          @class
        ])
      }
      {@rest}
    >
      <span :if={@selected} class="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
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
          class="h-4 w-4"
        >
          <path d="M20 6 9 17l-5-5" />
        </svg>
      </span>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # select_group/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The group items."

  @doc "Renders a group of select items."
  def select_group(assigns) do
    ~H"""
    <div role="group" class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # select_label/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The label text."

  @doc "Renders a label for a select group."
  def select_label(assigns) do
    ~H"""
    <div class={cn(["py-1.5 pl-8 pr-2 text-sm font-semibold", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # select_separator/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders a separator between select groups."
  def select_separator(assigns) do
    ~H"""
    <div class={cn(["-mx-1 my-1 h-px bg-muted", @class])} {@rest} />
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp toggle_content(id) do
    JS.toggle(
      to: "##{id}-content",
      in: {"transition ease-out duration-100", "opacity-0 scale-95", "opacity-100 scale-100"},
      out: {"transition ease-in duration-75", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
  end

  defp hide_content(js \\ %JS{}, id) do
    JS.hide(js,
      to: "##{id}-content",
      transition: {"transition ease-in duration-75", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
  end

  defp select_value(target, value) do
    %JS{}
    |> JS.dispatch("change", to: "##{target}-input", detail: %{value: value})
    |> JS.set_attribute({"value", value}, to: "##{target}-input")
  end
end
