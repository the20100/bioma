defmodule Bioma.Atoms.RadioGroup do
  @moduledoc """
  A radio group component.

  Renders a set of radio buttons where only one option can be selected.
  Uses hidden native radio inputs with custom styled indicators.

  ## Examples

      <.radio_group name="plan" value="pro">
        <.radio_group_item value="free" id="plan-free" />
        <.radio_group_item value="pro" id="plan-pro" />
        <.radio_group_item value="enterprise" id="plan-enterprise" />
      </.radio_group>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # radio_group/1
  # ---------------------------------------------------------------------------

  attr :name, :string, default: nil, doc: "The form field name for the radio group."
  attr :value, :string, default: nil, doc: "The currently selected value."
  attr :disabled, :boolean, default: false, doc: "Whether all radio items are disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The radio group items."

  @doc """
  Renders a radio group container.
  """
  def radio_group(assigns) do
    ~H"""
    <div
      role="radiogroup"
      class={cn(["grid gap-2", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # radio_group_item/1
  # ---------------------------------------------------------------------------

  attr :value, :string, required: true, doc: "The value of this radio item."
  attr :id, :string, default: nil, doc: "The HTML id for the radio input."
  attr :name, :string, default: nil, doc: "The form field name."
  attr :checked, :boolean, default: false, doc: "Whether this item is selected."
  attr :disabled, :boolean, default: false, doc: "Whether this item is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-click phx-change phx-value-value), doc: "Additional HTML attributes."

  @doc """
  Renders a single radio group item with a hidden input and styled indicator.
  """
  def radio_group_item(assigns) do
    ~H"""
    <span class="inline-flex items-center">
      <input
        type="radio"
        id={@id}
        name={@name}
        value={@value}
        checked={@checked}
        disabled={@disabled}
        class="sr-only peer"
        {@rest}
      />
      <label
        for={@id}
        class={
          cn([
            "aspect-square h-4 w-4 rounded-full border border-primary text-primary ring-offset-background",
            "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
            "disabled:cursor-not-allowed disabled:opacity-50",
            "flex items-center justify-center cursor-pointer",
            "peer-disabled:cursor-not-allowed peer-disabled:opacity-50",
            @class
          ])
        }
      >
        <span :if={@checked} class="h-2.5 w-2.5 rounded-full bg-current" />
      </label>
    </span>
    """
  end
end
