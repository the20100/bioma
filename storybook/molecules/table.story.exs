defmodule Storybook.Molecules.Table do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Table.table/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default table",
        slots: [
          ~s|<Bioma.Molecules.Table.table_header>|,
          ~s|  <Bioma.Molecules.Table.table_row>|,
          ~s|    <Bioma.Molecules.Table.table_head>Name</Bioma.Molecules.Table.table_head>|,
          ~s|    <Bioma.Molecules.Table.table_head>Email</Bioma.Molecules.Table.table_head>|,
          ~s|    <Bioma.Molecules.Table.table_head>Role</Bioma.Molecules.Table.table_head>|,
          ~s|  </Bioma.Molecules.Table.table_row>|,
          ~s|</Bioma.Molecules.Table.table_header>|,
          ~s|<Bioma.Molecules.Table.table_body>|,
          ~s|  <Bioma.Molecules.Table.table_row>|,
          ~s|    <Bioma.Molecules.Table.table_cell class="font-medium">Alice</Bioma.Molecules.Table.table_cell>|,
          ~s|    <Bioma.Molecules.Table.table_cell>alice@example.com</Bioma.Molecules.Table.table_cell>|,
          ~s|    <Bioma.Molecules.Table.table_cell>Admin</Bioma.Molecules.Table.table_cell>|,
          ~s|  </Bioma.Molecules.Table.table_row>|,
          ~s|  <Bioma.Molecules.Table.table_row>|,
          ~s|    <Bioma.Molecules.Table.table_cell class="font-medium">Bob</Bioma.Molecules.Table.table_cell>|,
          ~s|    <Bioma.Molecules.Table.table_cell>bob@example.com</Bioma.Molecules.Table.table_cell>|,
          ~s|    <Bioma.Molecules.Table.table_cell>User</Bioma.Molecules.Table.table_cell>|,
          ~s|  </Bioma.Molecules.Table.table_row>|,
          ~s|</Bioma.Molecules.Table.table_body>|
        ]
      },
      %Variation{
        id: :with_footer,
        description: "Table with footer and caption",
        slots: [
          ~s|<Bioma.Molecules.Table.table_caption>A list of recent invoices.</Bioma.Molecules.Table.table_caption>|,
          ~s|<Bioma.Molecules.Table.table_header>|,
          ~s|  <Bioma.Molecules.Table.table_row>|,
          ~s|    <Bioma.Molecules.Table.table_head>Invoice</Bioma.Molecules.Table.table_head>|,
          ~s|    <Bioma.Molecules.Table.table_head>Status</Bioma.Molecules.Table.table_head>|,
          ~s|    <Bioma.Molecules.Table.table_head class="text-right">Amount</Bioma.Molecules.Table.table_head>|,
          ~s|  </Bioma.Molecules.Table.table_row>|,
          ~s|</Bioma.Molecules.Table.table_header>|,
          ~s|<Bioma.Molecules.Table.table_body>|,
          ~s|  <Bioma.Molecules.Table.table_row>|,
          ~s|    <Bioma.Molecules.Table.table_cell class="font-medium">INV001</Bioma.Molecules.Table.table_cell>|,
          ~s|    <Bioma.Molecules.Table.table_cell>Paid</Bioma.Molecules.Table.table_cell>|,
          ~s|    <Bioma.Molecules.Table.table_cell class="text-right">$250.00</Bioma.Molecules.Table.table_cell>|,
          ~s|  </Bioma.Molecules.Table.table_row>|,
          ~s|  <Bioma.Molecules.Table.table_row>|,
          ~s|    <Bioma.Molecules.Table.table_cell class="font-medium">INV002</Bioma.Molecules.Table.table_cell>|,
          ~s|    <Bioma.Molecules.Table.table_cell>Pending</Bioma.Molecules.Table.table_cell>|,
          ~s|    <Bioma.Molecules.Table.table_cell class="text-right">$150.00</Bioma.Molecules.Table.table_cell>|,
          ~s|  </Bioma.Molecules.Table.table_row>|,
          ~s|</Bioma.Molecules.Table.table_body>|,
          ~s|<Bioma.Molecules.Table.table_footer>|,
          ~s|  <Bioma.Molecules.Table.table_row>|,
          ~s|    <Bioma.Molecules.Table.table_cell colspan="2" class="font-medium">Total</Bioma.Molecules.Table.table_cell>|,
          ~s|    <Bioma.Molecules.Table.table_cell class="text-right font-medium">$400.00</Bioma.Molecules.Table.table_cell>|,
          ~s|  </Bioma.Molecules.Table.table_row>|,
          ~s|</Bioma.Molecules.Table.table_footer>|
        ]
      }
    ]
  end
end
