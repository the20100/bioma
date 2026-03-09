defmodule Storybook.Molecules.DatePicker do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.DatePicker.date_picker/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default date picker",
        attributes: %{
          id: "demo-date-picker",
          name: "due_date",
          placeholder: "Pick a date",
          class: "w-[280px]"
        }
      }
    ]
  end
end
