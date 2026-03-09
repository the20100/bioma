defmodule Storybook.Molecules.ScrollArea do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.ScrollArea.scroll_area/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Vertical scroll area",
        attributes: %{class: "h-[200px] w-[350px] rounded-md border p-4"},
        slots: [
          "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.</p>"
        ]
      }
    ]
  end
end
