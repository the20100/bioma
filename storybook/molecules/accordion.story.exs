defmodule Storybook.Molecules.Accordion do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Accordion.accordion/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Single mode accordion",
        attributes: %{id: "demo-accordion", type: "single"},
        slots: [
          ~s|<Bioma.Molecules.Accordion.accordion_item id="demo-accordion" value="item-1">|,
          ~s|  <Bioma.Molecules.Accordion.accordion_trigger target="demo-accordion" value="item-1" type="single">What is this?</Bioma.Molecules.Accordion.accordion_trigger>|,
          ~s|  <Bioma.Molecules.Accordion.accordion_content target="demo-accordion" value="item-1">A reusable accordion component built with Phoenix LiveView.</Bioma.Molecules.Accordion.accordion_content>|,
          ~s|</Bioma.Molecules.Accordion.accordion_item>|,
          ~s|<Bioma.Molecules.Accordion.accordion_item id="demo-accordion" value="item-2">|,
          ~s|  <Bioma.Molecules.Accordion.accordion_trigger target="demo-accordion" value="item-2" type="single">How does it work?</Bioma.Molecules.Accordion.accordion_trigger>|,
          ~s|  <Bioma.Molecules.Accordion.accordion_content target="demo-accordion" value="item-2">It uses Phoenix.LiveView.JS for client-side interactions.</Bioma.Molecules.Accordion.accordion_content>|,
          ~s|</Bioma.Molecules.Accordion.accordion_item>|,
          ~s|<Bioma.Molecules.Accordion.accordion_item id="demo-accordion" value="item-3">|,
          ~s|  <Bioma.Molecules.Accordion.accordion_trigger target="demo-accordion" value="item-3" type="single">Can I style it?</Bioma.Molecules.Accordion.accordion_trigger>|,
          ~s|  <Bioma.Molecules.Accordion.accordion_content target="demo-accordion" value="item-3">Yes, use the class attribute to add custom styles.</Bioma.Molecules.Accordion.accordion_content>|,
          ~s|</Bioma.Molecules.Accordion.accordion_item>|
        ]
      }
    ]
  end
end
