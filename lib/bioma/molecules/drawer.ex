defmodule Bioma.Molecules.Drawer do
  @moduledoc """
  A drawer component.

  A mobile-friendly slide-out panel with touch drag-to-dismiss support.
  Uses a JS hook for drag gestures.

  ## Examples

      <.drawer id="my-drawer">
        <.drawer_trigger target="my-drawer">
          <button class="btn">Open Drawer</button>
        </.drawer_trigger>
        <.drawer_content target="my-drawer" direction="bottom">
          <.drawer_header>
            <.drawer_title>Settings</.drawer_title>
            <.drawer_description>Adjust your preferences.</.drawer_description>
          </.drawer_header>
          <p>Content here.</p>
        </.drawer_content>
      </.drawer>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # drawer/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the drawer."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The drawer trigger and content."

  @doc "Renders a drawer container."
  def drawer(assigns) do
    ~H"""
    <div id={@id} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # drawer_trigger/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the drawer to open."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger element."

  @doc "Renders the element that opens the drawer."
  def drawer_trigger(assigns) do
    ~H"""
    <div phx-click={show_drawer(@target)} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # drawer_content/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent drawer."

  attr :direction, :string,
    default: "bottom",
    values: ~w(top bottom left right),
    doc: "The direction from which the drawer slides in."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The drawer content."

  @doc "Renders the drawer overlay, backdrop, and content panel."
  def drawer_content(assigns) do
    ~H"""
    <div
      id={"#{@target}-overlay"}
      phx-hook="Drawer"
      data-direction={@direction}
      phx-window-keydown={hide_drawer(@target)}
      phx-key="Escape"
      class="hidden fixed inset-0 z-50"
    >
      <%!-- Backdrop --%>
      <div
        id={"#{@target}-backdrop"}
        class="fixed inset-0 bg-black/80"
        phx-click={hide_drawer(@target)}
        aria-hidden="true"
      />
      <%!-- Content panel --%>
      <div
        id={"#{@target}-panel"}
        role="dialog"
        aria-modal="true"
        class={
          cn([
            "fixed z-50 bg-background shadow-lg transition-transform",
            direction_classes(@direction),
            @class
          ])
        }
        {@rest}
      >
        <%!-- Drag handle for bottom/top drawers --%>
        <div
          :if={@direction in ["bottom", "top"]}
          class="mx-auto mt-4 h-2 w-[100px] rounded-full bg-muted"
        />
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # drawer_header/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The header content."

  @doc "Renders the drawer header."
  def drawer_header(assigns) do
    ~H"""
    <div class={cn(["grid gap-1.5 p-4 text-center sm:text-left", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # drawer_footer/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The footer content."

  @doc "Renders the drawer footer."
  def drawer_footer(assigns) do
    ~H"""
    <div class={cn(["mt-auto flex flex-col gap-2 p-4", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # drawer_title/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The title text."

  @doc "Renders the drawer title."
  def drawer_title(assigns) do
    ~H"""
    <h2 class={cn(["text-lg font-semibold leading-none tracking-tight", @class])} {@rest}>
      {render_slot(@inner_block)}
    </h2>
    """
  end

  # ---------------------------------------------------------------------------
  # drawer_description/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The description text."

  @doc "Renders the drawer description."
  def drawer_description(assigns) do
    ~H"""
    <p class={cn(["text-sm text-muted-foreground", @class])} {@rest}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  # ---------------------------------------------------------------------------
  # drawer_close/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the drawer to close."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The close button content."

  @doc "Renders a button that closes the drawer."
  def drawer_close(assigns) do
    ~H"""
    <div phx-click={hide_drawer(@target)} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Public JS helpers
  # ---------------------------------------------------------------------------

  @doc "Returns a JS command to show the drawer."
  def show_drawer(id) do
    JS.show(
      to: "##{id}-overlay",
      transition: {"transition ease-out duration-300", "opacity-0", "opacity-100"}
    )
  end

  @doc "Returns a JS command to hide the drawer."
  def hide_drawer(id) do
    JS.hide(
      to: "##{id}-overlay",
      transition: {"transition ease-in duration-200", "opacity-100", "opacity-0"}
    )
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp direction_classes("bottom"), do: "inset-x-0 bottom-0 border-t rounded-t-[10px] max-h-[96vh]"
  defp direction_classes("top"), do: "inset-x-0 top-0 border-b rounded-b-[10px] max-h-[96vh]"
  defp direction_classes("left"), do: "inset-y-0 left-0 h-full w-3/4 border-r sm:max-w-sm"
  defp direction_classes("right"), do: "inset-y-0 right-0 h-full w-3/4 border-l sm:max-w-sm"
end
