defmodule Bioma.Molecules.Tabs do
  @moduledoc """
  A tabs component following shadcn/ui design patterns.

  Provides a tabbed interface using `Phoenix.LiveView.JS` for client-side
  show/hide behavior without requiring server round-trips. Each tab trigger
  toggles visibility of its corresponding content panel.

  ## Examples

      <.tabs id="my-tabs" default="account">
        <.tabs_list>
          <.tabs_trigger target="my-tabs" value="account">Account</.tabs_trigger>
          <.tabs_trigger target="my-tabs" value="password">Password</.tabs_trigger>
        </.tabs_list>
        <.tabs_content target="my-tabs" value="account">
          <p>Account settings here.</p>
        </.tabs_content>
        <.tabs_content target="my-tabs" value="password">
          <p>Password settings here.</p>
        </.tabs_content>
      </.tabs>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # tabs/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the tabs group."
  attr :default, :string, default: nil, doc: "The value of the default active tab."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The tabs list and content panels."

  @doc """
  Renders a tabs container that groups tab triggers and content panels.
  """
  def tabs(assigns) do
    ~H"""
    <div
      id={@id}
      data-tabs-default={@default}
      class={cn([@class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # tabs_list/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The tab trigger buttons."

  @doc """
  Renders the tab list container that holds tab triggers.
  """
  def tabs_list(assigns) do
    ~H"""
    <div
      role="tablist"
      class={
        cn([
          "inline-flex h-10 items-center justify-center rounded-md bg-muted p-1 text-muted-foreground",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # tabs_trigger/1
  # ---------------------------------------------------------------------------

  attr :value, :string, required: true, doc: "The value identifying this tab."
  attr :target, :string, required: true, doc: "The id of the parent tabs container."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :disabled, :boolean, default: false, doc: "Whether the trigger is disabled."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The trigger label."

  @doc """
  Renders a tab trigger button that activates its corresponding content panel.

  Uses `Phoenix.LiveView.JS` to show/hide content panels and update the active
  state styling on the trigger buttons.
  """
  def tabs_trigger(assigns) do
    ~H"""
    <button
      id={"#{@target}-trigger-#{@value}"}
      type="button"
      role="tab"
      aria-selected="false"
      aria-controls={"#{@target}-content-#{@value}"}
      data-state="inactive"
      data-tab-value={@value}
      disabled={@disabled}
      phx-click={switch_tab(@target, @value)}
      class={
        cn([
          "inline-flex items-center justify-center whitespace-nowrap rounded-sm px-3 py-1.5 text-sm font-medium ring-offset-background transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 data-[state=active]:bg-background data-[state=active]:text-foreground data-[state=active]:shadow-sm",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </button>
    """
  end

  # ---------------------------------------------------------------------------
  # tabs_content/1
  # ---------------------------------------------------------------------------

  attr :value, :string, required: true, doc: "The value identifying this content panel."
  attr :target, :string, required: true, doc: "The id of the parent tabs container."
  attr :default, :string, default: nil, doc: "The default active tab value (to determine initial visibility)."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The tab panel content."

  @doc """
  Renders a tab content panel. Hidden by default unless its value matches the default tab.
  """
  def tabs_content(assigns) do
    ~H"""
    <div
      id={"#{@target}-content-#{@value}"}
      role="tabpanel"
      aria-labelledby={"#{@target}-trigger-#{@value}"}
      data-tab-value={@value}
      class={
        cn([
          @value != @default && "hidden",
          "mt-2 ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp switch_tab(target, value) do
    %JS{}
    |> JS.hide(to: "[id^='#{target}-content-']")
    |> JS.show(to: "##{target}-content-#{value}")
    |> JS.set_attribute({"data-state", "inactive"}, to: "[id^='#{target}-trigger-']")
    |> JS.set_attribute({"aria-selected", "false"}, to: "[id^='#{target}-trigger-']")
    |> JS.set_attribute({"data-state", "active"}, to: "##{target}-trigger-#{value}")
    |> JS.set_attribute({"aria-selected", "true"}, to: "##{target}-trigger-#{value}")
  end
end
