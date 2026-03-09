defmodule Bioma.Molecules.Popover do
  @moduledoc """
  A popover component following shadcn/ui design patterns.

  Provides a toggleable overlay for displaying rich content using named slots.
  Uses `Phoenix.LiveView.JS` for client-side show/hide behavior.

  ## Examples

      <.popover id="my-popover">
        <:trigger>
          <button>Open Popover</button>
        </:trigger>
        <:content>
          <div class="space-y-2">
            <h4 class="font-medium leading-none">Settings</h4>
            <p class="text-sm text-muted-foreground">Configure preferences.</p>
          </div>
        </:content>
      </.popover>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # popover/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the popover."

  attr :position, :string,
    default: "bottom-start",
    values: ~w(bottom-start bottom-end top-start top-end),
    doc: "The position of the popover content relative to the trigger."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :trigger, required: true, doc: "The trigger element (usually a button)."
  slot :content, required: true, doc: "The popover content."

  @doc """
  Renders a popover with trigger and content slots.
  """
  def popover(assigns) do
    ~H"""
    <div
      id={@id}
      phx-click-away={hide_content(@id)}
      class={cn(["relative inline-block", @class])}
      {@rest}
    >
      <div phx-click={toggle_content(@id)}>
        {render_slot(@trigger)}
      </div>
      <div
        id={"#{@id}-content"}
        class={cn([
          "hidden",
          "absolute z-50 w-72 rounded-md border bg-popover p-4 text-popover-foreground shadow-md outline-none",
          position_classes(@position)
        ])}
      >
        {render_slot(@content)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp toggle_content(id) do
    JS.toggle(
      to: "##{id}-content",
      in:
        {"transition ease-out duration-200", "opacity-0 translate-y-1",
         "opacity-100 translate-y-0"},
      out:
        {"transition ease-in duration-150", "opacity-100 translate-y-0",
         "opacity-0 translate-y-1"}
    )
  end

  defp hide_content(id) do
    JS.hide(
      to: "##{id}-content",
      transition:
        {"transition ease-in duration-150", "opacity-100 translate-y-0",
         "opacity-0 translate-y-1"}
    )
  end

  defp position_classes("bottom-start"), do: "top-full left-0 mt-2"
  defp position_classes("bottom-end"), do: "top-full right-0 mt-2"
  defp position_classes("top-start"), do: "bottom-full left-0 mb-2"
  defp position_classes("top-end"), do: "bottom-full right-0 mb-2"
end
