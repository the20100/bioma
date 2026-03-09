defmodule Bioma.Molecules.Combobox do
  @moduledoc """
  A combobox component.

  An autocomplete input combining a popover with a searchable list of options.
  Client-side filtering is built-in via the `ComboboxFilter` hook (no server round-trip needed).
  Optionally add `phx-change` for server-side filtering in addition.

  ## Examples

      <.combobox
        id="language-select"
        name="language"
        value={@selected_language}
        options={[
          %{value: "elixir", label: "Elixir"},
          %{value: "rust", label: "Rust"},
          %{value: "go", label: "Go"}
        ]}
        placeholder="Select language..."
      />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  attr :id, :string, required: true, doc: "Unique identifier for the combobox."
  attr :name, :string, default: nil, doc: "The form field name."
  attr :value, :string, default: nil, doc: "The currently selected value."
  attr :options, :list, default: [], doc: "List of %{value: String.t(), label: String.t()} options."
  attr :placeholder, :string, default: "Select...", doc: "Placeholder text."
  attr :search_placeholder, :string, default: "Search...", doc: "Search input placeholder."
  attr :empty_text, :string, default: "No results found.", doc: "Text when no options match."
  attr :disabled, :boolean, default: false, doc: "Whether the combobox is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-change phx-target), doc: "Additional HTML attributes."

  @doc "Renders a combobox with search and selection."
  def combobox(assigns) do
    selected_option = Enum.find(assigns.options, fn opt -> opt.value == assigns.value end)
    assigns = assign(assigns, :selected_label, selected_option && selected_option.label)

    ~H"""
    <div
      id={@id}
      phx-hook="ComboboxFilter"
      phx-click-away={hide_content(@id)}
      class={cn(["relative inline-block", @class])}
    >
      <input type="hidden" name={@name} value={@value || ""} id={"#{@id}-input"} />
      <%!-- Trigger --%>
      <button
        type="button"
        role="combobox"
        aria-expanded="false"
        disabled={@disabled}
        phx-click={toggle_content(@id)}
        class={
          cn([
            "flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background",
            "focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2",
            "disabled:cursor-not-allowed disabled:opacity-50"
          ])
        }
      >
        <span
          id={"#{@id}-display"}
          data-placeholder={@placeholder}
          class={if(!@selected_label, do: "text-muted-foreground")}
        >
          {@selected_label || @placeholder}
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
          class="ml-2 h-4 w-4 shrink-0 opacity-50"
        >
          <path d="m6 9 6 6 6-6" />
        </svg>
      </button>
      <%!-- Dropdown --%>
      <div
        id={"#{@id}-content"}
        class="hidden absolute z-50 mt-1 w-full rounded-md border bg-popover text-popover-foreground shadow-md"
      >
        <%!-- Search input --%>
        <div class="flex items-center border-b px-3">
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
            class="mr-2 h-4 w-4 shrink-0 opacity-50"
          >
            <circle cx="11" cy="11" r="8" />
            <path d="m21 21-4.3-4.3" />
          </svg>
          <input
            type="text"
            id={"#{@id}-search"}
            placeholder={@search_placeholder}
            class="flex h-10 w-full rounded-md bg-transparent py-3 text-sm outline-none placeholder:text-muted-foreground"
            {@rest}
          />
        </div>
        <%!-- Options --%>
        <div id={"#{@id}-options"} class="max-h-60 overflow-auto p-1">
          <div
            id={"#{@id}-empty"}
            class={cn(["py-6 text-center text-sm text-muted-foreground", @options != [] && "hidden"])}
          >
            {@empty_text}
          </div>
          <div
            :for={option <- @options}
            role="option"
            data-combobox-option
            data-value={option.value}
            data-label={String.downcase(option.label)}
            aria-selected={to_string(option.value == @value)}
            phx-click={select_option(@id, option.value)}
            class={
              cn([
                "relative flex cursor-pointer select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none",
                "hover:bg-accent hover:text-accent-foreground",
                option.value == @value && "bg-accent"
              ])
            }
          >
            <span
              :if={option.value == @value}
              class="absolute left-2 flex h-3.5 w-3.5 items-center justify-center"
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
                class="h-4 w-4"
              >
                <path d="M20 6 9 17l-5-5" />
              </svg>
            </span>
            {option.label}
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp toggle_content(id) do
    JS.toggle(
      to: "##{id}-content",
      in: {"transition ease-out duration-100", "opacity-0 scale-95", "opacity-100 scale-100"},
      out: {"transition ease-in duration-75", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
  end

  defp hide_content(id) do
    JS.hide(
      to: "##{id}-content",
      transition: {"transition ease-in duration-75", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
  end

  defp select_option(id, value) do
    %JS{}
    |> JS.set_attribute({"value", value}, to: "##{id}-input")
    |> JS.dispatch("change", to: "##{id}-input", detail: %{value: value})
    |> JS.hide(
      to: "##{id}-content",
      transition: {"transition ease-in duration-75", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
  end
end
