defmodule Storybook.Atoms.Separator do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Separator.separator/1

  def variations do
    [
      %Variation{
        id: :horizontal,
        description: "Horizontal separator",
        attributes: %{orientation: "horizontal"}
      },
      %Variation{
        id: :vertical,
        description: "Vertical separator",
        attributes: %{orientation: "vertical", class: "h-8"}
      }
    ]
  end
end
