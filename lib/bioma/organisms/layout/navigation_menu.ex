defmodule Bioma.Organisms.Layout.NavigationMenu do
  @moduledoc """
  A navigation menu component.

  Provides site-level navigation with dropdown capabilities for organizing
  links into categories.

  ## Examples

      <.navigation_menu>
        <.navigation_menu_list>
          <.navigation_menu_item id="getting-started">
            <.navigation_menu_trigger target="getting-started">
              Getting Started
            </.navigation_menu_trigger>
            <.navigation_menu_content target="getting-started">
              <.navigation_menu_link navigate={~p"/docs"}>
                Documentation
              </.navigation_menu_link>
            </.navigation_menu_content>
          </.navigation_menu_item>
        </.navigation_menu_list>
      </.navigation_menu>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # navigation_menu/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The navigation menu lists."

  @doc "Renders a navigation menu container."
  def navigation_menu(assigns) do
    ~H"""
    <nav class={cn(["relative z-10 flex max-w-max flex-1 items-center justify-center", @class])} {@rest}>
      {render_slot(@inner_block)}
    </nav>
    """
  end

  # ---------------------------------------------------------------------------
  # navigation_menu_list/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The navigation menu items."

  @doc "Renders the navigation menu list."
  def navigation_menu_list(assigns) do
    ~H"""
    <ul class={cn(["group flex flex-1 list-none items-center justify-center space-x-1", @class])} {@rest}>
      {render_slot(@inner_block)}
    </ul>
    """
  end

  # ---------------------------------------------------------------------------
  # navigation_menu_item/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for this menu item."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger and content."

  @doc "Renders a navigation menu item."
  def navigation_menu_item(assigns) do
    ~H"""
    <li
      id={@id}
      phx-click-away={hide_content(@id)}
      class={cn(["relative", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </li>
    """
  end

  # ---------------------------------------------------------------------------
  # navigation_menu_trigger/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the menu item to toggle."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger label."

  @doc "Renders a navigation menu trigger button."
  def navigation_menu_trigger(assigns) do
    ~H"""
    <button
      type="button"
      phx-click={toggle_content(@target)}
      class={
        cn([
          "group inline-flex h-10 w-max items-center justify-center rounded-md bg-background px-4 py-2 text-sm font-medium transition-colors",
          "hover:bg-accent hover:text-accent-foreground",
          "focus:bg-accent focus:text-accent-foreground focus:outline-none",
          "disabled:pointer-events-none disabled:opacity-50",
          "data-[state=open]:bg-accent/50",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
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
        class="relative top-[1px] ml-1 h-3 w-3 transition duration-200 group-data-[state=open]:rotate-180"
        aria-hidden="true"
      >
        <path d="m6 9 6 6 6-6" />
      </svg>
    </button>
    """
  end

  # ---------------------------------------------------------------------------
  # navigation_menu_content/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent menu item."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The dropdown content."

  @doc "Renders the dropdown content of a navigation menu item."
  def navigation_menu_content(assigns) do
    ~H"""
    <div
      id={"#{@target}-content"}
      class={
        cn([
          "hidden",
          "absolute left-0 top-full mt-1.5 w-max",
          "rounded-md border bg-popover p-4 text-popover-foreground shadow-lg",
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
  # navigation_menu_link/1
  # ---------------------------------------------------------------------------

  attr :navigate, :string, default: nil, doc: "LiveView navigate path."
  attr :href, :string, default: nil, doc: "Standard href link."
  attr :active, :boolean, default: false, doc: "Whether this link is the current page."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The link content."

  @doc "Renders a navigation menu link."
  def navigation_menu_link(assigns) do
    ~H"""
    <.link
      :if={@navigate}
      navigate={@navigate}
      class={
        cn([
          "block select-none space-y-1 rounded-md p-3 leading-none no-underline outline-none transition-colors",
          "hover:bg-accent hover:text-accent-foreground",
          "focus:bg-accent focus:text-accent-foreground",
          @active && "bg-accent/50",
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
          "block select-none space-y-1 rounded-md p-3 leading-none no-underline outline-none transition-colors",
          "hover:bg-accent hover:text-accent-foreground",
          "focus:bg-accent focus:text-accent-foreground",
          @active && "bg-accent/50",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </a>
    <span
      :if={!@navigate && !@href}
      class={
        cn([
          "block select-none space-y-1 rounded-md p-3 leading-none no-underline outline-none transition-colors",
          "hover:bg-accent hover:text-accent-foreground",
          @active && "bg-accent/50",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </span>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp toggle_content(id) do
    JS.toggle(
      to: "##{id}-content",
      in: {"transition ease-out duration-200", "opacity-0 -translate-y-1", "opacity-100 translate-y-0"},
      out: {"transition ease-in duration-150", "opacity-100 translate-y-0", "opacity-0 -translate-y-1"}
    )
    |> JS.toggle_attribute({"data-state", "open", "closed"}, to: "##{id} button")
  end

  defp hide_content(id) do
    JS.hide(
      to: "##{id}-content",
      transition: {"transition ease-in duration-150", "opacity-100 translate-y-0", "opacity-0 -translate-y-1"}
    )
    |> JS.set_attribute({"data-state", "closed"}, to: "##{id} button")
  end
end
