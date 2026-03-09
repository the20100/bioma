defmodule Storybook.Molecules.Progress do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Progress.progress/1

  def variations do
    [
      %Variation{
        id: :quarter,
        description: "25% progress",
        attributes: %{value: 25}
      },
      %Variation{
        id: :half,
        description: "50% progress",
        attributes: %{value: 50}
      },
      %Variation{
        id: :full,
        description: "100% progress",
        attributes: %{value: 100}
      }
    ]
  end
end
