defmodule Bioma.Molecules.Dialog do
  @moduledoc """
  A dialog (modal) component.

  Renders a modal overlay with a backdrop that renders underlying content as inert.
  Supports close via X button, click-away, and Escape key.

  ## Examples

      <.dialog id="my-dialog">
        <.dialog_trigger target="my-dialog">
          <button class="btn">Open Dialog</button>
        </.dialog_trigger>
        <.dialog_content target="my-dialog">
          <.dialog_header>
            <.dialog_title>Edit Profile</.dialog_title>
            <.dialog_description>Make changes to your profile here.</.dialog_description>
          </.dialog_header>
          <p>Dialog content goes here.</p>
          <.dialog_footer>
            <button class="btn" phx-click={hide_dialog("my-dialog")}>Save</button>
          </.dialog_footer>
        </.dialog_content>
      </.dialog>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # dialog/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the dialog."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The dialog trigger and content."

  @doc "Renders a dialog container."
  def dialog(assigns) do
    ~H"""
    <div id={@id} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # dialog_trigger/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the dialog to open."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger element."

  @doc "Renders the element that opens the dialog."
  def dialog_trigger(assigns) do
    ~H"""
    <div phx-click={show_dialog(@target)} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # dialog_content/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent dialog."
  attr :show_close, :boolean, default: true, doc: "Whether to show the close button."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The dialog content."

  @doc "Renders the dialog overlay, backdrop, and content panel."
  def dialog_content(assigns) do
    ~H"""
    <%!-- Backdrop + content wrapper --%>
    <div
      id={"#{@target}-overlay"}
      phx-window-keydown={hide_dialog(@target)}
      phx-key="Escape"
      class="hidden fixed inset-0 z-50"
    >
      <%!-- Backdrop --%>
      <div
        class="fixed inset-0 bg-black/80"
        phx-click={hide_dialog(@target)}
        aria-hidden="true"
      />
      <%!-- Content --%>
      <div
        role="dialog"
        aria-modal="true"
        aria-labelledby={"#{@target}-title"}
        aria-describedby={"#{@target}-description"}
        class={
          cn([
            "fixed left-1/2 top-1/2 z-50 -translate-x-1/2 -translate-y-1/2",
            "grid w-full max-w-lg gap-4 border bg-background p-6 shadow-lg",
            "rounded-lg sm:rounded-lg",
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
          phx-click={hide_dialog(@target)}
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
  # dialog_header/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The header content (title, description)."

  @doc "Renders the dialog header section."
  def dialog_header(assigns) do
    ~H"""
    <div class={cn(["flex flex-col space-y-1.5 text-center sm:text-left", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # dialog_footer/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The footer content (action buttons)."

  @doc "Renders the dialog footer section."
  def dialog_footer(assigns) do
    ~H"""
    <div
      class={
        cn([
          "flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2",
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
  # dialog_title/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The title text."

  @doc "Renders the dialog title."
  def dialog_title(assigns) do
    ~H"""
    <h2
      class={cn(["text-lg font-semibold leading-none tracking-tight", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </h2>
    """
  end

  # ---------------------------------------------------------------------------
  # dialog_description/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The description text."

  @doc "Renders the dialog description."
  def dialog_description(assigns) do
    ~H"""
    <p class={cn(["text-sm text-muted-foreground", @class])} {@rest}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  # ---------------------------------------------------------------------------
  # dialog_close/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the dialog to close."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The close button content."

  @doc "Renders a button that closes the dialog."
  def dialog_close(assigns) do
    ~H"""
    <div phx-click={hide_dialog(@target)} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Public JS helpers (for use in templates)
  # ---------------------------------------------------------------------------

  @doc "Returns a JS command to show the dialog."
  def show_dialog(id) do
    JS.show(
      to: "##{id}-overlay",
      transition: {"transition ease-out duration-200", "opacity-0", "opacity-100"}
    )
    |> JS.focus_first(to: "##{id}-overlay [role=dialog]")
  end

  @doc "Returns a JS command to hide the dialog."
  def hide_dialog(id) do
    JS.hide(
      to: "##{id}-overlay",
      transition: {"transition ease-in duration-150", "opacity-100", "opacity-0"}
    )
  end
end
