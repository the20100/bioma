defmodule Bioma.Atoms.Checkbox do
  @moduledoc """
  A checkbox component.

  Renders a styled checkbox with a checkmark icon when checked.
  Includes a hidden input for form submission.

  ## Examples

      <.checkbox name="terms" />
      <.checkbox checked={true} name="agree" />
      <.checkbox disabled={true} name="locked" />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :checked, :boolean, default: false
  attr :name, :string, default: nil
  attr :value, :string, default: "true"
  attr :disabled, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(phx-click phx-change)

  def checkbox(assigns) do
    ~H"""
    <span class="inline-flex items-center">
      <input type="hidden" name={@name} value="false" />
      <input
        type="checkbox"
        name={@name}
        value={@value}
        checked={@checked}
        disabled={@disabled}
        class="sr-only peer"
        {@rest}
      />
      <button
        type="button"
        role="checkbox"
        aria-checked={to_string(@checked)}
        disabled={@disabled}
        class={
          cn([
            "peer h-4 w-4 shrink-0 rounded-sm border border-primary ring-offset-background",
            "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
            "disabled:cursor-not-allowed disabled:opacity-50",
            if(@checked, do: "bg-primary text-primary-foreground", else: ""),
            @class
          ])
        }
      >
        <svg
          :if={@checked}
          class="h-3.5 w-3.5"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="3"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="M20 6 9 17l-5-5" />
        </svg>
      </button>
    </span>
    """
  end
end
