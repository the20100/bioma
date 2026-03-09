defmodule Storybook.Organisms.AI.ThinkingIndicator do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.ThinkingIndicator.thinking_indicator/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default thinking indicator",
        attributes: %{id: "thinking-1"}
      },
      %Variation{
        id: :custom_text,
        description: "Custom text",
        attributes: %{id: "thinking-2", text: "Analyzing code..."}
      },
      %Variation{
        id: :with_content,
        description: "With expandable content",
        attributes: %{id: "thinking-3"},
        slots: ["Let me analyze this step by step. First, I need to consider the data structure..."]
      }
    ]
  end
end
