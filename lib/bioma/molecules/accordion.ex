defmodule Bioma.Molecules.Accordion do
  @moduledoc """
  An accordion component.

  Provides vertically stacked expandable/collapsible sections.
  Supports single (only one open) and multiple (any number open) modes.

  ## Examples

      <.accordion id="faq" type="single">
        <.accordion_item id="faq" value="item-1">
          <.accordion_trigger target="faq" value="item-1">
            What is this?
          </.accordion_trigger>
          <.accordion_content target="faq" value="item-1">
            <p>This is an accordion component.</p>
          </.accordion_content>
        </.accordion_item>
      </.accordion>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # accordion/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the accordion."

  attr :type, :string,
    default: "single",
    values: ~w(single multiple),
    doc: "Whether one or multiple items can be open."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The accordion items."

  @doc "Renders an accordion container."
  def accordion(assigns) do
    ~H"""
    <div
      id={@id}
      data-type={@type}
      class={cn([@class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # accordion_item/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "The accordion container id."
  attr :value, :string, required: true, doc: "The unique value identifying this item."
  attr :open, :boolean, default: false, doc: "Whether this item is initially open."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger and content."

  @doc "Renders an accordion item."
  def accordion_item(assigns) do
    ~H"""
    <div
      id={"#{@id}-item-#{@value}"}
      data-state={if(@open, do: "open", else: "closed")}
      class={cn(["border-b", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # accordion_trigger/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The accordion container id."
  attr :value, :string, required: true, doc: "The value of the item this trigger controls."
  attr :type, :string, default: "single", values: ~w(single multiple), doc: "Accordion type."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger label."

  @doc "Renders the button that toggles an accordion item."
  def accordion_trigger(assigns) do
    ~H"""
    <h3 class="flex">
      <button
        type="button"
        aria-expanded="false"
        aria-controls={"#{@target}-content-#{@value}"}
        phx-click={toggle_item(@target, @value, @type)}
        class={
          cn([
            "flex flex-1 items-center justify-between py-4 font-medium transition-all hover:underline",
            "[&>svg]:transition-transform [&>svg]:duration-200",
            @class
          ])
        }
        {@rest}
      >
        {render_slot(@inner_block)}
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
          class="h-4 w-4 shrink-0"
        >
          <path d="m6 9 6 6 6-6" />
        </svg>
      </button>
    </h3>
    """
  end

  # ---------------------------------------------------------------------------
  # accordion_content/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The accordion container id."
  attr :value, :string, required: true, doc: "The value of the item."
  attr :open, :boolean, default: false, doc: "Whether the content is initially visible."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The accordion content."

  @doc "Renders the content panel of an accordion item."
  def accordion_content(assigns) do
    ~H"""
    <div
      id={"#{@target}-content-#{@value}"}
      role="region"
      aria-labelledby={"#{@target}-trigger-#{@value}"}
      class={cn([!@open && "hidden", "overflow-hidden text-sm transition-all", @class])}
      {@rest}
    >
      <div class="pb-4 pt-0">
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp toggle_item(target, value, "single") do
    # Single mode: hide all other contents, then toggle this one
    %JS{}
    |> JS.hide(to: "##{target} [id$='-content-']:not(##{target}-content-#{value})")
    |> JS.set_attribute({"data-state", "closed"},
      to: "##{target} [id^='#{target}-item-']:not(##{target}-item-#{value})"
    )
    |> JS.toggle(
      to: "##{target}-content-#{value}",
      in: {"transition ease-out duration-200", "opacity-0", "opacity-100"},
      out: {"transition ease-in duration-150", "opacity-100", "opacity-0"}
    )
    |> JS.toggle_attribute({"data-state", "open", "closed"}, to: "##{target}-item-#{value}")
  end

  defp toggle_item(target, value, "multiple") do
    # Multiple mode: just toggle this item
    JS.toggle(
      to: "##{target}-content-#{value}",
      in: {"transition ease-out duration-200", "opacity-0", "opacity-100"},
      out: {"transition ease-in duration-150", "opacity-100", "opacity-0"}
    )
    |> JS.toggle_attribute({"data-state", "open", "closed"}, to: "##{target}-item-#{value}")
  end
end
