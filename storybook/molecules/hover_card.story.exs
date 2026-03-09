defmodule Storybook.Molecules.HoverCard do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.HoverCard.hover_card/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default hover card",
        attributes: %{id: "demo-hover-card"},
        slots: [
          ~s|<:trigger>|,
          ~s|  <span class="underline cursor-pointer text-sm font-medium">@alice</span>|,
          ~s|</:trigger>|,
          ~s|<:content>|,
          ~s|  <div class="space-y-2">|,
          ~s|    <h4 class="text-sm font-semibold">Alice Johnson</h4>|,
          ~s|    <p class="text-sm text-muted-foreground">Software Engineer at Acme Corp.</p>|,
          ~s|    <p class="text-xs text-muted-foreground">Joined December 2021</p>|,
          ~s|  </div>|,
          ~s|</:content>|
        ]
      }
    ]
  end
end
