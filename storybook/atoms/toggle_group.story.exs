defmodule Storybook.Atoms.ToggleGroup do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.ToggleGroup.toggle_group/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default toggle group",
        attributes: %{type: "single"},
        slots: [
          ~s|<Bioma.Atoms.ToggleGroup.toggle_group_item value="bold" pressed={true}><strong>B</strong></Bioma.Atoms.ToggleGroup.toggle_group_item>|,
          ~s|<Bioma.Atoms.ToggleGroup.toggle_group_item value="italic"><em>I</em></Bioma.Atoms.ToggleGroup.toggle_group_item>|,
          ~s|<Bioma.Atoms.ToggleGroup.toggle_group_item value="underline"><u>U</u></Bioma.Atoms.ToggleGroup.toggle_group_item>|
        ]
      },
      %Variation{
        id: :outline,
        description: "Outline variant",
        attributes: %{type: "multiple"},
        slots: [
          ~s|<Bioma.Atoms.ToggleGroup.toggle_group_item value="a" variant="outline" pressed={true}>A</Bioma.Atoms.ToggleGroup.toggle_group_item>|,
          ~s|<Bioma.Atoms.ToggleGroup.toggle_group_item value="b" variant="outline">B</Bioma.Atoms.ToggleGroup.toggle_group_item>|,
          ~s|<Bioma.Atoms.ToggleGroup.toggle_group_item value="c" variant="outline" pressed={true}>C</Bioma.Atoms.ToggleGroup.toggle_group_item>|
        ]
      }
    ]
  end
end
