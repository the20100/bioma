defmodule Storybook.Atoms.Skeleton do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Skeleton.skeleton/1

  def variations do
    [
      %Variation{
        id: :line,
        description: "Text line skeleton",
        attributes: %{class: "h-4 w-[250px]"}
      },
      %Variation{
        id: :circle,
        description: "Avatar skeleton",
        attributes: %{class: "h-12 w-12 rounded-full"}
      },
      %Variation{
        id: :card,
        description: "Card skeleton",
        attributes: %{class: "h-[125px] w-[250px]"}
      }
    ]
  end
end
