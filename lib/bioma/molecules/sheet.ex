defmodule Bioma.Molecules.Sheet do
  @moduledoc """
  A sheet (slide-out panel) component.

  Extends the dialog pattern with a panel that slides in from an edge of the screen.

  ## Examples

      <.sheet id="settings-sheet">
        <.sheet_trigger target="settings-sheet">
          <button class="btn">Open Settings</button>
        </.sheet_trigger>
        <.sheet_content target="settings-sheet" side="right">
          <.sheet_header>
            <.sheet_title>Settings</.sheet_title>
            <.sheet_description>Adjust your preferences.</.sheet_description>
          </.sheet_header>
          <p>Sheet content here.</p>
        </.sheet_content>
      </.sheet>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # sheet/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the sheet."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The sheet trigger and content."

  @doc "Renders a sheet container."
  def sheet(assigns) do
    ~H"""
    <div id={@id} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # sheet_trigger/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the sheet to open."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger element."

  @doc "Renders the element that opens the sheet."
  def sheet_trigger(assigns) do
    ~H"""
    <div phx-click={show_sheet(@target)} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # sheet_content/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent sheet."

  attr :side, :string,
    default: "right",
    values: ~w(top right bottom left),
    doc: "The side from which the sheet slides in."

  attr :show_close, :boolean, default: true, doc: "Whether to show the close button."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The sheet content."

  @doc "Renders the sheet overlay, backdrop, and content panel."
  def sheet_content(assigns) do
    ~H"""
    <div
      id={"#{@target}-overlay"}
      phx-window-keydown={hide_sheet(@target)}
      phx-key="Escape"
      class="hidden fixed inset-0 z-50"
    >
      <%!-- Backdrop --%>
      <div
        class="fixed inset-0 bg-black/80"
        phx-click={hide_sheet(@target)}
        aria-hidden="true"
      />
      <%!-- Content panel --%>
      <div
        role="dialog"
        aria-modal="true"
        class={
          cn([
            "fixed z-50 gap-4 bg-background p-6 shadow-lg transition-transform",
            side_classes(@side),
            @class
          ])
        }
        {@rest}
      >
        {render_slot(@inner_block)}
        <%!-- Close button --%>
        <button
          :if={@show_close}
          type="button"
          aria-label="Close"
          phx-click={hide_sheet(@target)}
          class="absolute right-4 top-4 rounded-sm opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2"
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
            <path d="M18 6 6 18" />
            <path d="m6 6 12 12" />
          </svg>
        </button>
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # sheet_header/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The header content."

  @doc "Renders the sheet header."
  def sheet_header(assigns) do
    ~H"""
    <div class={cn(["flex flex-col space-y-2 text-center sm:text-left", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # sheet_footer/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The footer content."

  @doc "Renders the sheet footer."
  def sheet_footer(assigns) do
    ~H"""
    <div class={cn(["flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # sheet_title/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The title text."

  @doc "Renders the sheet title."
  def sheet_title(assigns) do
    ~H"""
    <h2 class={cn(["text-lg font-semibold text-foreground", @class])} {@rest}>
      {render_slot(@inner_block)}
    </h2>
    """
  end

  # ---------------------------------------------------------------------------
  # sheet_description/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The description text."

  @doc "Renders the sheet description."
  def sheet_description(assigns) do
    ~H"""
    <p class={cn(["text-sm text-muted-foreground", @class])} {@rest}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  # ---------------------------------------------------------------------------
  # sheet_close/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the sheet to close."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The close button content."

  @doc "Renders a button that closes the sheet."
  def sheet_close(assigns) do
    ~H"""
    <div phx-click={hide_sheet(@target)} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Public JS helpers
  # ---------------------------------------------------------------------------

  @doc "Returns a JS command to show the sheet."
  def show_sheet(id) do
    JS.show(
      to: "##{id}-overlay",
      transition: {"transition ease-out duration-300", "opacity-0", "opacity-100"}
    )
  end

  @doc "Returns a JS command to hide the sheet."
  def hide_sheet(id) do
    JS.hide(
      to: "##{id}-overlay",
      transition: {"transition ease-in duration-200", "opacity-100", "opacity-0"}
    )
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp side_classes("right"), do: "inset-y-0 right-0 h-full w-3/4 border-l sm:max-w-sm"
  defp side_classes("left"), do: "inset-y-0 left-0 h-full w-3/4 border-r sm:max-w-sm"
  defp side_classes("top"), do: "inset-x-0 top-0 border-b"
  defp side_classes("bottom"), do: "inset-x-0 bottom-0 border-t"
end
