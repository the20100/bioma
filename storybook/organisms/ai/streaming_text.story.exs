defmodule Storybook.Organisms.AI.StreamingText do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.StreamingText.streaming_text/1

  def variations do
    [
      %Variation{
        id: :static,
        description: "Static text (not streaming)",
        attributes: %{
          id: "stream-static",
          content: "This is complete text that has finished streaming.",
          streaming: false
        }
      },
      %Variation{
        id: :streaming,
        description: "Streaming state (with cursor)",
        attributes: %{
          id: "stream-active",
          content: "This text is being streamed",
          streaming: true
        }
      }
    ]
  end
end
