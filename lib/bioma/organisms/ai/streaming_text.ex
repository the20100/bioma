defmodule Bioma.Organisms.AI.StreamingText do
  @moduledoc """
  A streaming text component for displaying real-time AI-generated content.

  Displays text content with an animated blinking cursor while streaming is
  active. Uses a `StreamingText` LiveView hook for managing streaming updates
  from the server.

  ## Examples

      <.streaming_text id="response-1" content={@partial_response} streaming />

      <.streaming_text
        id="msg-42"
        content={@completed_text}
        streaming={false}
      />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :id, :string, required: true, doc: "A unique identifier for the streaming text element."

  attr :content, :string,
    default: "",
    doc: "The current text content to display."

  attr :streaming, :boolean,
    default: false,
    doc: "Whether the text is currently being streamed. Shows a blinking cursor when true."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the container."

  @doc """
  Renders a streaming text container with an optional blinking cursor.
  """
  def streaming_text(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="StreamingText"
      data-streaming={to_string(@streaming)}
      class={
        cn([
          "whitespace-pre-wrap break-words",
          @streaming && "after:content-['\u258B'] after:animate-pulse after:ml-0.5",
          @class
        ])
      }
      {@rest}
    >
      {@content}
    </div>
    """
  end
end
