defmodule Bioma.Molecules.DropdownMenu do
  @moduledoc """
  A dropdown menu component following shadcn/ui design patterns.

  Provides a toggleable menu with trigger and content using named slots.
  Uses `Phoenix.LiveView.JS` for client-side show/hide behavior.

  ## Examples

      <.dropdown id="actions-menu">
        <:trigger>
          <button>Options</button>
        </:trigger>
        <:content>
          <.dropdown_label>Actions</.dropdown_label>
          <.dropdown_separator />
          <.dropdown_item phx-click="edit">Edit</.dropdown_item>
        </:content>
      </.dropdown>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # dropdown/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the dropdown."

  attr :position, :string,
    default: "bottom-start",
    values: ~w(bottom-start bottom-end top-start top-end),
    doc: "The position of the dropdown content relative to the trigger."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :trigger, required: true, doc: "The trigger element (usually a button)."
  slot :content, required: true, doc: "The menu items."

  @doc """
  Renders a dropdown menu with trigger and content slots.
  """
  def dropdown(assigns) do
    ~H"""
    <div
      id={@id}
      phx-click-away={hide_content(@id)}
      class={cn(["relative inline-block", @class])}
      {@rest}
    >
      <div phx-click={toggle_content(@id)}>
        {render_slot(@trigger)}
      </div>
      <div
        id={"#{@id}-content"}
        role="menu"
        class={cn([
          "hidden",
          "absolute z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md",
          position_classes(@position)
        ])}
      >
        {render_slot(@content)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # dropdown_item/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :disabled, :boolean, default: false, doc: "Whether the item is disabled."

  attr :rest, :global,
    include: ~w(phx-click phx-value-id phx-target),
    doc: "Additional HTML attributes including event handlers."

  slot :inner_block, required: true, doc: "The item content."

  @doc """
  Renders a dropdown menu item.
  """
  def dropdown_item(assigns) do
    ~H"""
    <div
      role="menuitem"
      tabindex="-1"
      data-disabled={@disabled}
      class={cn([
        "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground",
        @disabled && "pointer-events-none opacity-50",
        @class
      ])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # dropdown_separator/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc """
  Renders a horizontal separator within a dropdown menu.
  """
  def dropdown_separator(assigns) do
    ~H"""
    <div role="separator" class={cn(["-mx-1 my-1 h-px bg-muted", @class])} {@rest} />
    """
  end

  # ---------------------------------------------------------------------------
  # dropdown_label/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The label text."

  @doc """
  Renders a non-interactive label within a dropdown menu.
  """
  def dropdown_label(assigns) do
    ~H"""
    <div class={cn(["px-2 py-1.5 text-sm font-semibold", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp toggle_content(id) do
    JS.toggle(
      to: "##{id}-content",
      in:
        {"transition ease-out duration-100", "transform opacity-0 scale-95",
         "transform opacity-100 scale-100"},
      out:
        {"transition ease-in duration-75", "transform opacity-100 scale-100",
         "transform opacity-0 scale-95"}
    )
  end

  defp hide_content(id) do
    JS.hide(
      to: "##{id}-content",
      transition:
        {"transition ease-in duration-75", "transform opacity-100 scale-100",
         "transform opacity-0 scale-95"}
    )
  end

  defp position_classes("bottom-start"), do: "top-full left-0 mt-1"
  defp position_classes("bottom-end"), do: "top-full right-0 mt-1"
  defp position_classes("top-start"), do: "bottom-full left-0 mb-1"
  defp position_classes("top-end"), do: "bottom-full right-0 mb-1"
end
