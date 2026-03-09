defmodule Storybook.Atoms.Slider do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Slider.slider/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default slider",
        attributes: %{value: 50, name: "volume", class: "max-w-sm"}
      },
      %Variation{
        id: :with_step,
        description: "Slider with step",
        attributes: %{value: 25, min: 0, max: 100, step: 25, name: "brightness", class: "max-w-sm"}
      },
      %Variation{
        id: :disabled,
        description: "Disabled slider",
        attributes: %{value: 30, disabled: true, class: "max-w-sm"}
      }
    ]
  end
end
