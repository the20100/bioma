defmodule Bioma.Molecules.Tree do
  @moduledoc """
  A tree / file-browser component for hierarchical navigation.

  Supports expand/collapse nodes with smooth animations, selected and disabled
  states, an icon slot, and arbitrary nesting depth. Indentation is handled
  automatically by CSS nesting (`ml-4` on the children container), so no
  explicit `level` attribute is needed.

  Uses `Phoenix.LiveView.JS` for client-side toggle — no server round-trip.

  ## Examples

      <.tree id="file-tree">
        <.tree_node id="src" label="src" expanded>
          <:icon>
            <svg class="h-4 w-4 text-amber-500" .../>
          </:icon>
          <.tree_node id="app" label="app.ex" selected>
            <:icon>
              <svg class="h-4 w-4 text-muted-foreground" .../>
            </:icon>
          </.tree_node>
          <.tree_node id="router" label="router.ex" />
        </.tree_node>
        <.tree_node id="test" label="test" />
      </.tree>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # tree/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique ID for the tree container."
  attr :class, :string, default: nil, doc: "Additional CSS classes."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "Tree node components."

  @doc "Renders the tree container."
  def tree(assigns) do
    ~H"""
    <div id={@id} role="tree" class={cn(["w-full select-none text-sm", @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # tree_node/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique node ID."
  attr :label, :string, required: true, doc: "Display label text."

  attr :selected, :boolean,
    default: false,
    doc: "Highlight this node as the currently active item."

  attr :expanded, :boolean,
    default: false,
    doc: "Start with children visible."

  attr :disabled, :boolean,
    default: false,
    doc: "Prevent interaction."

  attr :class, :string, default: nil, doc: "Additional CSS classes on the node wrapper."
  attr :rest, :global, doc: "Additional HTML attributes on the node wrapper."

  slot :icon, required: false, doc: "Optional icon rendered before the label."

  slot :inner_block,
    required: false,
    doc: "Child tree_node components. Their presence marks this node as a branch."

  @doc """
  Renders a single tree node.

  Nesting `tree_node` components inside each other is how branches are
  created. Indentation accumulates automatically via CSS (`ml-4` per level).
  """
  def tree_node(assigns) do
    has_children = assigns.inner_block != []
    assigns = assign(assigns, :has_children, has_children)

    ~H"""
    <div
      id={@id}
      role="treeitem"
      aria-expanded={@has_children && to_string(@expanded)}
      data-state={if @expanded, do: "open", else: "closed"}
      class={cn([@class])}
      {@rest}
    >
      <%!-- ── Row ────────────────────────────────────────────────────────── --%>
      <div
        phx-click={if @has_children and not @disabled, do: toggle_node(@id)}
        class={cn([
          "flex items-center gap-1.5 rounded-md py-1 pl-2 pr-2 cursor-pointer",
          "transition-colors duration-100 hover:bg-accent hover:text-accent-foreground",
          @selected && "bg-accent text-accent-foreground font-medium",
          @disabled && "opacity-50 cursor-not-allowed pointer-events-none"
        ])}
      >
        <%!-- Chevron --%>
        <span
          id={"#{@id}-chevron"}
          class={cn([
            "shrink-0 transition-transform duration-150",
            !@has_children && "invisible",
            @expanded && "rotate-90"
          ])}
        >
          <svg
            class="h-3.5 w-3.5 text-muted-foreground"
            viewBox="0 0 20 20"
            fill="currentColor"
            aria-hidden="true"
          >
            <path
              fill-rule="evenodd"
              d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
              clip-rule="evenodd"
            />
          </svg>
        </span>

        <%!-- Icon slot --%>
        <span :if={@icon != []} class="shrink-0 text-muted-foreground">
          {render_slot(@icon)}
        </span>

        <%!-- Label --%>
        <span class="flex-1 truncate">{@label}</span>
      </div>

      <%!-- ── Children ──────────────────────────────────────────────────── --%>
      <div
        :if={@has_children}
        id={"#{@id}-children"}
        class={cn(["ml-4", !@expanded && "hidden"])}
      >
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp toggle_node(id) do
    %JS{}
    |> JS.toggle(
      to: "##{id}-children",
      in: {"transition-all ease-out duration-150", "opacity-0", "opacity-100"},
      out: {"transition-all ease-in duration-100", "opacity-100", "opacity-0"}
    )
    |> JS.toggle_class("rotate-90", to: "##{id}-chevron")
    |> JS.toggle_attribute({"data-state", "open", "closed"}, to: "##{id}")
  end
end
