defmodule Bioma.Molecules.Pagination do
  @moduledoc """
  A pagination component.

  Provides navigation controls for paginated content with previous/next
  buttons and numbered page links.

  ## Examples

      <.pagination>
        <.pagination_content>
          <.pagination_item>
            <.pagination_previous navigate={~p"/page/1"} />
          </.pagination_item>
          <.pagination_item>
            <.pagination_link navigate={~p"/page/1"} active={true}>1</.pagination_link>
          </.pagination_item>
          <.pagination_item>
            <.pagination_link navigate={~p"/page/2"}>2</.pagination_link>
          </.pagination_item>
          <.pagination_item>
            <.pagination_ellipsis />
          </.pagination_item>
          <.pagination_item>
            <.pagination_next navigate={~p"/page/2"} />
          </.pagination_item>
        </.pagination_content>
      </.pagination>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # pagination/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The pagination content."

  @doc "Renders the pagination navigation wrapper."
  def pagination(assigns) do
    ~H"""
    <nav
      role="navigation"
      aria-label="pagination"
      class={cn(["mx-auto flex w-full justify-center", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </nav>
    """
  end

  # ---------------------------------------------------------------------------
  # pagination_content/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The pagination items."

  @doc "Renders the pagination list container."
  def pagination_content(assigns) do
    ~H"""
    <ul class={cn(["flex flex-row items-center gap-1", @class])} {@rest}>
      {render_slot(@inner_block)}
    </ul>
    """
  end

  # ---------------------------------------------------------------------------
  # pagination_item/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The pagination link or control."

  @doc "Renders a pagination list item."
  def pagination_item(assigns) do
    ~H"""
    <li class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </li>
    """
  end

  # ---------------------------------------------------------------------------
  # pagination_link/1
  # ---------------------------------------------------------------------------

  attr :active, :boolean, default: false, doc: "Whether this is the current page."
  attr :navigate, :string, default: nil, doc: "LiveView navigate path."
  attr :href, :string, default: nil, doc: "Standard href link."
  attr :disabled, :boolean, default: false, doc: "Whether the link is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click phx-value-page), doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The page number or label."

  @doc "Renders a pagination page link."
  def pagination_link(assigns) do
    assigns = assign(assigns, :tag, if(assigns.navigate, do: :link, else: :button))

    ~H"""
    <.link
      :if={@navigate}
      navigate={@navigate}
      aria-current={if(@active, do: "page")}
      class={
        cn([
          "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "h-10 w-10",
          if(@active, do: "border border-input bg-background hover:bg-accent hover:text-accent-foreground",
            else: "hover:bg-accent hover:text-accent-foreground"),
          @disabled && "pointer-events-none opacity-50",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </.link>
    <button
      :if={!@navigate}
      type="button"
      aria-current={if(@active, do: "page")}
      disabled={@disabled}
      class={
        cn([
          "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "h-10 w-10",
          if(@active, do: "border border-input bg-background hover:bg-accent hover:text-accent-foreground",
            else: "hover:bg-accent hover:text-accent-foreground"),
          @disabled && "pointer-events-none opacity-50",
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
  # pagination_previous/1
  # ---------------------------------------------------------------------------

  attr :navigate, :string, default: nil, doc: "LiveView navigate path."
  attr :href, :string, default: nil, doc: "Standard href link."
  attr :disabled, :boolean, default: false, doc: "Whether the button is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click phx-value-page), doc: "Additional HTML attributes."

  @doc "Renders a 'Previous' pagination button."
  def pagination_previous(assigns) do
    ~H"""
    <.link
      :if={@navigate}
      navigate={@navigate}
      aria-label="Go to previous page"
      class={
        cn([
          "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "hover:bg-accent hover:text-accent-foreground",
          "h-10 px-4 py-2 gap-1",
          @disabled && "pointer-events-none opacity-50",
          @class
        ])
      }
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
        <path d="m15 18-6-6 6-6" />
      </svg>
      <span>Previous</span>
    </.link>
    <button
      :if={!@navigate}
      type="button"
      aria-label="Go to previous page"
      disabled={@disabled}
      class={
        cn([
          "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "hover:bg-accent hover:text-accent-foreground",
          "h-10 px-4 py-2 gap-1",
          "disabled:pointer-events-none disabled:opacity-50",
          @class
        ])
      }
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
        <path d="m15 18-6-6 6-6" />
      </svg>
      <span>Previous</span>
    </button>
    """
  end

  # ---------------------------------------------------------------------------
  # pagination_next/1
  # ---------------------------------------------------------------------------

  attr :navigate, :string, default: nil, doc: "LiveView navigate path."
  attr :href, :string, default: nil, doc: "Standard href link."
  attr :disabled, :boolean, default: false, doc: "Whether the button is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click phx-value-page), doc: "Additional HTML attributes."

  @doc "Renders a 'Next' pagination button."
  def pagination_next(assigns) do
    ~H"""
    <.link
      :if={@navigate}
      navigate={@navigate}
      aria-label="Go to next page"
      class={
        cn([
          "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "hover:bg-accent hover:text-accent-foreground",
          "h-10 px-4 py-2 gap-1",
          @disabled && "pointer-events-none opacity-50",
          @class
        ])
      }
      {@rest}
    >
      <span>Next</span>
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
        <path d="m9 18 6-6-6-6" />
      </svg>
    </.link>
    <button
      :if={!@navigate}
      type="button"
      aria-label="Go to next page"
      disabled={@disabled}
      class={
        cn([
          "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "hover:bg-accent hover:text-accent-foreground",
          "h-10 px-4 py-2 gap-1",
          "disabled:pointer-events-none disabled:opacity-50",
          @class
        ])
      }
      {@rest}
    >
      <span>Next</span>
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
        <path d="m9 18 6-6-6-6" />
      </svg>
    </button>
    """
  end

  # ---------------------------------------------------------------------------
  # pagination_ellipsis/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders an ellipsis indicator for skipped pages."
  def pagination_ellipsis(assigns) do
    ~H"""
    <span
      aria-hidden="true"
      class={cn(["flex h-10 w-10 items-center justify-center", @class])}
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
      <span class="sr-only">More pages</span>
    </span>
    """
  end
end
