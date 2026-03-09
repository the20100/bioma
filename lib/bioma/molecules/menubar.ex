defmodule Bioma.Molecules.Menubar do
  @moduledoc """
  A menubar component.

  Provides a horizontal menu bar with dropdown menus, similar to desktop
  application menu bars.

  ## Examples

      <.menubar>
        <.menubar_menu id="file-menu">
          <.menubar_trigger target="file-menu">File</.menubar_trigger>
          <.menubar_content target="file-menu">
            <.menubar_item>New File</.menubar_item>
            <.menubar_item>Open</.menubar_item>
            <.menubar_separator />
            <.menubar_item>Save</.menubar_item>
          </.menubar_content>
        </.menubar_menu>
      </.menubar>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # menubar/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The menubar menus."

  @doc "Renders a menubar container."
  def menubar(assigns) do
    ~H"""
    <div
      role="menubar"
      class={
        cn([
          "inline-flex h-10 items-center space-x-1 rounded-md border bg-background p-1",
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
  # menubar_menu/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for this menu."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The menu trigger and content."

  @doc "Renders a single menu within the menubar."
  def menubar_menu(assigns) do
    ~H"""
    <div
      id={@id}
      phx-click-away={hide_content(@id)}
      class={cn(["relative", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # menubar_trigger/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the menu to toggle."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger label."

  @doc "Renders a menubar trigger button."
  def menubar_trigger(assigns) do
    ~H"""
    <button
      type="button"
      role="menuitem"
      phx-click={toggle_content(@target)}
      class={
        cn([
          "flex cursor-pointer select-none items-center rounded-sm px-3 py-1.5 text-sm font-medium outline-none",
          "hover:bg-accent hover:text-accent-foreground",
          "focus:bg-accent focus:text-accent-foreground",
          "data-[state=open]:bg-accent data-[state=open]:text-accent-foreground",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </button>
    """
  end

  # ---------------------------------------------------------------------------
  # menubar_content/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent menu."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The menu items."

  @doc "Renders the dropdown content of a menubar menu."
  def menubar_content(assigns) do
    ~H"""
    <div
      id={"#{@target}-content"}
      role="menu"
      class={
        cn([
          "hidden",
          "absolute left-0 top-full z-50 mt-1 min-w-[12rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md",
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
  # menubar_item/1
  # ---------------------------------------------------------------------------

  attr :disabled, :boolean, default: false, doc: "Whether this item is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click), doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The menu item content."

  @doc "Renders a menubar menu item."
  def menubar_item(assigns) do
    ~H"""
    <div
      role="menuitem"
      tabindex="-1"
      class={
        cn([
          "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none transition-colors",
          "hover:bg-accent hover:text-accent-foreground",
          "focus:bg-accent focus:text-accent-foreground",
          @disabled && "pointer-events-none opacity-50",
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
  # menubar_separator/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders a separator between menu items."
  def menubar_separator(assigns) do
    ~H"""
    <div class={cn(["-mx-1 my-1 h-px bg-muted", @class])} role="separator" {@rest} />
    """
  end

  # ---------------------------------------------------------------------------
  # menubar_label/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The label text."

  @doc "Renders a label within a menubar menu."
  def menubar_label(assigns) do
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
end
