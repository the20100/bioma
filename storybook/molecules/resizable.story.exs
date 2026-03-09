defmodule Storybook.Molecules.Resizable do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Resizable.resizable_panel_group/1

  def variations do
    [
      %Variation{
        id: :horizontal,
        description: "Horizontal resizable panels",
        attributes: %{id: "demo-resizable-h", direction: "horizontal"},
        slots: [
          ~s|<Bioma.Molecules.Resizable.resizable_panel default_size={70} class="p-4">|,
          ~s|  <div class="flex h-[200px] items-center justify-center"><span class="font-semibold">Panel 1</span></div>|,
          ~s|</Bioma.Molecules.Resizable.resizable_panel>|,
          ~s|<Bioma.Molecules.Resizable.resizable_handle target="demo-resizable-h" with_handle={true} />|,
          ~s|<Bioma.Molecules.Resizable.resizable_panel default_size={30} class="p-4">|,
          ~s|  <div class="flex h-[200px] items-center justify-center"><span class="font-semibold">Panel 2</span></div>|,
          ~s|</Bioma.Molecules.Resizable.resizable_panel>|
        ]
      },
      %Variation{
        id: :vertical,
        description: "Vertical resizable panels",
        attributes: %{id: "demo-resizable-v", direction: "vertical"},
        slots: [
          ~s|<Bioma.Molecules.Resizable.resizable_panel default_size={60} class="p-4">|,
          ~s|  <div class="flex h-[100px] items-center justify-center"><span class="font-semibold">Top Panel</span></div>|,
          ~s|</Bioma.Molecules.Resizable.resizable_panel>|,
          ~s|<Bioma.Molecules.Resizable.resizable_handle target="demo-resizable-v" />|,
          ~s|<Bioma.Molecules.Resizable.resizable_panel default_size={40} class="p-4">|,
          ~s|  <div class="flex h-[100px] items-center justify-center"><span class="font-semibold">Bottom Panel</span></div>|,
          ~s|</Bioma.Molecules.Resizable.resizable_panel>|
        ]
      }
    ]
  end
end
