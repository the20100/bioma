defmodule Storybook.Atoms.Checkbox do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Checkbox.checkbox/1

  def variations do
    [
      %Variation{
        id: :unchecked,
        description: "Unchecked",
        attributes: %{checked: false, name: "terms"}
      },
      %Variation{
        id: :checked,
        description: "Checked",
        attributes: %{checked: true, name: "terms"}
      },
      %Variation{
        id: :disabled,
        description: "Disabled",
        attributes: %{disabled: true, name: "terms"}
      }
    ]
  end
end
