defmodule Storybook.Molecules.Carousel do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Carousel.carousel/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default carousel",
        attributes: %{id: "demo-carousel", class: "w-full max-w-xs mx-auto"},
        slots: [
          ~s|<Bioma.Molecules.Carousel.carousel_content target="demo-carousel">|,
          ~s|  <Bioma.Molecules.Carousel.carousel_item>|,
          ~s|    <div class="flex aspect-square items-center justify-center rounded-md border bg-muted p-6"><span class="text-4xl font-semibold">1</span></div>|,
          ~s|  </Bioma.Molecules.Carousel.carousel_item>|,
          ~s|  <Bioma.Molecules.Carousel.carousel_item>|,
          ~s|    <div class="flex aspect-square items-center justify-center rounded-md border bg-muted p-6"><span class="text-4xl font-semibold">2</span></div>|,
          ~s|  </Bioma.Molecules.Carousel.carousel_item>|,
          ~s|  <Bioma.Molecules.Carousel.carousel_item>|,
          ~s|    <div class="flex aspect-square items-center justify-center rounded-md border bg-muted p-6"><span class="text-4xl font-semibold">3</span></div>|,
          ~s|  </Bioma.Molecules.Carousel.carousel_item>|,
          ~s|</Bioma.Molecules.Carousel.carousel_content>|,
          ~s|<Bioma.Molecules.Carousel.carousel_previous target="demo-carousel" />|,
          ~s|<Bioma.Molecules.Carousel.carousel_next target="demo-carousel" />|,
          ~s|<Bioma.Molecules.Carousel.carousel_indicators target="demo-carousel" count={3} />|
        ]
      }
    ]
  end
end
