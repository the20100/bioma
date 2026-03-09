defmodule Storybook.Molecules.Pagination do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Pagination.pagination/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default pagination",
        slots: [
          ~s|<Bioma.Molecules.Pagination.pagination_content>|,
          ~s|  <Bioma.Molecules.Pagination.pagination_item>|,
          ~s|    <Bioma.Molecules.Pagination.pagination_previous disabled={true} />|,
          ~s|  </Bioma.Molecules.Pagination.pagination_item>|,
          ~s|  <Bioma.Molecules.Pagination.pagination_item>|,
          ~s|    <Bioma.Molecules.Pagination.pagination_link active={true}>1</Bioma.Molecules.Pagination.pagination_link>|,
          ~s|  </Bioma.Molecules.Pagination.pagination_item>|,
          ~s|  <Bioma.Molecules.Pagination.pagination_item>|,
          ~s|    <Bioma.Molecules.Pagination.pagination_link>2</Bioma.Molecules.Pagination.pagination_link>|,
          ~s|  </Bioma.Molecules.Pagination.pagination_item>|,
          ~s|  <Bioma.Molecules.Pagination.pagination_item>|,
          ~s|    <Bioma.Molecules.Pagination.pagination_link>3</Bioma.Molecules.Pagination.pagination_link>|,
          ~s|  </Bioma.Molecules.Pagination.pagination_item>|,
          ~s|  <Bioma.Molecules.Pagination.pagination_item>|,
          ~s|    <Bioma.Molecules.Pagination.pagination_ellipsis />|,
          ~s|  </Bioma.Molecules.Pagination.pagination_item>|,
          ~s|  <Bioma.Molecules.Pagination.pagination_item>|,
          ~s|    <Bioma.Molecules.Pagination.pagination_next />|,
          ~s|  </Bioma.Molecules.Pagination.pagination_item>|,
          ~s|</Bioma.Molecules.Pagination.pagination_content>|
        ]
      }
    ]
  end
end
