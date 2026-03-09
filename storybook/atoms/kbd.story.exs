defmodule Storybook.Atoms.Kbd do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Kbd.kbd/1

  def variations do
    [
      %Variation{
        id: :single_key,
        description: "Single key",
        slots: ["K"]
      },
      %Variation{
        id: :shortcut,
        description: "Keyboard shortcut",
        slots: ["⌘K"]
      }
    ]
  end
end
