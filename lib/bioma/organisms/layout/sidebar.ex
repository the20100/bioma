defmodule Bioma.Organisms.Layout.Sidebar do
  @moduledoc """
  A sidebar component.

  Provides a collapsible navigation sidebar with support for menu groups,
  items, and a mobile slide-out variant.

  ## Examples

      <.sidebar id="app-sidebar">
        <.sidebar_header>
          <h2 class="text-lg font-semibold">App Name</h2>
        </.sidebar_header>
        <.sidebar_content>
          <.sidebar_group>
            <.sidebar_group_label>Navigation</.sidebar_group_label>
            <.sidebar_menu>
              <.sidebar_menu_item>
                <.sidebar_menu_button active={true} navigate={~p"/"}>
                  Dashboard
                </.sidebar_menu_button>
              </.sidebar_menu_item>
            </.sidebar_menu>
          </.sidebar_group>
        </.sidebar_content>
        <.sidebar_footer>
          <p class="text-xs text-muted-foreground">v1.0.0</p>
        </.sidebar_footer>
      </.sidebar>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # sidebar/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the sidebar."

  attr :side, :string,
    default: "left",
    values: ~w(left right),
    doc: "Which side the sidebar appears on."

  attr :variant, :string,
    default: "sidebar",
    values: ~w(sidebar floating inset),
    doc: "The visual variant of the sidebar."

  attr :collapsed, :boolean, default: false, doc: "Whether the sidebar is collapsed."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The sidebar content."

  @doc "Renders a sidebar layout component."
  def sidebar(assigns) do
    ~H"""
    <aside
      id={@id}
      data-state={if(@collapsed, do: "collapsed", else: "expanded")}
      data-side={@side}
      data-variant={@variant}
      class={
        cn([
          "group/sidebar relative flex h-full flex-col bg-sidebar text-sidebar-foreground",
          "transition-[width] duration-200 ease-linear",
          if(@collapsed,
            do: "w-[--sidebar-width-icon]",
            else: "w-[--sidebar-width]"
          ),
          @variant == "floating" && "m-2 rounded-lg border shadow-sm",
          @variant == "inset" && "border-r",
          @variant == "sidebar" && "border-r",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </aside>
    """
  end

  # ---------------------------------------------------------------------------
  # sidebar_header/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The header content."

  @doc "Renders the sidebar header."
  def sidebar_header(assigns) do
    ~H"""
    <div class={cn(["flex items-center gap-2 px-4 py-4", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # sidebar_content/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The main sidebar content."

  @doc "Renders the scrollable sidebar content area."
  def sidebar_content(assigns) do
    ~H"""
    <div class={cn(["flex-1 overflow-auto px-2", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # sidebar_footer/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The footer content."

  @doc "Renders the sidebar footer."
  def sidebar_footer(assigns) do
    ~H"""
    <div class={cn(["flex items-center gap-2 px-4 py-4 border-t", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # sidebar_group/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The group content."

  @doc "Renders a sidebar group."
  def sidebar_group(assigns) do
    ~H"""
    <div class={cn(["py-2", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # sidebar_group_label/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The label text."

  @doc "Renders a sidebar group label."
  def sidebar_group_label(assigns) do
    ~H"""
    <div
      class={
        cn([
          "px-2 py-1.5 text-xs font-semibold text-muted-foreground tracking-tight",
          "group-data-[state=collapsed]/sidebar:hidden",
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
  # sidebar_menu/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The menu items."

  @doc "Renders a sidebar menu list."
  def sidebar_menu(assigns) do
    ~H"""
    <ul class={cn(["space-y-1", @class])} {@rest}>
      {render_slot(@inner_block)}
    </ul>
    """
  end

  # ---------------------------------------------------------------------------
  # sidebar_menu_item/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The menu item content."

  @doc "Renders a sidebar menu item."
  def sidebar_menu_item(assigns) do
    ~H"""
    <li class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </li>
    """
  end

  # ---------------------------------------------------------------------------
  # sidebar_menu_button/1
  # ---------------------------------------------------------------------------

  attr :active, :boolean, default: false, doc: "Whether this item is active."
  attr :navigate, :string, default: nil, doc: "LiveView navigate path."
  attr :href, :string, default: nil, doc: "Standard href link."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click), doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The button content."

  @doc "Renders a sidebar menu button/link."
  def sidebar_menu_button(assigns) do
    ~H"""
    <.link
      :if={@navigate}
      navigate={@navigate}
      class={
        cn([
          "flex items-center gap-2 rounded-md px-2 py-1.5 text-sm font-medium transition-colors",
          "hover:bg-accent hover:text-accent-foreground",
          @active && "bg-accent text-accent-foreground",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    <a
      :if={@href && !@navigate}
      href={@href}
      class={
        cn([
          "flex items-center gap-2 rounded-md px-2 py-1.5 text-sm font-medium transition-colors",
          "hover:bg-accent hover:text-accent-foreground",
          @active && "bg-accent text-accent-foreground",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </a>
    <button
      :if={!@navigate && !@href}
      type="button"
      class={
        cn([
          "flex w-full items-center gap-2 rounded-md px-2 py-1.5 text-sm font-medium transition-colors",
          "hover:bg-accent hover:text-accent-foreground",
          @active && "bg-accent text-accent-foreground",
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
  # sidebar_trigger/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the sidebar to toggle."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, doc: "Custom trigger content. Defaults to a hamburger icon."

  @doc "Renders a button that toggles the sidebar collapsed state."
  def sidebar_trigger(assigns) do
    ~H"""
    <button
      type="button"
      aria-label="Toggle sidebar"
      phx-click={toggle_sidebar(@target)}
      class={
        cn([
          "inline-flex items-center justify-center rounded-md h-8 w-8",
          "hover:bg-accent hover:text-accent-foreground",
          @class
        ])
      }
      {@rest}
    >
      <%= if @inner_block != [] do %>
        {render_slot(@inner_block)}
      <% else %>
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-4 w-4"><line x1="3" x2="21" y1="6" y2="6" /><line x1="3" x2="21" y1="12" y2="12" /><line x1="3" x2="21" y1="18" y2="18" /></svg>
      <% end %>
    </button>
    """
  end

  # ---------------------------------------------------------------------------
  # sidebar_separator/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders a separator within the sidebar."
  def sidebar_separator(assigns) do
    ~H"""
    <div class={cn(["mx-2 my-2 h-px bg-border", @class])} {@rest} />
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp toggle_sidebar(id) do
    JS.toggle_attribute({"data-state", "expanded", "collapsed"}, to: "##{id}")
    |> JS.toggle_class("w-[--sidebar-width]", to: "##{id}")
    |> JS.toggle_class("w-[--sidebar-width-icon]", to: "##{id}")
  end
end
