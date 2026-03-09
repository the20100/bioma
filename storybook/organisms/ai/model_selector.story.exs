defmodule Storybook.Organisms.AI.ModelSelector do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.ModelSelector.model_selector/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Model selector",
        attributes: %{
          models: [
            %{id: "claude-opus-4-6", name: "Claude Opus 4.6"},
            %{id: "claude-sonnet-4-6", name: "Claude Sonnet 4.6"},
            %{id: "claude-haiku-4-5", name: "Claude Haiku 4.5"}
          ],
          selected: "claude-sonnet-4-6"
        }
      }
    ]
  end
end
