defmodule Bioma.Atoms.Breadcrumb do
  @moduledoc """
  A breadcrumb component.

  Displays the navigation path showing the user's current location
  within the application hierarchy.

  ## Examples

      <.breadcrumb>
        <.breadcrumb_list>
          <.breadcrumb_item>
            <.breadcrumb_link navigate={~p"/"}>Home</.breadcrumb_link>
          </.breadcrumb_item>
          <.breadcrumb_separator />
          <.breadcrumb_item>
            <.breadcrumb_link navigate={~p"/settings"}>Settings</.breadcrumb_link>
          </.breadcrumb_item>
          <.breadcrumb_separator />
          <.breadcrumb_item>
            <.breadcrumb_page>Profile</.breadcrumb_page>
          </.breadcrumb_item>
        </.breadcrumb_list>
      </.breadcrumb>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # breadcrumb/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The breadcrumb list."

  @doc "Renders the breadcrumb navigation wrapper."
  def breadcrumb(assigns) do
    ~H"""
    <nav aria-label="breadcrumb" class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </nav>
    """
  end

  # ---------------------------------------------------------------------------
  # breadcrumb_list/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The breadcrumb items."

  @doc "Renders the ordered list container for breadcrumb items."
  def breadcrumb_list(assigns) do
    ~H"""
    <ol
      class={
        cn([
          "flex flex-wrap items-center gap-1.5 break-words text-sm text-muted-foreground sm:gap-2.5",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </ol>
    """
  end

  # ---------------------------------------------------------------------------
  # breadcrumb_item/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The breadcrumb link or page."

  @doc "Renders a single breadcrumb item."
  def breadcrumb_item(assigns) do
    ~H"""
    <li class={cn(["inline-flex items-center gap-1.5", @class])} {@rest}>
      {render_slot(@inner_block)}
    </li>
    """
  end

  # ---------------------------------------------------------------------------
  # breadcrumb_link/1
  # ---------------------------------------------------------------------------

  attr :navigate, :string, default: nil, doc: "LiveView navigate path."
  attr :href, :string, default: nil, doc: "Standard href link."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The link text."

  @doc "Renders a breadcrumb link."
  def breadcrumb_link(assigns) do
    ~H"""
    <.link
      :if={@navigate}
      navigate={@navigate}
      class={cn(["transition-colors hover:text-foreground", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    <a
      :if={@href && !@navigate}
      href={@href}
      class={cn(["transition-colors hover:text-foreground", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </a>
    <span
      :if={!@navigate && !@href}
      class={cn(["transition-colors hover:text-foreground", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </span>
    """
  end

  # ---------------------------------------------------------------------------
  # breadcrumb_page/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The current page text."

  @doc "Renders the current (non-linked) breadcrumb page."
  def breadcrumb_page(assigns) do
    ~H"""
    <span
      role="link"
      aria-disabled="true"
      aria-current="page"
      class={cn(["font-normal text-foreground", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </span>
    """
  end

  # ---------------------------------------------------------------------------
  # breadcrumb_separator/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, doc: "Custom separator content. Defaults to a chevron icon."

  @doc "Renders a separator between breadcrumb items."
  def breadcrumb_separator(assigns) do
    ~H"""
    <li role="presentation" aria-hidden="true" class={cn(["[&>svg]:size-3.5", @class])} {@rest}>
      <%= if @inner_block != [] do %>
        {render_slot(@inner_block)}
      <% else %>
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
        >
          <path d="m9 18 6-6-6-6" />
        </svg>
      <% end %>
    </li>
    """
  end

  # ---------------------------------------------------------------------------
  # breadcrumb_ellipsis/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders an ellipsis indicator for collapsed breadcrumb items."
  def breadcrumb_ellipsis(assigns) do
    ~H"""
    <span
      role="presentation"
      aria-hidden="true"
      class={cn(["flex h-9 w-9 items-center justify-center", @class])}
      {@rest}
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
        <circle cx="12" cy="12" r="1" />
        <circle cx="19" cy="12" r="1" />
        <circle cx="5" cy="12" r="1" />
      </svg>
      <span class="sr-only">More</span>
    </span>
    """
  end
end
