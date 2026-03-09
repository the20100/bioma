defmodule Storybook.Atoms.Label do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Label.label/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default label",
        slots: ["Email address"]
      }
    ]
  end
end
