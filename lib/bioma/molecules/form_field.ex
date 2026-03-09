defmodule Bioma.Molecules.FormField do
  @moduledoc """
  A form field component.

  Composable wrapper that ties together label, input control, description
  text, and error messages for Phoenix forms.

  ## Examples

      <.form_field field={@form[:name]}>
        <.form_label>Name</.form_label>
        <input type="text" name={@form[:name].name} value={@form[:name].value}
               class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm" />
        <.form_description>Enter your full name.</.form_description>
        <.form_message errors={@form[:name].errors} />
      </.form_field>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # form_field/1
  # ---------------------------------------------------------------------------

  attr :field, Phoenix.HTML.FormField,
    default: nil,
    doc: "A Phoenix form field for automatic id/name/error extraction."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The field label, input, description, and error messages."

  @doc "Renders a form field wrapper."
  def form_field(assigns) do
    ~H"""
    <div class={cn(["space-y-2", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # form_label/1
  # ---------------------------------------------------------------------------

  attr :for, :string, default: nil, doc: "The id of the input element this label is for."
  attr :error, :boolean, default: false, doc: "Whether the associated field has errors."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The label text."

  @doc "Renders a form field label."
  def form_label(assigns) do
    ~H"""
    <label
      for={@for}
      class={
        cn([
          "text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70",
          @error && "text-destructive",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </label>
    """
  end

  # ---------------------------------------------------------------------------
  # form_description/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The description text."

  @doc "Renders a form field description/help text."
  def form_description(assigns) do
    ~H"""
    <p class={cn(["text-sm text-muted-foreground", @class])} {@rest}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  # ---------------------------------------------------------------------------
  # form_message/1
  # ---------------------------------------------------------------------------

  attr :errors, :list, default: [], doc: "List of error messages to display."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders form field error messages."
  def form_message(assigns) do
    ~H"""
    <p
      :for={error <- @errors}
      class={cn(["text-sm font-medium text-destructive", @class])}
      {@rest}
    >
      {translate_error(error)}
    </p>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", fn _ -> to_string(value) end)
    end)
  end

  defp translate_error(msg) when is_binary(msg), do: msg
end
