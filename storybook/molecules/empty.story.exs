defmodule Storybook.Molecules.Empty do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Empty.empty/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default empty state",
        slots: [
          ~s|<:icon>|,
          ~s|  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-12 w-12"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>|,
          ~s|</:icon>|,
          ~s|<:title>No results found</:title>|,
          ~s|<:description>Try adjusting your search or filter to find what you're looking for.</:description>|,
          ~s|<:action>|,
          ~s|  <button class="inline-flex items-center justify-center rounded-md text-sm font-medium border border-input bg-background hover:bg-accent hover:text-accent-foreground h-9 px-3">Clear filters</button>|,
          ~s|</:action>|
        ]
      }
    ]
  end
end
