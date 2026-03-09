defmodule Storybook.Molecules.Tabs do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Tabs.tabs/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default tabs",
        attributes: %{id: "demo-tabs", default: "tab1"},
        slots: [
          ~s|<Bioma.Molecules.Tabs.tabs_list>|,
          ~s|  <Bioma.Molecules.Tabs.tabs_trigger value="tab1" target="demo-tabs">Account</Bioma.Molecules.Tabs.tabs_trigger>|,
          ~s|  <Bioma.Molecules.Tabs.tabs_trigger value="tab2" target="demo-tabs">Settings</Bioma.Molecules.Tabs.tabs_trigger>|,
          ~s|</Bioma.Molecules.Tabs.tabs_list>|,
          ~s|<Bioma.Molecules.Tabs.tabs_content value="tab1" target="demo-tabs" default="tab1">Account content here.</Bioma.Molecules.Tabs.tabs_content>|,
          ~s|<Bioma.Molecules.Tabs.tabs_content value="tab2" target="demo-tabs" default="tab1">Settings content here.</Bioma.Molecules.Tabs.tabs_content>|
        ]
      }
    ]
  end
end
