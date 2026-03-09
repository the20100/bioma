defmodule Storybook.Atoms.Tooltip do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Tooltip.tooltip/1

  def variations do
    [
      %Variation{
        id: :top,
        description: "Tooltip on top",
        attributes: %{text: "This is a tooltip", position: "top"},
        slots: ["<button class=\"px-4 py-2 border rounded-md\">Hover me</button>"]
      },
      %Variation{
        id: :bottom,
        description: "Tooltip on bottom",
        attributes: %{text: "Bottom tooltip", position: "bottom"},
        slots: ["<button class=\"px-4 py-2 border rounded-md\">Hover me</button>"]
      }
    ]
  end
end
