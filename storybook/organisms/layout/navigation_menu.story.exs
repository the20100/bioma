defmodule Storybook.Organisms.Layout.NavigationMenu do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.Layout.NavigationMenu.navigation_menu/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default navigation menu",
        slots: [
          ~s|<Bioma.Organisms.Layout.NavigationMenu.navigation_menu_list>|,
          ~s|  <Bioma.Organisms.Layout.NavigationMenu.navigation_menu_item id="nav-getting-started">|,
          ~s|    <Bioma.Organisms.Layout.NavigationMenu.navigation_menu_trigger target="nav-getting-started">Getting Started</Bioma.Organisms.Layout.NavigationMenu.navigation_menu_trigger>|,
          ~s|    <Bioma.Organisms.Layout.NavigationMenu.navigation_menu_content target="nav-getting-started">|,
          ~s|      <div class="grid gap-3 w-[400px] grid-cols-2">|,
          ~s|        <Bioma.Organisms.Layout.NavigationMenu.navigation_menu_link>|,
          ~s|          <div class="text-sm font-medium">Introduction</div>|,
          ~s|          <p class="text-sm text-muted-foreground">Get started with the basics.</p>|,
          ~s|        </Bioma.Organisms.Layout.NavigationMenu.navigation_menu_link>|,
          ~s|        <Bioma.Organisms.Layout.NavigationMenu.navigation_menu_link>|,
          ~s|          <div class="text-sm font-medium">Installation</div>|,
          ~s|          <p class="text-sm text-muted-foreground">How to install and configure.</p>|,
          ~s|        </Bioma.Organisms.Layout.NavigationMenu.navigation_menu_link>|,
          ~s|      </div>|,
          ~s|    </Bioma.Organisms.Layout.NavigationMenu.navigation_menu_content>|,
          ~s|  </Bioma.Organisms.Layout.NavigationMenu.navigation_menu_item>|,
          ~s|</Bioma.Organisms.Layout.NavigationMenu.navigation_menu_list>|
        ]
      }
    ]
  end
end
