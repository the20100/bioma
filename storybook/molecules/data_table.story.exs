defmodule Storybook.Molecules.DataTable do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.DataTable.data_table/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Data table with sortable columns",
        attributes: %{
          id: "demo-data-table",
          rows: [
            %{name: "Alice Johnson", email: "alice@example.com", role: "Admin"},
            %{name: "Bob Smith", email: "bob@example.com", role: "User"},
            %{name: "Carol White", email: "carol@example.com", role: "Editor"}
          ],
          sort_by: "name",
          sort_order: "asc",
          page: 1,
          page_size: 10,
          total_count: 3
        },
        slots: [
          ~s|<:col :let={row} label="Name" field={:name} sortable>{row.name}</:col>|,
          ~s|<:col :let={row} label="Email" field={:email} sortable>{row.email}</:col>|,
          ~s|<:col :let={row} label="Role" field={:role}>{row.role}</:col>|
        ]
      },
      %Variation{
        id: :paginated,
        description: "Data table with pagination",
        attributes: %{
          id: "demo-data-table-paginated",
          rows: [
            %{name: "Alice", email: "alice@example.com", status: "Active"},
            %{name: "Bob", email: "bob@example.com", status: "Inactive"}
          ],
          page: 2,
          page_size: 2,
          total_count: 10
        },
        slots: [
          ~s|<:col :let={row} label="Name" field={:name} sortable>{row.name}</:col>|,
          ~s|<:col :let={row} label="Email" field={:email}>{row.email}</:col>|,
          ~s|<:col :let={row} label="Status" field={:status}>{row.status}</:col>|
        ]
      }
    ]
  end
end
