defmodule Bioma.Atoms.Textarea do
  @moduledoc """
  A textarea component following shadcn/ui design patterns.

  Renders a styled textarea with optional autosize behavior via a Phoenix
  LiveView hook. Uses the semantic color system for consistent theming.

  ## Examples

      <.textarea name="message" placeholder="Type your message..." />
      <.textarea name="bio" rows={5} class="max-w-lg" />
      <.textarea name="content" autosize placeholder="Auto-expanding..." />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :name, :any, default: nil, doc: "The name of the textarea element."

  attr :value, :any, default: nil, doc: "The current value of the textarea."

  attr :placeholder, :string, default: nil, doc: "Placeholder text for the textarea."

  attr :rows, :integer, default: 3, doc: "The number of visible text rows."

  attr :disabled, :boolean, default: false, doc: "Whether the textarea is disabled."

  attr :autosize, :boolean,
    default: false,
    doc: "Whether to enable auto-resizing via the TextareaAutosize hook."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the textarea element."

  @doc """
  Renders a textarea element with consistent styling and optional auto-resizing.
  """
  def textarea(assigns) do
    ~H"""
    <textarea
      name={@name}
      placeholder={@placeholder}
      rows={@rows}
      disabled={@disabled}
      phx-hook={@autosize && "TextareaAutosize"}
      id={@autosize && (@rest[:id] || "textarea-#{@name}")}
      class={
        cn([
          base_classes(),
          @autosize && "resize-none",
          @class
        ])
      }
      {@rest}
    >{@value}</textarea>
    """
  end

  defp base_classes do
    "flex min-h-[80px] w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
  end
end
