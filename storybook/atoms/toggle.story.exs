defmodule Storybook.Atoms.Toggle do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Toggle.toggle/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default toggle",
        attributes: %{pressed: false},
        slots: ["Bold"]
      },
      %Variation{
        id: :pressed,
        description: "Pressed toggle",
        attributes: %{pressed: true},
        slots: ["Bold"]
      },
      %Variation{
        id: :outline,
        description: "Outline variant",
        attributes: %{variant: "outline"},
        slots: ["Italic"]
      }
    ]
  end
end
