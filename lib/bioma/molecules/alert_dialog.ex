defmodule Bioma.Molecules.AlertDialog do
  @moduledoc """
  An alert dialog component.

  A modal that interrupts the user with important content requiring an explicit
  response. Unlike Dialog, it cannot be dismissed by clicking away.

  ## Examples

      <.alert_dialog id="confirm-delete">
        <.alert_dialog_trigger target="confirm-delete">
          <button class="btn">Delete</button>
        </.alert_dialog_trigger>
        <.alert_dialog_content target="confirm-delete">
          <.alert_dialog_header>
            <.alert_dialog_title>Are you sure?</.alert_dialog_title>
            <.alert_dialog_description>
              This action cannot be undone.
            </.alert_dialog_description>
          </.alert_dialog_header>
          <.alert_dialog_footer>
            <.alert_dialog_cancel target="confirm-delete">Cancel</.alert_dialog_cancel>
            <.alert_dialog_action phx-click="delete">Delete</.alert_dialog_action>
          </.alert_dialog_footer>
        </.alert_dialog_content>
      </.alert_dialog>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # alert_dialog/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the alert dialog."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The alert dialog trigger and content."

  @doc "Renders an alert dialog container."
  def alert_dialog(assigns) do
    ~H"""
    <div id={@id} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # alert_dialog_trigger/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the alert dialog to open."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger element."

  @doc "Renders the element that opens the alert dialog."
  def alert_dialog_trigger(assigns) do
    ~H"""
    <div phx-click={show_alert_dialog(@target)} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # alert_dialog_content/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent alert dialog."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The alert dialog content."

  @doc "Renders the alert dialog overlay, backdrop, and content panel."
  def alert_dialog_content(assigns) do
    ~H"""
    <div id={"#{@target}-overlay"} hidden class="fixed inset-0 z-50">
      <%!-- Backdrop (no click-away dismiss) --%>
      <div class="fixed inset-0 bg-black/80" aria-hidden="true" />
      <%!-- Content --%>
      <div
        role="alertdialog"
        aria-modal="true"
        aria-labelledby={"#{@target}-title"}
        aria-describedby={"#{@target}-description"}
        class={
          cn([
            "fixed left-1/2 top-1/2 z-50 -translate-x-1/2 -translate-y-1/2",
            "grid w-full max-w-lg gap-4 border bg-background p-6 shadow-lg rounded-lg",
            @class
          ])
        }
        {@rest}
      >
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # alert_dialog_header/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The header content."

  @doc "Renders the alert dialog header."
  def alert_dialog_header(assigns) do
    ~H"""
    <div class={cn(["flex flex-col space-y-2 text-center sm:text-left", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # alert_dialog_footer/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The footer content."

  @doc "Renders the alert dialog footer."
  def alert_dialog_footer(assigns) do
    ~H"""
    <div
      class={cn(["flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # alert_dialog_title/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The title text."

  @doc "Renders the alert dialog title."
  def alert_dialog_title(assigns) do
    ~H"""
    <h2 class={cn(["text-lg font-semibold", @class])} {@rest}>
      {render_slot(@inner_block)}
    </h2>
    """
  end

  # ---------------------------------------------------------------------------
  # alert_dialog_description/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The description text."

  @doc "Renders the alert dialog description."
  def alert_dialog_description(assigns) do
    ~H"""
    <p class={cn(["text-sm text-muted-foreground", @class])} {@rest}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  # ---------------------------------------------------------------------------
  # alert_dialog_cancel/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the alert dialog to close."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The cancel button text."

  @doc "Renders the cancel button that closes the alert dialog."
  def alert_dialog_cancel(assigns) do
    ~H"""
    <button
      type="button"
      phx-click={hide_alert_dialog(@target)}
      class={
        cn([
          "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "border border-input bg-background hover:bg-accent hover:text-accent-foreground",
          "h-10 px-4 py-2 mt-2 sm:mt-0",
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
  # alert_dialog_action/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click), doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The action button text."

  @doc "Renders the action button."
  def alert_dialog_action(assigns) do
    ~H"""
    <button
      type="button"
      class={
        cn([
          "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "bg-primary text-primary-foreground hover:bg-primary/90",
          "h-10 px-4 py-2",
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
  # Public JS helpers
  # ---------------------------------------------------------------------------

  @doc "Returns a JS command to show the alert dialog."
  def show_alert_dialog(id) do
    JS.show(
      to: "##{id}-overlay",
      transition: {"transition ease-out duration-200", "opacity-0", "opacity-100"}
    )
    |> JS.focus_first(to: "##{id}-overlay [role=alertdialog]")
  end

  @doc "Returns a JS command to hide the alert dialog."
  def hide_alert_dialog(id) do
    JS.hide(
      to: "##{id}-overlay",
      transition: {"transition ease-in duration-150", "opacity-100", "opacity-0"}
    )
  end
end
