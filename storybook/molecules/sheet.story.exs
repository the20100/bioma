defmodule Storybook.Molecules.Sheet do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Sheet.sheet/1

  def variations do
    [
      %Variation{
        id: :right,
        description: "Sheet from right",
        attributes: %{id: "demo-sheet-right"},
        slots: [
          ~s|<Bioma.Molecules.Sheet.sheet_trigger target="demo-sheet-right">|,
          ~s|  <button class="inline-flex items-center justify-center rounded-md text-sm font-medium border border-input bg-background hover:bg-accent hover:text-accent-foreground h-10 px-4 py-2">Open Sheet</button>|,
          ~s|</Bioma.Molecules.Sheet.sheet_trigger>|,
          ~s|<Bioma.Molecules.Sheet.sheet_content target="demo-sheet-right" side="right">|,
          ~s|  <Bioma.Molecules.Sheet.sheet_header>|,
          ~s|    <Bioma.Molecules.Sheet.sheet_title>Settings</Bioma.Molecules.Sheet.sheet_title>|,
          ~s|    <Bioma.Molecules.Sheet.sheet_description>Adjust your preferences here.</Bioma.Molecules.Sheet.sheet_description>|,
          ~s|  </Bioma.Molecules.Sheet.sheet_header>|,
          ~s|  <div class="py-4 text-sm">Sheet content goes here.</div>|,
          ~s|</Bioma.Molecules.Sheet.sheet_content>|
        ]
      }
    ]
  end
end
