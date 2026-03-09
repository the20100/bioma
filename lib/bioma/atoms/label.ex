defmodule Bioma.Atoms.Label do
  @moduledoc """
  A label component following shadcn/ui design patterns.

  Renders a styled label element associated with a form control.
  Supports peer-disabled styling for accessibility.

  ## Examples

      <.label for="email">Email address</.label>
      <.label for="name" class="mb-2">Full name</.label>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :for, :string, default: nil, doc: "The ID of the form element this label is associated with."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the label element."

  slot :inner_block, required: true, doc: "The content of the label."

  @doc """
  Renders a label element with consistent styling.
  """
  def label(assigns) do
    ~H"""
    <label
      for={@for}
      class={
        cn([
          "text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </label>
    """
  end
end
