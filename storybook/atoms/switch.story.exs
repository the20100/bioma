defmodule Storybook.Atoms.Switch do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Switch.switch/1

  def variations do
    [
      %Variation{
        id: :unchecked,
        description: "Unchecked switch",
        attributes: %{checked: false, name: "notifications"}
      },
      %Variation{
        id: :checked,
        description: "Checked switch",
        attributes: %{checked: true, name: "notifications"}
      },
      %Variation{
        id: :disabled,
        description: "Disabled switch",
        attributes: %{disabled: true, name: "notifications"}
      }
    ]
  end
end
