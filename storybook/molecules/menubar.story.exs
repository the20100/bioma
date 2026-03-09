defmodule Storybook.Molecules.Menubar do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Menubar.menubar/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default menubar",
        slots: [
          ~s|<Bioma.Molecules.Menubar.menubar_menu id="menu-file">|,
          ~s|  <Bioma.Molecules.Menubar.menubar_trigger target="menu-file">File</Bioma.Molecules.Menubar.menubar_trigger>|,
          ~s|  <Bioma.Molecules.Menubar.menubar_content target="menu-file">|,
          ~s|    <Bioma.Molecules.Menubar.menubar_item>New File</Bioma.Molecules.Menubar.menubar_item>|,
          ~s|    <Bioma.Molecules.Menubar.menubar_item>Open</Bioma.Molecules.Menubar.menubar_item>|,
          ~s|    <Bioma.Molecules.Menubar.menubar_separator />|,
          ~s|    <Bioma.Molecules.Menubar.menubar_item>Save</Bioma.Molecules.Menubar.menubar_item>|,
          ~s|  </Bioma.Molecules.Menubar.menubar_content>|,
          ~s|</Bioma.Molecules.Menubar.menubar_menu>|,
          ~s|<Bioma.Molecules.Menubar.menubar_menu id="menu-edit">|,
          ~s|  <Bioma.Molecules.Menubar.menubar_trigger target="menu-edit">Edit</Bioma.Molecules.Menubar.menubar_trigger>|,
          ~s|  <Bioma.Molecules.Menubar.menubar_content target="menu-edit">|,
          ~s|    <Bioma.Molecules.Menubar.menubar_item>Undo</Bioma.Molecules.Menubar.menubar_item>|,
          ~s|    <Bioma.Molecules.Menubar.menubar_item>Redo</Bioma.Molecules.Menubar.menubar_item>|,
          ~s|  </Bioma.Molecules.Menubar.menubar_content>|,
          ~s|</Bioma.Molecules.Menubar.menubar_menu>|
        ]
      }
    ]
  end
end
