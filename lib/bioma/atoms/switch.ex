defmodule Bioma.Atoms.Switch do
  @moduledoc """
  A toggle switch component.

  Renders a switch input with track and thumb styling, suitable for boolean toggles.
  Includes a hidden input for form submission.

  ## Examples

      <.switch name="notifications" />
      <.switch checked={true} name="dark_mode" phx-click="toggle_dark_mode" />
      <.switch disabled={true} checked={@enabled} />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :checked, :boolean, default: false
  attr :name, :string, default: nil
  attr :value, :string, default: "true"
  attr :disabled, :boolean, default: false
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(phx-click phx-change phx-value-id phx-value-value)

  def switch(assigns) do
    ~H"""
    <label class="inline-flex items-center">
      <input type="hidden" name={@name} value="false" />
      <input
        type="checkbox"
        name={@name}
        value={@value}
        checked={@checked}
        disabled={@disabled}
        class="sr-only peer"
      />
      <button
        type="button"
        role="switch"
        aria-checked={to_string(@checked)}
        disabled={@disabled}
        {@rest}
        class={
          cn([
            "peer inline-flex h-6 w-11 shrink-0 cursor-pointer items-center rounded-full border-2 border-transparent transition-colors",
            "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 focus-visible:ring-offset-background",
            "disabled:cursor-not-allowed disabled:opacity-50",
            if(@checked, do: "bg-primary", else: "bg-input"),
            @class
          ])
        }
      >
        <span class={
          cn([
            "pointer-events-none block h-5 w-5 rounded-full bg-background shadow-lg ring-0 transition-transform",
            if(@checked, do: "translate-x-5", else: "translate-x-0")
          ])
        } />
      </button>
    </label>
    """
  end
end
