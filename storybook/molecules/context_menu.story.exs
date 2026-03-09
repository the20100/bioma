defmodule Storybook.Molecules.ContextMenu do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.ContextMenu.context_menu/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Right-click context menu",
        attributes: %{id: "demo-context-menu"},
        slots: [
          ~s|<:trigger>|,
          ~s|  <div class="flex h-32 w-64 items-center justify-center rounded-md border border-dashed text-sm text-muted-foreground">Right click here</div>|,
          ~s|</:trigger>|,
          ~s|<:content>|,
          ~s|  <Bioma.Molecules.ContextMenu.context_menu_item>Cut</Bioma.Molecules.ContextMenu.context_menu_item>|,
          ~s|  <Bioma.Molecules.ContextMenu.context_menu_item>Copy</Bioma.Molecules.ContextMenu.context_menu_item>|,
          ~s|  <Bioma.Molecules.ContextMenu.context_menu_item>Paste</Bioma.Molecules.ContextMenu.context_menu_item>|,
          ~s|  <Bioma.Molecules.ContextMenu.context_menu_separator />|,
          ~s|  <Bioma.Molecules.ContextMenu.context_menu_item destructive={true}>Delete</Bioma.Molecules.ContextMenu.context_menu_item>|,
          ~s|</:content>|
        ]
      }
    ]
  end
end
