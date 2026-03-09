defmodule Storybook.Atoms.Typography do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Typography.h1/1

  def variations do
    [
      %Variation{
        id: :h1,
        description: "Heading 1",
        slots: ["Heading One"]
      }
    ]
  end
end
