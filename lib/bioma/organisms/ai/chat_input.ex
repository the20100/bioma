defmodule Bioma.Organisms.AI.ChatInput do
  @moduledoc """
  A chat input component for composing messages in AI conversations.

  Supports two layout variants:

  - `"card"` (default) — A rounded card container with the textarea on top and
    a toolbar below. The toolbar holds tool toggles on the left, an optional
    model selector, and action buttons + send on the right. An optional
    `quick_actions` chip row renders below the card.

  - `"default"` — The legacy flat bar layout with everything in a single row.

  Requires the `TextareaAutosize` LiveView hook for auto-resizing behavior.

  ## Examples

      <.chat_input phx-submit="send_message" />

      <.chat_input
        placeholder="Ask me anything..."
        submitting={@sending}
        phx-submit="send_message"
      >
        <:tools>
          <button type="button" class="p-1.5 rounded-md hover:bg-muted text-muted-foreground">
            <svg ...><!-- attachment icon --></svg>
          </button>
        </:tools>
        <:model_selector>
          <.model_selector models={@models} selected={@model} />
        </:model_selector>
        <:actions>
          <button type="button" class="p-1.5 rounded-md hover:bg-muted text-muted-foreground">
            <svg ...><!-- mic icon --></svg>
          </button>
        </:actions>
        <:quick_actions>
          <button class="px-3 py-1 rounded-full border text-xs">Summary</button>
          <button class="px-3 py-1 rounded-full border text-xs">Code</button>
        </:quick_actions>
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
    doc: "Whether a message is currently being submitted. Shows a pixel loader and disables the send button."

  attr :variant, :string,
    default: "card",
    values: ~w(default card),
    doc: "Layout variant. `\"card\"` renders a rounded card container with toolbar; `\"default\"` is the legacy flat bar."

  attr :max_rows, :integer,
    default: 6,
    doc: "Maximum number of rows the textarea can grow to before scrolling."

  attr :show_send, :boolean,
    default: true,
    doc: "Whether to show the send button."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global,
    include: ~w(phx-submit),
    doc: "Additional HTML attributes, including phx-submit for the form."

  slot :tools, doc: "Left side of toolbar — tool toggle buttons (e.g., web search, file upload)."
  slot :actions, doc: "Right side of toolbar — action buttons before send (e.g., mic, emoji)."
  slot :model_selector, doc: "Optional model selector element in the toolbar."
  slot :quick_actions, doc: "Optional chip row rendered below the card container."

  @doc """
  Renders a chat input form with an auto-resizing textarea, toolbar, and send button.
  """
  def chat_input(%{variant: "card"} = assigns) do
    assigns = assign(assigns, :textarea_id, "#{assigns.id}-textarea")

    ~H"""
    <div class={cn(["px-4 pb-4", @class])}>
      <form
        id={@id}
        class={
          cn([
            "rounded-xl border bg-card shadow-sm",
            "focus-within:ring-2 focus-within:ring-ring focus-within:ring-offset-2 focus-within:ring-offset-background",
            "transition-shadow"
          ])
        }
        {@rest}
      >
        <%!-- Textarea area --%>
        <textarea
          id={@textarea_id}
          name="message"
          placeholder={@placeholder}
          disabled={@disabled}
          rows="1"
          phx-hook="TextareaAutosize"
          data-max-rows={@max_rows}
          phx-keydown="chat_input_keydown"
          class={
            cn([
              textarea_base_classes(),
              "w-full px-4 pt-3 pb-1"
            ])
          }
        />
        <%!-- Toolbar row --%>
        <div class="flex items-center gap-1 px-2 pb-2">
          <%!-- Left side: tools --%>
          <div :if={@tools != []} class="flex items-center gap-0.5">
            {render_slot(@tools)}
          </div>
          <%!-- Model selector --%>
          <div :if={@model_selector != []} class="flex items-center">
            {render_slot(@model_selector)}
          </div>
          <%!-- Spacer --%>
          <div class="flex-1" />
          <%!-- Right side: actions + send --%>
          <div :if={@actions != []} class="flex items-center gap-0.5">
            {render_slot(@actions)}
          </div>
          <.send_button :if={@show_send} disabled={@disabled} submitting={@submitting} />
        </div>
      </form>
      <%!-- Quick actions below card --%>
      <div :if={@quick_actions != []} class="flex items-center gap-2 mt-2 px-1">
        {render_slot(@quick_actions)}
      </div>
    </div>
    """
  end

  def chat_input(%{variant: "default"} = assigns) do
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
      <%!-- Tool buttons --%>
      <div :if={@tools != []} class="flex items-center gap-1">
        {render_slot(@tools)}
      </div>
      <%!-- Auto-resizing textarea --%>
      <textarea
        id={@textarea_id}
        name="message"
        placeholder={@placeholder}
        disabled={@disabled}
        rows="1"
        phx-hook="TextareaAutosize"
        data-max-rows={@max_rows}
        phx-keydown="chat_input_keydown"
        class={cn([textarea_base_classes()])}
      />
      <%!-- Model selector --%>
      <div :if={@model_selector != []} class="flex items-center">
        {render_slot(@model_selector)}
      </div>
      <%!-- Action buttons --%>
      <div :if={@actions != []} class="flex items-center gap-1">
        {render_slot(@actions)}
      </div>
      <%!-- Send button --%>
      <.send_button :if={@show_send} disabled={@disabled} submitting={@submitting} />
    </form>
    <div :if={@quick_actions != []} class="flex items-center gap-2 px-4 py-2">
      {render_slot(@quick_actions)}
    </div>
    """
  end

  defp textarea_base_classes do
    "flex-1 min-h-[40px] resize-none border-0 bg-transparent " <>
      "focus:ring-0 focus:outline-none text-sm " <>
      "placeholder:text-muted-foreground " <>
      "disabled:cursor-not-allowed disabled:opacity-50"
  end

  attr :disabled, :boolean, required: true
  attr :submitting, :boolean, required: true

  defp send_button(assigns) do
    ~H"""
    <button
      type="submit"
      disabled={@disabled || @submitting}
      class={
        cn([
          "h-8 w-8 rounded-full bg-primary text-primary-foreground",
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
      <%!-- Pixel loader when submitting --%>
      <span :if={@submitting} class="inline-flex items-end gap-[1px]">
        <span class="w-[3px] h-[3px] bg-current rounded-none animate-pixel-bounce" />
        <span class="w-[3px] h-[3px] bg-current rounded-none animate-pixel-bounce-delay-1" />
        <span class="w-[3px] h-[3px] bg-current rounded-none animate-pixel-bounce-delay-2" />
      </span>
    </button>
    """
  end
end
