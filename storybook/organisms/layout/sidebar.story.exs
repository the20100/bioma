defmodule Storybook.Organisms.Layout.Sidebar do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.Layout.Sidebar.sidebar/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default sidebar with navigation",
        attributes: %{id: "demo-sidebar"},
        slots: [
          ~s|<Bioma.Organisms.Layout.Sidebar.sidebar_header>|,
          ~s|  <h2 class="text-lg font-semibold">App Name</h2>|,
          ~s|</Bioma.Organisms.Layout.Sidebar.sidebar_header>|,
          ~s|<Bioma.Organisms.Layout.Sidebar.sidebar_content>|,
          ~s|  <Bioma.Organisms.Layout.Sidebar.sidebar_group>|,
          ~s|    <Bioma.Organisms.Layout.Sidebar.sidebar_group_label>Navigation</Bioma.Organisms.Layout.Sidebar.sidebar_group_label>|,
          ~s|    <Bioma.Organisms.Layout.Sidebar.sidebar_menu>|,
          ~s|      <Bioma.Organisms.Layout.Sidebar.sidebar_menu_item>|,
          ~s|        <Bioma.Organisms.Layout.Sidebar.sidebar_menu_button active={true}>Dashboard</Bioma.Organisms.Layout.Sidebar.sidebar_menu_button>|,
          ~s|      </Bioma.Organisms.Layout.Sidebar.sidebar_menu_item>|,
          ~s|      <Bioma.Organisms.Layout.Sidebar.sidebar_menu_item>|,
          ~s|        <Bioma.Organisms.Layout.Sidebar.sidebar_menu_button>Settings</Bioma.Organisms.Layout.Sidebar.sidebar_menu_button>|,
          ~s|      </Bioma.Organisms.Layout.Sidebar.sidebar_menu_item>|,
          ~s|    </Bioma.Organisms.Layout.Sidebar.sidebar_menu>|,
          ~s|  </Bioma.Organisms.Layout.Sidebar.sidebar_group>|,
          ~s|</Bioma.Organisms.Layout.Sidebar.sidebar_content>|,
          ~s|<Bioma.Organisms.Layout.Sidebar.sidebar_footer>|,
          ~s|  <p class="text-xs text-muted-foreground">v1.0.0</p>|,
          ~s|</Bioma.Organisms.Layout.Sidebar.sidebar_footer>|
        ]
      },
      %Variation{
        id: :collapsed,
        description: "Collapsed sidebar",
        attributes: %{id: "demo-sidebar-collapsed", collapsed: true},
        slots: [
          ~s|<Bioma.Organisms.Layout.Sidebar.sidebar_header>|,
          ~s|  <h2 class="text-lg font-semibold">App</h2>|,
          ~s|</Bioma.Organisms.Layout.Sidebar.sidebar_header>|,
          ~s|<Bioma.Organisms.Layout.Sidebar.sidebar_content>|,
          ~s|  <Bioma.Organisms.Layout.Sidebar.sidebar_group>|,
          ~s|    <Bioma.Organisms.Layout.Sidebar.sidebar_menu>|,
          ~s|      <Bioma.Organisms.Layout.Sidebar.sidebar_menu_item>|,
          ~s|        <Bioma.Organisms.Layout.Sidebar.sidebar_menu_button active={true}>D</Bioma.Organisms.Layout.Sidebar.sidebar_menu_button>|,
          ~s|      </Bioma.Organisms.Layout.Sidebar.sidebar_menu_item>|,
          ~s|    </Bioma.Organisms.Layout.Sidebar.sidebar_menu>|,
          ~s|  </Bioma.Organisms.Layout.Sidebar.sidebar_group>|,
          ~s|</Bioma.Organisms.Layout.Sidebar.sidebar_content>|
        ]
      }
    ]
  end
end
