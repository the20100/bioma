defmodule Bioma.Atoms.Collapsible do
  @moduledoc """
  A collapsible component.

  Provides an expandable/collapsible section with a trigger and content area.

  ## Examples

      <.collapsible id="my-collapsible">
        <.collapsible_trigger target="my-collapsible">
          Toggle
        </.collapsible_trigger>
        <.collapsible_content target="my-collapsible">
          <p>Collapsible content here.</p>
        </.collapsible_content>
      </.collapsible>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # collapsible/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the collapsible."
  attr :open, :boolean, default: false, doc: "Whether the collapsible is initially open."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The collapsible trigger and content."

  @doc "Renders a collapsible container."
  def collapsible(assigns) do
    ~H"""
    <div
      id={@id}
      data-state={if(@open, do: "open", else: "closed")}
      class={cn([@class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # collapsible_trigger/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent collapsible."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger content."

  @doc "Renders the trigger that toggles the collapsible content."
  def collapsible_trigger(assigns) do
    ~H"""
    <div phx-click={toggle_content(@target)} class={cn([@class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # collapsible_content/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent collapsible."
  attr :open, :boolean, default: false, doc: "Whether the content is initially visible."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The collapsible content."

  @doc "Renders the collapsible content area."
  def collapsible_content(assigns) do
    ~H"""
    <div
      id={"#{@target}-content"}
      class={cn([!@open && "hidden", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp toggle_content(target) do
    JS.toggle(
      to: "##{target}-content",
      in: {"transition ease-out duration-200", "opacity-0 -translate-y-1", "opacity-100 translate-y-0"},
      out: {"transition ease-in duration-150", "opacity-100 translate-y-0", "opacity-0 -translate-y-1"}
    )
    |> JS.toggle_attribute({"data-state", "open", "closed"}, to: "##{target}")
  end
end
