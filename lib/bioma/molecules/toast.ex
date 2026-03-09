defmodule Bioma.Molecules.Toast do
  @moduledoc """
  A toast notification component following shadcn/ui design patterns.

  Provides ephemeral notification messages with multiple variants. Toasts can
  be dismissed via a close button that uses `Phoenix.LiveView.JS` for smooth
  hide transitions. A `toast_group/1` component positions toasts in a fixed
  overlay at the top-right of the viewport.

  ## Examples

      <.toast_group>
        <.toast id="toast-1" variant="success">
          Changes saved successfully.
        </.toast>
        <.toast id="toast-2" variant="error">
          Something went wrong. Please try again.
        </.toast>
      </.toast_group>

      <.toast id="info-toast" variant="info">
        A new version is available.
      </.toast>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # toast_group/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The toast notifications."

  @doc """
  Renders a fixed-position container for toast notifications at the top-right of the viewport.
  """
  def toast_group(assigns) do
    ~H"""
    <div
      class={
        cn([
          "fixed top-0 right-0 z-[100] flex max-h-screen w-full flex-col-reverse gap-2 p-4 sm:max-w-[420px]",
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
  # toast/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the toast."

  attr :variant, :string,
    default: "default",
    values: ~w(default success error warning info),
    doc: "The visual style variant of the toast."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The toast message content."

  @doc """
  Renders a toast notification with a dismiss button.

  The dismiss button uses `Phoenix.LiveView.JS` to hide the toast with a
  fade-out and slide-out transition.
  """
  def toast(assigns) do
    ~H"""
    <div
      id={@id}
      role="status"
      aria-live="polite"
      class={
        cn([
          "group pointer-events-auto relative flex w-full items-center justify-between space-x-4 overflow-hidden rounded-md border p-4 pr-8 shadow-lg transition-all",
          variant_classes(@variant),
          @class
        ])
      }
      {@rest}
    >
      <div class="flex-1">
        {render_slot(@inner_block)}
      </div>
      <button
        type="button"
        aria-label="Dismiss"
        phx-click={dismiss_toast(@id)}
        class="absolute right-2 top-2 rounded-md p-1 text-foreground/50 opacity-0 transition-opacity hover:text-foreground focus:opacity-100 focus:outline-none focus:ring-2 group-hover:opacity-100"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
          class="h-4 w-4"
        >
          <path d="M18 6 6 18" /><path d="m6 6 12 12" />
        </svg>
      </button>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp dismiss_toast(id) do
    JS.hide(
      to: "##{id}",
      time: 200,
      transition: {"transition-all duration-200", "opacity-100 translate-x-0", "opacity-0 translate-x-full"}
    )
  end

  defp variant_classes("default"), do: "border bg-background text-foreground"
  defp variant_classes("success"), do: "border-ai-success/50 bg-ai-success text-ai-success-foreground"
  defp variant_classes("error"), do: "border-destructive/50 bg-destructive text-destructive-foreground"
  defp variant_classes("warning"), do: "border-ai-system/50 bg-ai-system text-ai-system-foreground"
  defp variant_classes("info"), do: "border-primary/50 bg-primary/10 text-primary"
end
