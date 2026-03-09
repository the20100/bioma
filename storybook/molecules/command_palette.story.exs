defmodule Storybook.Molecules.CommandPalette do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.CommandPalette.command/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Command palette",
        attributes: %{class: "w-[400px] border rounded-lg shadow-md"},
        slots: [
          ~s|<Bioma.Molecules.CommandPalette.command_input placeholder="Type a command..." />|,
          ~s|<Bioma.Molecules.CommandPalette.command_list>|,
          ~s|  <Bioma.Molecules.CommandPalette.command_group heading="Suggestions">|,
          ~s|    <Bioma.Molecules.CommandPalette.command_item>New Chat</Bioma.Molecules.CommandPalette.command_item>|,
          ~s|    <Bioma.Molecules.CommandPalette.command_item>Search Conversations</Bioma.Molecules.CommandPalette.command_item>|,
          ~s|  </Bioma.Molecules.CommandPalette.command_group>|,
          ~s|  <Bioma.Molecules.CommandPalette.command_separator />|,
          ~s|  <Bioma.Molecules.CommandPalette.command_group heading="Settings">|,
          ~s|    <Bioma.Molecules.CommandPalette.command_item>Change Model</Bioma.Molecules.CommandPalette.command_item>|,
          ~s|    <Bioma.Molecules.CommandPalette.command_item>Preferences</Bioma.Molecules.CommandPalette.command_item>|,
          ~s|  </Bioma.Molecules.CommandPalette.command_group>|,
          ~s|</Bioma.Molecules.CommandPalette.command_list>|
        ]
      }
    ]
  end
end
