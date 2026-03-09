defmodule Bioma.Molecules.Resizable do
  @moduledoc """
  A resizable panel component.

  Provides resizable panel layouts with drag handles. Uses a JS hook for
  mouse/touch drag interactions.

  ## Examples

      <.resizable_panel_group id="my-panels" direction="horizontal">
        <.resizable_panel default_size={70}>
          Left panel content
        </.resizable_panel>
        <.resizable_handle target="my-panels" />
        <.resizable_panel default_size={30}>
          Right panel content
        </.resizable_panel>
      </.resizable_panel_group>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # resizable_panel_group/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the panel group."

  attr :direction, :string,
    default: "horizontal",
    values: ~w(horizontal vertical),
    doc: "The resize direction."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The panels and handles."

  @doc "Renders a resizable panel group container."
  def resizable_panel_group(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="Resizable"
      data-direction={@direction}
      class={
        cn([
          "flex h-full w-full",
          @direction == "vertical" && "flex-col",
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
  # resizable_panel/1
  # ---------------------------------------------------------------------------

  attr :default_size, :integer, default: 50, doc: "Default size as a percentage (0-100)."
  attr :min_size, :integer, default: 10, doc: "Minimum size as a percentage."
  attr :max_size, :integer, default: 90, doc: "Maximum size as a percentage."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The panel content."

  @doc "Renders a resizable panel."
  def resizable_panel(assigns) do
    ~H"""
    <div
      data-panel
      data-min-size={@min_size}
      data-max-size={@max_size}
      style={"flex-basis: #{@default_size}%"}
      class={cn(["overflow-auto", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # resizable_handle/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent panel group."
  attr :with_handle, :boolean, default: false, doc: "Whether to show a visible grip handle."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders a drag handle between resizable panels."
  def resizable_handle(assigns) do
    ~H"""
    <div
      data-handle
      role="separator"
      tabindex="0"
      class={
        cn([
          "relative flex items-center justify-center bg-border",
          "after:absolute after:inset-y-0 after:left-1/2 after:w-1 after:-translate-x-1/2",
          "focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring focus-visible:ring-offset-1",
          "data-[direction=horizontal]:w-px data-[direction=horizontal]:cursor-col-resize",
          "data-[direction=vertical]:h-px data-[direction=vertical]:cursor-row-resize",
          @class
        ])
      }
      {@rest}
    >
      <div
        :if={@with_handle}
        class="z-10 flex h-4 w-3 items-center justify-center rounded-sm border bg-border"
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
          class="h-2.5 w-2.5"
        >
          <circle cx="9" cy="12" r="1" />
          <circle cx="9" cy="5" r="1" />
          <circle cx="9" cy="19" r="1" />
          <circle cx="15" cy="12" r="1" />
          <circle cx="15" cy="5" r="1" />
          <circle cx="15" cy="19" r="1" />
        </svg>
      </div>
    </div>
    """
  end
end
