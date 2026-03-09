defmodule Bioma.Molecules.DataTable do
  @moduledoc """
  A data table component.

  Builds on the Table component with slot-based columns, sortable headers,
  and integrated pagination. Sorting, filtering, and pagination logic are
  handled server-side.

  ## Examples

      <.data_table
        id="users-table"
        rows={@users}
        sort_by={@sort_by}
        sort_order={@sort_order}
        page={@page}
        page_size={@page_size}
        total_count={@total_count}
      >
        <:col :let={user} label="Name" field={:name} sortable>
          {user.name}
        </:col>
        <:col :let={user} label="Email" field={:email} sortable>
          {user.email}
        </:col>
        <:col :let={user} label="Role" field={:role}>
          {user.role}
        </:col>
      </.data_table>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :id, :string, required: true, doc: "Unique identifier for the data table."
  attr :rows, :list, required: true, doc: "The list of data rows to display."
  attr :sort_by, :string, default: nil, doc: "The currently sorted column field."
  attr :sort_order, :string, default: "asc", values: ~w(asc desc), doc: "The sort direction."
  attr :page, :integer, default: 1, doc: "The current page number."
  attr :page_size, :integer, default: 10, doc: "Number of rows per page."
  attr :total_count, :integer, default: 0, doc: "Total number of rows across all pages."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, include: ~w(phx-target), doc: "Additional HTML attributes."

  slot :col, required: true, doc: "Column definitions." do
    attr :label, :string, doc: "The column header label."
    attr :field, :atom, doc: "The field key for sorting."
    attr :sortable, :boolean, doc: "Whether this column is sortable."
    attr :class, :string, doc: "Additional classes for the column."
  end

  @doc "Renders a data table with sortable columns and pagination."
  def data_table(assigns) do
    total_pages = max(1, ceil(assigns.total_count / max(1, assigns.page_size)))
    assigns = assign(assigns, :total_pages, total_pages)

    ~H"""
    <div id={@id} class={cn([@class])}>
      <%!-- Table --%>
      <div class="relative w-full overflow-auto rounded-md border">
        <table class="w-full caption-bottom text-sm">
          <thead class="[&_tr]:border-b">
            <tr class="border-b transition-colors hover:bg-muted/50">
              <th
                :for={col <- @col}
                class={
                  cn([
                    "h-12 px-4 text-left align-middle font-medium text-muted-foreground",
                    col[:class]
                  ])
                }
              >
                <%= if col[:sortable] do %>
                  <button
                    type="button"
                    phx-click="data_table_sort"
                    phx-value-field={col[:field]}
                    phx-target={assigns[:rest][:"phx-target"]}
                    class="inline-flex items-center gap-1 hover:text-foreground transition-colors"
                  >
                    {col.label}
                    <svg
                      :if={to_string(col[:field]) == @sort_by}
                      xmlns="http://www.w3.org/2000/svg"
                      width="24"
                      height="24"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class={cn(["h-4 w-4", @sort_order == "desc" && "rotate-180"])}
                    >
                      <path d="m6 9 6 6 6-6" />
                    </svg>
                  </button>
                <% else %>
                  {col.label}
                <% end %>
              </th>
            </tr>
          </thead>
          <tbody class="[&_tr:last-child]:border-0">
            <tr
              :for={row <- @rows}
              class="border-b transition-colors hover:bg-muted/50"
            >
              <td
                :for={col <- @col}
                class={cn(["p-4 align-middle", col[:class]])}
              >
                {render_slot(col, row)}
              </td>
            </tr>
            <tr :if={@rows == []}>
              <td colspan={length(@col)} class="p-4 text-center text-sm text-muted-foreground">
                No results.
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <%!-- Pagination --%>
      <div :if={@total_pages > 1} class="flex items-center justify-between px-2 py-4">
        <div class="text-sm text-muted-foreground">
          Page {@page} of {@total_pages}
        </div>
        <div class="flex items-center space-x-2">
          <button
            type="button"
            phx-click="data_table_page"
            phx-value-page={@page - 1}
            phx-target={assigns[:rest][:"phx-target"]}
            disabled={@page <= 1}
            class="inline-flex items-center justify-center rounded-md text-sm font-medium border border-input bg-background hover:bg-accent hover:text-accent-foreground h-8 px-3 disabled:pointer-events-none disabled:opacity-50"
          >
            Previous
          </button>
          <button
            type="button"
            phx-click="data_table_page"
            phx-value-page={@page + 1}
            phx-target={assigns[:rest][:"phx-target"]}
            disabled={@page >= @total_pages}
            class="inline-flex items-center justify-center rounded-md text-sm font-medium border border-input bg-background hover:bg-accent hover:text-accent-foreground h-8 px-3 disabled:pointer-events-none disabled:opacity-50"
          >
            Next
          </button>
        </div>
      </div>
    </div>
    """
  end
end
