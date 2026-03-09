defmodule Bioma.Molecules.CommandPalette do
  @moduledoc """
  A command palette component following shadcn/ui design patterns.

  Provides a searchable command menu with grouped items, similar to VS Code's
  command palette or macOS Spotlight. Includes an input with search icon,
  scrollable list of items organized in groups, and an empty state.

  ## Examples

      <.command class="rounded-lg border shadow-md">
        <.command_input placeholder="Type a command or search..." />
        <.command_list>
          <.command_empty>No results found.</.command_empty>
          <.command_group heading="Suggestions">
            <.command_item phx-click="navigate" phx-value-to="/calendar">
              Calendar
            </.command_item>
            <.command_item phx-click="navigate" phx-value-to="/search">
              Search
            </.command_item>
          </.command_group>
          <.command_separator />
          <.command_group heading="Settings">
            <.command_item phx-click="navigate" phx-value-to="/settings/profile">
              Profile
            </.command_item>
            <.command_item phx-click="navigate" phx-value-to="/settings/billing">
              Billing
            </.command_item>
          </.command_group>
        </.command_list>
      </.command>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # command/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The command palette content (input, list, groups)."

  @doc """
  Renders the command palette container.
  """
  def command(assigns) do
    ~H"""
    <div
      class={
        cn([
          "flex h-full w-full flex-col overflow-hidden rounded-md bg-popover text-popover-foreground",
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
  # command_input/1
  # ---------------------------------------------------------------------------

  attr :placeholder, :string, default: "Search...", doc: "Placeholder text for the input."
  attr :name, :string, default: nil, doc: "The name of the input for form submission."
  attr :value, :string, default: nil, doc: "The current value of the input."
  attr :disabled, :boolean, default: false, doc: "Whether the input is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global,
    include: ~w(phx-change phx-keyup phx-debounce phx-target),
    doc: "Additional HTML attributes including event handlers."

  @doc """
  Renders the command palette search input with a search icon.
  """
  def command_input(assigns) do
    ~H"""
    <div class="flex items-center border-b px-3">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
        class="mr-2 h-4 w-4 shrink-0 opacity-50"
      >
        <circle cx="11" cy="11" r="8" /><path d="m21 21-4.3-4.3" />
      </svg>
      <input
        type="text"
        name={@name}
        value={@value}
        placeholder={@placeholder}
        disabled={@disabled}
        class={
          cn([
            "flex h-11 w-full rounded-md bg-transparent py-3 text-sm outline-none placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50",
            @class
          ])
        }
        {@rest}
      />
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # command_list/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The command groups and items."

  @doc """
  Renders the scrollable list container for command items.
  """
  def command_list(assigns) do
    ~H"""
    <div
      role="listbox"
      class={
        cn([
          "max-h-[300px] overflow-y-auto overflow-x-hidden",
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
  # command_empty/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The empty state message."

  @doc """
  Renders an empty state message when no command results are found.
  """
  def command_empty(assigns) do
    ~H"""
    <div
      class={
        cn([
          "py-6 text-center text-sm text-muted-foreground",
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
  # command_group/1
  # ---------------------------------------------------------------------------

  attr :heading, :string, default: nil, doc: "The group heading label."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The command items in this group."

  @doc """
  Renders a group of command items with an optional heading.
  """
  def command_group(assigns) do
    ~H"""
    <div
      role="group"
      class={
        cn([
          "overflow-hidden p-1 text-foreground [&_[data-command-heading]]:px-2 [&_[data-command-heading]]:py-1.5 [&_[data-command-heading]]:text-xs [&_[data-command-heading]]:font-medium [&_[data-command-heading]]:text-muted-foreground",
          @class
        ])
      }
      {@rest}
    >
      <div :if={@heading} data-command-heading class="px-2 py-1.5 text-xs font-medium text-muted-foreground">
        {@heading}
      </div>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # command_item/1
  # ---------------------------------------------------------------------------

  attr :disabled, :boolean, default: false, doc: "Whether the item is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global,
    include: ~w(phx-click phx-value-id phx-value-to phx-target),
    doc: "Additional HTML attributes including event handlers."

  slot :inner_block, required: true, doc: "The item content."

  @doc """
  Renders a selectable command item.
  """
  def command_item(assigns) do
    ~H"""
    <div
      role="option"
      data-disabled={@disabled}
      class={
        cn([
          "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none hover:bg-accent hover:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
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
  # command_separator/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc """
  Renders a horizontal separator between command groups.
  """
  def command_separator(assigns) do
    ~H"""
    <div
      role="separator"
      class={
        cn([
          "-mx-1 h-px bg-border",
          @class
        ])
      }
      {@rest}
    />
    """
  end
end
