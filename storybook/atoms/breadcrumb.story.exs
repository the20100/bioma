defmodule Storybook.Atoms.Breadcrumb do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Breadcrumb.breadcrumb/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default breadcrumb",
        slots: [
          ~s|<Bioma.Atoms.Breadcrumb.breadcrumb_list>|,
          ~s|  <Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|    <Bioma.Atoms.Breadcrumb.breadcrumb_link>Home</Bioma.Atoms.Breadcrumb.breadcrumb_link>|,
          ~s|  </Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|  <Bioma.Atoms.Breadcrumb.breadcrumb_separator />|,
          ~s|  <Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|    <Bioma.Atoms.Breadcrumb.breadcrumb_link>Settings</Bioma.Atoms.Breadcrumb.breadcrumb_link>|,
          ~s|  </Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|  <Bioma.Atoms.Breadcrumb.breadcrumb_separator />|,
          ~s|  <Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|    <Bioma.Atoms.Breadcrumb.breadcrumb_page>Profile</Bioma.Atoms.Breadcrumb.breadcrumb_page>|,
          ~s|  </Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|</Bioma.Atoms.Breadcrumb.breadcrumb_list>|
        ]
      },
      %Variation{
        id: :with_ellipsis,
        description: "With ellipsis",
        slots: [
          ~s|<Bioma.Atoms.Breadcrumb.breadcrumb_list>|,
          ~s|  <Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|    <Bioma.Atoms.Breadcrumb.breadcrumb_link>Home</Bioma.Atoms.Breadcrumb.breadcrumb_link>|,
          ~s|  </Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|  <Bioma.Atoms.Breadcrumb.breadcrumb_separator />|,
          ~s|  <Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|    <Bioma.Atoms.Breadcrumb.breadcrumb_ellipsis />|,
          ~s|  </Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|  <Bioma.Atoms.Breadcrumb.breadcrumb_separator />|,
          ~s|  <Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|    <Bioma.Atoms.Breadcrumb.breadcrumb_page>Current Page</Bioma.Atoms.Breadcrumb.breadcrumb_page>|,
          ~s|  </Bioma.Atoms.Breadcrumb.breadcrumb_item>|,
          ~s|</Bioma.Atoms.Breadcrumb.breadcrumb_list>|
        ]
      }
    ]
  end
end
