defmodule Storybook.Atoms.Collapsible do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Collapsible.collapsible/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default collapsible",
        attributes: %{id: "demo-collapsible"},
        slots: [
          ~s|<Bioma.Atoms.Collapsible.collapsible_trigger target="demo-collapsible">|,
          ~s|  <button class="flex items-center gap-2 text-sm font-medium">Toggle <span class="text-xs text-muted-foreground">(click me)</span></button>|,
          ~s|</Bioma.Atoms.Collapsible.collapsible_trigger>|,
          ~s|<Bioma.Atoms.Collapsible.collapsible_content target="demo-collapsible">|,
          ~s|  <div class="rounded-md border px-4 py-3 text-sm mt-2">Collapsible content here.</div>|,
          ~s|</Bioma.Atoms.Collapsible.collapsible_content>|
        ]
      },
      %Variation{
        id: :initially_open,
        description: "Initially open",
        attributes: %{id: "demo-collapsible-open", open: true},
        slots: [
          ~s|<Bioma.Atoms.Collapsible.collapsible_trigger target="demo-collapsible-open">|,
          ~s|  <button class="text-sm font-medium">Toggle Content</button>|,
          ~s|</Bioma.Atoms.Collapsible.collapsible_trigger>|,
          ~s|<Bioma.Atoms.Collapsible.collapsible_content target="demo-collapsible-open" open={true}>|,
          ~s|  <div class="rounded-md border px-4 py-3 text-sm mt-2">This content is visible by default.</div>|,
          ~s|</Bioma.Atoms.Collapsible.collapsible_content>|
        ]
      }
    ]
  end
end
