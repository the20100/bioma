defmodule Storybook.Organisms.AI.TokenCounter do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.TokenCounter.token_counter/1

  def variations do
    [
      %Variation{
        id: :with_limit,
        description: "With limit",
        attributes: %{used: 1250, limit: 4096}
      },
      %Variation{
        id: :near_limit,
        description: "Near limit (>90%)",
        attributes: %{used: 3800, limit: 4096}
      },
      %Variation{
        id: :no_limit,
        description: "Without limit",
        attributes: %{used: 2500}
      }
    ]
  end
end
