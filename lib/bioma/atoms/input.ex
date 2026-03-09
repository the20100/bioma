defmodule Bioma.Atoms.Input do
  @moduledoc """
  An input component following shadcn/ui design patterns.

  Renders a styled text input with support for various input types,
  error states, and full Tailwind CSS styling using the semantic color system.

  ## Examples

      <.input name="email" type="email" placeholder="Enter your email" />
      <.input name="search" placeholder="Search..." class="max-w-sm" />
      <.input name="password" type="password" disabled />
      <.input name="username" errors={["is already taken"]} />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :type, :string, default: "text", doc: "The type of the input element."

  attr :name, :any, default: nil, doc: "The name of the input element."

  attr :value, :any, default: nil, doc: "The current value of the input element."

  attr :placeholder, :string, default: nil, doc: "Placeholder text for the input."

  attr :disabled, :boolean, default: false, doc: "Whether the input is disabled."

  attr :errors, :list, default: [], doc: "A list of error messages to display below the input."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the input element."

  @doc """
  Renders an input element with consistent styling and optional error display.
  """
  def input(assigns) do
    ~H"""
    <div>
      <input
        type={@type}
        name={@name}
        value={@value}
        placeholder={@placeholder}
        disabled={@disabled}
        class={
          cn([
            base_classes(),
            @errors != [] && "border-destructive focus-visible:ring-destructive",
            @class
          ])
        }
        {@rest}
      />
      <.input_errors :if={@errors != []} errors={@errors} />
    </div>
    """
  end

  defp input_errors(assigns) do
    ~H"""
    <div class="mt-1 flex flex-col gap-1">
      <p :for={error <- @errors} class="text-sm text-destructive">
        {error}
      </p>
    </div>
    """
  end

  defp base_classes do
    "flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
  end
end
