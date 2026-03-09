defmodule Bioma.Organisms.AI.ChatInput do
  @moduledoc """
  A chat input component for composing messages in AI conversations.

  Renders a form with an auto-resizing textarea and a send button. Supports
  keyboard submission via Cmd/Ctrl+Enter and displays a loading spinner when
  submitting. An optional `actions` slot allows adding extra controls such as
  file upload buttons.

  Requires the `TextareaAutosize` LiveView hook for auto-resizing behavior.

  ## Examples

      <.chat_input phx-submit="send_message" />

      <.chat_input
        id="chat-input"
        placeholder="Ask me anything..."
        submitting={@sending}
        phx-submit="send_message"
      />

      <.chat_input phx-submit="send_message">
        <:actions>
          <button type="button" phx-click="attach_file">
            Attach
          </button>
        </:actions>
      </.chat_input>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :id, :string,
    default: "chat-input",
    doc: "The unique identifier for the chat input form."

  attr :placeholder, :string,
    default: "Type a message...",
    doc: "Placeholder text for the textarea."

  attr :disabled, :boolean,
    default: false,
    doc: "Whether the input is disabled."

  attr :submitting, :boolean,
    default: false,
    doc: "Whether a message is currently being submitted. Shows a spinner and disables the send button."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global,
    include: ~w(phx-submit),
    doc: "Additional HTML attributes, including phx-submit for the form."

  slot :actions, doc: "Optional slot for additional action buttons (e.g., file upload)."

  @doc """
  Renders a chat input form with an auto-resizing textarea and send button.
  """
  def chat_input(assigns) do
    assigns = assign(assigns, :textarea_id, "#{assigns.id}-textarea")

    ~H"""
    <form
      id={@id}
      class={
        cn([
          "flex items-end gap-2 p-4 border-t bg-background",
          @class
        ])
      }
      {@rest}
    >
      <%!-- Optional action buttons --%>
      <div :if={@actions != []} class="flex items-center gap-1">
        {render_slot(@actions)}
      </div>
      <%!-- Auto-resizing textarea --%>
      <textarea
        id={@textarea_id}
        name="message"
        placeholder={@placeholder}
        disabled={@disabled}
        rows="1"
        phx-hook="TextareaAutosize"
        data-max-rows="6"
        phx-keydown="chat_input_keydown"
        class={
          cn([
            "flex-1 min-h-[40px] resize-none border-0 bg-transparent",
            "focus:ring-0 focus:outline-none text-sm",
            "placeholder:text-muted-foreground",
            "disabled:cursor-not-allowed disabled:opacity-50"
          ])
        }
      />
      <%!-- Send button --%>
      <button
        type="submit"
        disabled={@disabled || @submitting}
        class={
          cn([
            "h-10 w-10 rounded-full bg-primary text-primary-foreground",
            "flex items-center justify-center shrink-0",
            "hover:bg-primary/90 transition-colors",
            "disabled:pointer-events-none disabled:opacity-50"
          ])
        }
      >
        <svg
          :if={!@submitting}
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
          class="h-4 w-4"
        >
          <path d="m22 2-7 20-4-9-9-4Z" />
          <path d="M22 2 11 13" />
        </svg>
        <svg
          :if={@submitting}
          class="h-4 w-4 animate-spin"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
        >
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" />
          <path
            class="opacity-75"
            fill="currentColor"
            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
          />
        </svg>
      </button>
    </form>
    """
  end
end
