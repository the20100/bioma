defmodule Bioma.Molecules.Kanban do
  @moduledoc """
  A Kanban board with draggable cards.

  Provides a multi-column board layout with drag-and-drop card movement using
  the native HTML5 Drag and Drop API, powered by the `Kanban` JS hook.

  When a card is dropped into a new column the hook pushes a
  `"kanban_card_moved"` LiveView event with `%{"card_id" => id, "column_id" => id}`
  so the parent LiveView can persist the change.

  ## Examples

      <.kanban id="sprint-board">
        <.kanban_column id="backlog" title="Backlog" count={3}>
          <.kanban_card id="task-1" title="Design system audit" label="Design" />
          <.kanban_card id="task-2" title="Set up CI/CD" label="Infra" priority="medium" />
          <.kanban_card id="task-3" title="Write onboarding docs" label="Docs" />
        </.kanban_column>

        <.kanban_column id="in-progress" title="In Progress" count={1}>
          <.kanban_card
            id="task-4"
            title="Build chat component"
            description="Phoenix LiveView streaming"
            label="Feature"
            priority="high"
            assignee="VM"
          />
        </.kanban_column>

        <.kanban_column id="done" title="Done" count={1}>
          <.kanban_card id="task-5" title="Project scaffolding" label="Infra" />
        </.kanban_column>
      </.kanban>

  ## LiveView event handling

      def handle_event("kanban_card_moved", %{"card_id" => card_id, "column_id" => col_id}, socket) do
        # persist or update assigns
        {:noreply, socket}
      end
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # kanban/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique board ID – the JS hook attaches here."
  attr :class, :string, default: nil, doc: "Additional CSS classes."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "Kanban columns."

  @doc "Renders the Kanban board container."
  def kanban(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="Kanban"
      class={cn(["flex gap-4 overflow-x-auto pb-2", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # kanban_column/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Column ID – returned in `kanban_card_moved` events."
  attr :title, :string, required: true, doc: "Column heading text."

  attr :count, :integer,
    default: nil,
    doc: "Optional card count badge displayed next to the title."

  attr :class, :string, default: nil, doc: "Additional CSS classes."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: false, doc: "Kanban cards."

  slot :header_actions,
    required: false,
    doc: "Optional actions in the column header (e.g. an add button)."

  @doc "Renders a Kanban column."
  def kanban_column(assigns) do
    ~H"""
    <div class={cn(["flex flex-col w-72 shrink-0 rounded-lg bg-muted/40", @class])} {@rest}>
      <%!-- Header --%>
      <div class="flex items-center justify-between px-3 py-2.5">
        <div class="flex items-center gap-2">
          <span class="text-sm font-medium">{@title}</span>
          <span
            :if={@count != nil}
            class="flex h-5 min-w-[1.25rem] items-center justify-center rounded-full bg-muted px-1 text-xs text-muted-foreground font-medium"
          >
            {@count}
          </span>
        </div>
        <div :if={@header_actions != []}>
          {render_slot(@header_actions)}
        </div>
      </div>

      <%!-- Drop zone --%>
      <div
        id={"#{@id}-body"}
        data-kanban-column-body
        data-column-id={@id}
        class="flex flex-col gap-2 px-2 pb-2 min-h-[8rem] rounded-b-lg transition-colors duration-150"
      >
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # kanban_card/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Card ID – returned in `kanban_card_moved` events."
  attr :title, :string, required: true, doc: "Card title text."
  attr :description, :string, default: nil, doc: "Optional short description."

  attr :label, :string,
    default: nil,
    doc: "Optional category badge text (e.g. \"Feature\", \"Bug\")."

  attr :label_variant, :string,
    default: "secondary",
    values: ~w(default secondary destructive outline),
    doc: "Badge color variant."

  attr :priority, :string,
    default: nil,
    values: [nil, "low", "medium", "high"],
    doc: "Optional priority dot: low (green), medium (amber), high (red)."

  attr :assignee, :string,
    default: nil,
    doc: "Optional assignee initials shown as a small avatar chip."

  attr :class, :string, default: nil, doc: "Additional CSS classes."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: false, doc: "Optional additional card content."

  @doc "Renders a draggable Kanban card."
  def kanban_card(assigns) do
    ~H"""
    <div
      id={@id}
      data-kanban-card
      data-card-id={@id}
      class={cn([
        "group rounded-md border bg-card p-3 shadow-sm",
        "cursor-grab active:cursor-grabbing",
        "hover:shadow-md transition-all duration-150",
        @class
      ])}
      {@rest}
    >
      <%!-- Label + priority row --%>
      <div :if={@label || @priority} class="flex items-center justify-between mb-2">
        <span
          :if={@label}
          class={cn([
            "inline-flex items-center rounded-full px-2 py-0.5 text-xs font-medium",
            label_classes(@label_variant)
          ])}
        >
          {@label}
        </span>
        <span :if={!@label} />
        <span
          :if={@priority}
          title={String.capitalize(@priority || "") <> " priority"}
          class={cn(["h-2 w-2 rounded-full shrink-0", priority_color(@priority)])}
        />
      </div>

      <%!-- Title --%>
      <p class="text-sm font-medium leading-snug">{@title}</p>

      <%!-- Description --%>
      <p :if={@description} class="mt-1 text-xs text-muted-foreground line-clamp-2">
        {@description}
      </p>

      <%!-- Inner block --%>
      <div :if={@inner_block != []} class="mt-2">
        {render_slot(@inner_block)}
      </div>

      <%!-- Assignee avatar --%>
      <div :if={@assignee} class="mt-2.5 flex justify-end">
        <span class="inline-flex h-6 w-6 items-center justify-center rounded-full bg-muted text-xs font-medium text-muted-foreground">
          {@assignee}
        </span>
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp label_classes("default"), do: "bg-primary text-primary-foreground"
  defp label_classes("secondary"), do: "bg-secondary text-secondary-foreground"
  defp label_classes("destructive"), do: "bg-destructive/15 text-destructive"
  defp label_classes("outline"), do: "border border-border text-foreground"
  defp label_classes(_), do: "bg-secondary text-secondary-foreground"

  defp priority_color("low"), do: "bg-emerald-500"
  defp priority_color("medium"), do: "bg-amber-500"
  defp priority_color("high"), do: "bg-destructive"
  defp priority_color(_), do: "bg-muted-foreground"
end
