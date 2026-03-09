defmodule Bioma.Organisms.AI.ToolCallDisplay do
  @moduledoc """
  A tool call display component for AI conversations.

  Renders the details of an AI tool/function call with status indication,
  collapsible parameter and result sections, error display, and optional
  execution duration. Border color and status icon change based on the
  current status of the tool call.

  ## Examples

      <.tool_call_display name="search_web" status="running" />

      <.tool_call_display
        name="get_weather"
        status="success"
        parameters={~s|{"city": "Paris"}|}
        result={~s|{"temp": 22, "condition": "sunny"}|}
        duration_ms={340}
      />

      <.tool_call_display
        name="execute_code"
        status="error"
        parameters={~s|{"code": "1/0"}|}
        error="ZeroDivisionError: division by zero"
      />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :name, :string, required: true, doc: "The name of the tool or function being called."

  attr :status, :string,
    default: "pending",
    values: ~w(pending running success error),
    doc: "The current execution status of the tool call."

  attr :parameters, :string,
    default: nil,
    doc: "A JSON string representing the parameters passed to the tool."

  attr :result, :string,
    default: nil,
    doc: "A JSON string representing the result returned by the tool."

  attr :error, :string,
    default: nil,
    doc: "An error message if the tool call failed."

  attr :duration_ms, :integer,
    default: nil,
    doc: "The execution duration in milliseconds."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the container."

  @doc """
  Renders a tool call display with status icon, collapsible sections, and error state.
  """
  def tool_call_display(assigns) do
    assigns =
      assign(assigns,
        params_id: "tool-params-#{System.unique_integer([:positive])}",
        result_id: "tool-result-#{System.unique_integer([:positive])}"
      )

    ~H"""
    <div
      class={
        cn([
          "rounded-lg border p-3",
          border_class(@status),
          @class
        ])
      }
      {@rest}
    >
      <%!-- Header row: status icon, tool name, duration --%>
      <div class="flex items-center gap-2">
        <%!-- Status icon --%>
        <.status_icon status={@status} />
        <%!-- Tool name --%>
        <span class="font-mono text-sm font-medium">{@name}</span>
        <%!-- Duration --%>
        <span :if={@duration_ms} class="text-xs text-muted-foreground ml-auto">
          {format_duration(@duration_ms)}
        </span>
      </div>

      <%!-- Parameters section (collapsible) --%>
      <div :if={@parameters}>
        <button
          type="button"
          class="text-xs text-muted-foreground font-medium mt-2 cursor-pointer hover:text-foreground transition-colors"
          phx-click={toggle_section(@params_id)}
        >
          Parameters
        </button>
        <div id={@params_id} class="bg-muted rounded p-2 text-xs font-mono overflow-x-auto mt-1" style="display: none;">
          <pre class="whitespace-pre-wrap break-all">{@parameters}</pre>
        </div>
      </div>

      <%!-- Result section (collapsible) --%>
      <div :if={@result}>
        <button
          type="button"
          class="text-xs text-muted-foreground font-medium mt-2 cursor-pointer hover:text-foreground transition-colors"
          phx-click={toggle_section(@result_id)}
        >
          Result
        </button>
        <div id={@result_id} class="bg-muted rounded p-2 text-xs font-mono overflow-x-auto mt-1" style="display: none;">
          <pre class="whitespace-pre-wrap break-all">{@result}</pre>
        </div>
      </div>

      <%!-- Error section --%>
      <div :if={@error} class="bg-ai-error rounded p-2 text-xs text-ai-error-foreground mt-2">
        {@error}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Status icon sub-component
  # ---------------------------------------------------------------------------

  defp status_icon(%{status: "pending"} = assigns) do
    ~H"""
    <svg
      class="h-4 w-4 text-muted-foreground"
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
    >
      <circle cx="12" cy="12" r="10" />
    </svg>
    """
  end

  defp status_icon(%{status: "running"} = assigns) do
    ~H"""
    <svg
      class="h-4 w-4 text-ai-running-foreground animate-spin"
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
    >
      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" />
      <path
        class="opacity-75"
        fill="currentColor"
        d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
      />
    </svg>
    """
  end

  defp status_icon(%{status: "success"} = assigns) do
    ~H"""
    <svg
      class="h-4 w-4 text-ai-success-foreground"
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
    >
      <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
      <polyline points="22 4 12 14.01 9 11.01" />
    </svg>
    """
  end

  defp status_icon(%{status: "error"} = assigns) do
    ~H"""
    <svg
      class="h-4 w-4 text-ai-error-foreground"
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
    >
      <circle cx="12" cy="12" r="10" />
      <line x1="15" y1="9" x2="9" y2="15" />
      <line x1="9" y1="9" x2="15" y2="15" />
    </svg>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  defp border_class("pending"), do: "border-border"
  defp border_class("running"), do: "border-ai-running"
  defp border_class("success"), do: "border-ai-success"
  defp border_class("error"), do: "border-ai-error"

  defp toggle_section(id) do
    Phoenix.LiveView.JS.toggle(
      %Phoenix.LiveView.JS{},
      to: "##{id}",
      in: {"ease-out duration-200", "opacity-0", "opacity-100"},
      out: {"ease-in duration-150", "opacity-100", "opacity-0"}
    )
  end

  defp format_duration(ms) when ms < 1000, do: "#{ms}ms"
  defp format_duration(ms), do: "#{Float.round(ms / 1000, 1)}s"
end
