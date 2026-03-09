defmodule Storybook.Molecules.DropdownMenu do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.DropdownMenu.dropdown/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default dropdown",
        attributes: %{id: "demo-dropdown"},
        slots: [
          ~s|<:trigger>|,
          ~s|  <button class="px-4 py-2 border rounded-md text-sm">Open Menu</button>|,
          ~s|</:trigger>|,
          ~s|<:content>|,
          ~s|  <Bioma.Molecules.DropdownMenu.dropdown_label>Actions</Bioma.Molecules.DropdownMenu.dropdown_label>|,
          ~s|  <Bioma.Molecules.DropdownMenu.dropdown_separator />|,
          ~s|  <Bioma.Molecules.DropdownMenu.dropdown_item>Edit</Bioma.Molecules.DropdownMenu.dropdown_item>|,
          ~s|  <Bioma.Molecules.DropdownMenu.dropdown_item>Duplicate</Bioma.Molecules.DropdownMenu.dropdown_item>|,
          ~s|  <Bioma.Molecules.DropdownMenu.dropdown_separator />|,
          ~s|  <Bioma.Molecules.DropdownMenu.dropdown_item>Delete</Bioma.Molecules.DropdownMenu.dropdown_item>|,
          ~s|</:content>|
        ]
      }
    ]
  end
end
