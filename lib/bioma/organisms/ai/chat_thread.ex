defmodule Bioma.Organisms.AI.ChatThread do
  @moduledoc """
  A chat thread container component for AI conversations.

  Provides a scrollable container with auto-scroll-to-bottom behavior via the
  `ScrollBottom` LiveView hook. Consumers render their own message list inside
  the `inner_block` slot.

  ## Examples

      <.chat_thread id="conversation-1">
        <.chat_message :for={msg <- @messages} role={msg.role} content={msg.content} />
      </.chat_thread>

      <.chat_thread id="thread-main" class="h-[600px]">
        <%= for msg <- @messages do %>
          <.chat_message
            role={msg.role}
            content={msg.content}
            name={msg.sender_name}
            timestamp={msg.formatted_time}
          />
        <% end %>
      </.chat_thread>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :id, :string, required: true, doc: "A unique identifier for the chat thread container."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the container."

  slot :inner_block, required: true, doc: "The message list content rendered by the consumer."

  @doc """
  Renders a scrollable chat thread container with auto-scroll behavior.
  """
  def chat_thread(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="ScrollBottom"
      class={
        cn([
          "flex flex-col flex-1 overflow-y-auto space-y-4 p-4",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end
end
