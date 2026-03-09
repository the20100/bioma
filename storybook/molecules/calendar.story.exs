defmodule Storybook.Molecules.Calendar do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Calendar.calendar/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default calendar",
        attributes: %{
          id: "demo-calendar",
          class: "rounded-md border w-fit"
        }
      }
    ]
  end
end
