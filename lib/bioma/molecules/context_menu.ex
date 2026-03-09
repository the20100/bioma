defmodule Bioma.Molecules.ContextMenu do
  @moduledoc """
  A context menu component.

  Displays a menu triggered by right-clicking on a target area.
  Uses a JS hook to capture the right-click position and display the menu.

  ## Examples

      <.context_menu id="file-menu">
        <:trigger>
          <div class="flex h-32 w-64 items-center justify-center rounded-md border border-dashed text-sm">
            Right click here
          </div>
        </:trigger>
        <:content>
          <.context_menu_item>Cut</.context_menu_item>
          <.context_menu_item>Copy</.context_menu_item>
          <.context_menu_item>Paste</.context_menu_item>
        </:content>
      </.context_menu>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # context_menu/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the context menu."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :trigger, required: true, doc: "The area that triggers the context menu on right-click."
  slot :content, required: true, doc: "The menu items."

  @doc "Renders a context menu with trigger area and menu content."
  def context_menu(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="ContextMenu"
      phx-click-away={hide_menu(@id)}
      class={cn(["relative", @class])}
      {@rest}
    >
      <div id={"#{@id}-trigger"}>
        {render_slot(@trigger)}
      </div>
      <div
        id={"#{@id}-content"}
        role="menu"
        class="hidden fixed z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md"
      >
        {render_slot(@content)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # context_menu_item/1
  # ---------------------------------------------------------------------------

  attr :disabled, :boolean, default: false, doc: "Whether this item is disabled."
  attr :destructive, :boolean, default: false, doc: "Whether this is a destructive action."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click phx-value-action), doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The menu item content."

  @doc "Renders a context menu item."
  def context_menu_item(assigns) do
    ~H"""
    <div
      role="menuitem"
      tabindex="-1"
      data-disabled={@disabled}
      class={
        cn([
          "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none transition-colors",
          "hover:bg-accent hover:text-accent-foreground",
          "focus:bg-accent focus:text-accent-foreground",
          @disabled && "pointer-events-none opacity-50",
          @destructive && "text-destructive hover:text-destructive",
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
  # context_menu_separator/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders a separator between context menu items."
  def context_menu_separator(assigns) do
    ~H"""
    <div class={cn(["-mx-1 my-1 h-px bg-muted", @class])} role="separator" {@rest} />
    """
  end

  # ---------------------------------------------------------------------------
  # context_menu_label/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The label text."

  @doc "Renders a label within the context menu."
  def context_menu_label(assigns) do
    ~H"""
    <div class={cn(["px-2 py-1.5 text-sm font-semibold", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp hide_menu(id) do
    JS.hide(
      to: "##{id}-content",
      transition: {"transition ease-in duration-75", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
  end
end
