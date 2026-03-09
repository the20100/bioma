defmodule Bioma.Atoms.InputOTP do
  @moduledoc """
  An OTP (one-time password) input component.

  Renders individual digit slots with automatic focus management.

  ## Examples

      <.input_otp id="verify-code" length={6} name="code" />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # input_otp/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the OTP input."
  attr :length, :integer, default: 6, doc: "Number of OTP digits."
  attr :name, :string, default: nil, doc: "The form field name."
  attr :value, :string, default: "", doc: "The current OTP value."
  attr :disabled, :boolean, default: false, doc: "Whether the input is disabled."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-change), doc: "Additional HTML attributes."

  @doc "Renders an OTP input with individual digit slots."
  def input_otp(assigns) do
    digits = String.graphemes(assigns.value || "")

    assigns =
      assign(assigns, :digits, digits)

    ~H"""
    <div
      id={@id}
      phx-hook="InputOTP"
      data-length={@length}
      class={cn(["flex items-center gap-2", @class])}
      {@rest}
    >
      <input type="hidden" name={@name} value={@value} id={"#{@id}-hidden"} />
      <div class="flex items-center gap-2">
        <%= for i <- 0..(@length - 1) do %>
          <%= if i == 3 && @length == 6 do %>
            <div class="flex items-center text-muted-foreground">
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
                class="h-4 w-4"
              >
                <line x1="5" y1="12" x2="19" y2="12" />
              </svg>
            </div>
          <% end %>
          <input
            type="text"
            inputmode="numeric"
            maxlength="1"
            pattern="[0-9]"
            autocomplete="one-time-code"
            disabled={@disabled}
            value={Enum.at(@digits, i, "")}
            data-index={i}
            class={
              cn([
                "flex h-10 w-10 items-center justify-center rounded-md border border-input bg-background text-center text-sm",
                "ring-offset-background",
                "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
                "disabled:cursor-not-allowed disabled:opacity-50"
              ])
            }
          />
        <% end %>
      </div>
    </div>
    """
  end
end
