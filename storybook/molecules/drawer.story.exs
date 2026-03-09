defmodule Storybook.Molecules.Drawer do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Drawer.drawer/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Bottom drawer",
        attributes: %{id: "demo-drawer"},
        slots: [
          ~s|<Bioma.Molecules.Drawer.drawer_trigger target="demo-drawer">|,
          ~s|  <button class="inline-flex items-center justify-center rounded-md text-sm font-medium border border-input bg-background hover:bg-accent hover:text-accent-foreground h-10 px-4 py-2">Open Drawer</button>|,
          ~s|</Bioma.Molecules.Drawer.drawer_trigger>|,
          ~s|<Bioma.Molecules.Drawer.drawer_content target="demo-drawer" direction="bottom">|,
          ~s|  <Bioma.Molecules.Drawer.drawer_header>|,
          ~s|    <Bioma.Molecules.Drawer.drawer_title>Move Goal</Bioma.Molecules.Drawer.drawer_title>|,
          ~s|    <Bioma.Molecules.Drawer.drawer_description>Set your daily activity goal.</Bioma.Molecules.Drawer.drawer_description>|,
          ~s|  </Bioma.Molecules.Drawer.drawer_header>|,
          ~s|  <div class="p-4 text-center text-4xl font-bold">350</div>|,
          ~s|  <Bioma.Molecules.Drawer.drawer_footer>|,
          ~s|    <Bioma.Molecules.Drawer.drawer_close target="demo-drawer">|,
          ~s|      <button class="inline-flex items-center justify-center rounded-md text-sm font-medium border border-input bg-background hover:bg-accent hover:text-accent-foreground h-10 w-full px-4 py-2">Close</button>|,
          ~s|    </Bioma.Molecules.Drawer.drawer_close>|,
          ~s|  </Bioma.Molecules.Drawer.drawer_footer>|,
          ~s|</Bioma.Molecules.Drawer.drawer_content>|
        ]
      }
    ]
  end
end
