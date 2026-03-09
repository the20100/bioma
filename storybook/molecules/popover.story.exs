defmodule Storybook.Molecules.Popover do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Popover.popover/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default popover",
        attributes: %{id: "demo-popover"},
        slots: [
          ~s|<:trigger>|,
          ~s|  <button class="px-4 py-2 border rounded-md text-sm">Open Popover</button>|,
          ~s|</:trigger>|,
          ~s|<:content>|,
          ~s|  <div class="space-y-2">|,
          ~s|    <h4 class="font-medium leading-none">Settings</h4>|,
          ~s|    <p class="text-sm text-muted-foreground">Configure your preferences.</p>|,
          ~s|  </div>|,
          ~s|</:content>|
        ]
      }
    ]
  end
end
