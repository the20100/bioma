defmodule Bioma.Molecules.Table do
  @moduledoc """
  A table component.

  Provides a responsive, styled table with sub-components for header, body,
  footer, rows, and cells.

  ## Examples

      <.table>
        <.table_header>
          <.table_row>
            <.table_head>Name</.table_head>
            <.table_head>Email</.table_head>
          </.table_row>
        </.table_header>
        <.table_body>
          <.table_row>
            <.table_cell>Alice</.table_cell>
            <.table_cell>alice@example.com</.table_cell>
          </.table_row>
        </.table_body>
      </.table>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # table/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The table content (header, body, footer)."

  @doc "Renders a styled table wrapper."
  def table(assigns) do
    ~H"""
    <div class="relative w-full overflow-auto">
      <table class={cn(["w-full caption-bottom text-sm", @class])} {@rest}>
        {render_slot(@inner_block)}
      </table>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # table_header/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The header rows."

  @doc "Renders the table header section."
  def table_header(assigns) do
    ~H"""
    <thead class={cn(["[&_tr]:border-b", @class])} {@rest}>
      {render_slot(@inner_block)}
    </thead>
    """
  end

  # ---------------------------------------------------------------------------
  # table_body/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The body rows."

  @doc "Renders the table body section."
  def table_body(assigns) do
    ~H"""
    <tbody class={cn(["[&_tr:last-child]:border-0", @class])} {@rest}>
      {render_slot(@inner_block)}
    </tbody>
    """
  end

  # ---------------------------------------------------------------------------
  # table_footer/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The footer rows."

  @doc "Renders the table footer section."
  def table_footer(assigns) do
    ~H"""
    <tfoot class={cn(["border-t bg-muted/50 font-medium [&>tr]:last:border-b-0", @class])} {@rest}>
      {render_slot(@inner_block)}
    </tfoot>
    """
  end

  # ---------------------------------------------------------------------------
  # table_row/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The row cells."

  @doc "Renders a table row."
  def table_row(assigns) do
    ~H"""
    <tr
      class={
        cn([
          "border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </tr>
    """
  end

  # ---------------------------------------------------------------------------
  # table_head/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The header cell content."

  @doc "Renders a table header cell."
  def table_head(assigns) do
    ~H"""
    <th
      class={
        cn([
          "h-12 px-4 text-left align-middle font-medium text-muted-foreground",
          "[&:has([role=checkbox])]:pr-0",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </th>
    """
  end

  # ---------------------------------------------------------------------------
  # table_cell/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The cell content."

  @doc "Renders a table data cell."
  def table_cell(assigns) do
    ~H"""
    <td
      class={cn(["p-4 align-middle [&:has([role=checkbox])]:pr-0", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </td>
    """
  end

  # ---------------------------------------------------------------------------
  # table_caption/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The caption text."

  @doc "Renders a table caption."
  def table_caption(assigns) do
    ~H"""
    <caption class={cn(["mt-4 text-sm text-muted-foreground", @class])} {@rest}>
      {render_slot(@inner_block)}
    </caption>
    """
  end
end
