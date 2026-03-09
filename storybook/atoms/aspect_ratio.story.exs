defmodule Storybook.Atoms.AspectRatio do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.AspectRatio.aspect_ratio/1

  def variations do
    [
      %Variation{
        id: :landscape,
        description: "16:9 landscape",
        attributes: %{ratio: 16 / 9},
        slots: [
          ~s|<div class="flex items-center justify-center bg-muted rounded-md w-full h-full text-sm text-muted-foreground">16:9</div>|
        ]
      },
      %Variation{
        id: :square,
        description: "1:1 square",
        attributes: %{ratio: 1.0, class: "max-w-[200px]"},
        slots: [
          ~s|<div class="flex items-center justify-center bg-muted rounded-md w-full h-full text-sm text-muted-foreground">1:1</div>|
        ]
      },
      %Variation{
        id: :portrait,
        description: "9:16 portrait",
        attributes: %{ratio: 9 / 16, class: "max-w-[150px]"},
        slots: [
          ~s|<div class="flex items-center justify-center bg-muted rounded-md w-full h-full text-sm text-muted-foreground">9:16</div>|
        ]
      }
    ]
  end
end
