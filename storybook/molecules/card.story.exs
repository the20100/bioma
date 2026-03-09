defmodule Storybook.Molecules.Card do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Card.card/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default card with all sections",
        slots: [
          ~s|<Bioma.Molecules.Card.card_header>|,
          ~s|  <Bioma.Molecules.Card.card_title>Card Title</Bioma.Molecules.Card.card_title>|,
          ~s|  <Bioma.Molecules.Card.card_description>Card description goes here.</Bioma.Molecules.Card.card_description>|,
          ~s|</Bioma.Molecules.Card.card_header>|,
          ~s|<Bioma.Molecules.Card.card_content>|,
          ~s|  <p>Card content area. Put any content here.</p>|,
          ~s|</Bioma.Molecules.Card.card_content>|,
          ~s|<Bioma.Molecules.Card.card_footer>|,
          ~s|  <button class="px-4 py-2 bg-primary text-primary-foreground rounded-md text-sm">Save</button>|,
          ~s|</Bioma.Molecules.Card.card_footer>|
        ]
      }
    ]
  end
end
