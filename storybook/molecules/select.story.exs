defmodule Storybook.Molecules.Select do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Select.select/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default select",
        attributes: %{id: "demo-select", name: "fruit", placeholder: "Select a fruit", class: "w-[200px]"},
        slots: [
          ~s|<Bioma.Molecules.Select.select_content target="demo-select">|,
          ~s|  <Bioma.Molecules.Select.select_item value="apple" target="demo-select">Apple</Bioma.Molecules.Select.select_item>|,
          ~s|  <Bioma.Molecules.Select.select_item value="banana" target="demo-select">Banana</Bioma.Molecules.Select.select_item>|,
          ~s|  <Bioma.Molecules.Select.select_item value="cherry" target="demo-select">Cherry</Bioma.Molecules.Select.select_item>|,
          ~s|</Bioma.Molecules.Select.select_content>|
        ]
      },
      %Variation{
        id: :with_value,
        description: "With selected value",
        attributes: %{id: "demo-select-val", name: "fruit", value: "banana", label: "Banana", class: "w-[200px]"},
        slots: [
          ~s|<Bioma.Molecules.Select.select_content target="demo-select-val">|,
          ~s|  <Bioma.Molecules.Select.select_item value="apple" target="demo-select-val">Apple</Bioma.Molecules.Select.select_item>|,
          ~s|  <Bioma.Molecules.Select.select_item value="banana" target="demo-select-val" selected={true}>Banana</Bioma.Molecules.Select.select_item>|,
          ~s|  <Bioma.Molecules.Select.select_item value="cherry" target="demo-select-val">Cherry</Bioma.Molecules.Select.select_item>|,
          ~s|</Bioma.Molecules.Select.select_content>|
        ]
      }
    ]
  end
end
