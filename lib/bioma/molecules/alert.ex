defmodule Bioma.Molecules.Alert do
  @moduledoc """
  An alert component following shadcn/ui design patterns.

  Displays a callout message with support for multiple visual variants including
  default, destructive, success, and warning. Uses the semantic color system
  for consistent theming. Supports an icon slot positioned absolutely to the left.

  ## Examples

      <.alert>
        <.alert_title>Heads up!</.alert_title>
        <.alert_description>
          You can add components to your app using the CLI.
        </.alert_description>
      </.alert>

      <.alert variant="destructive">
        <.alert_title>Error</.alert_title>
        <.alert_description>
          Your session has expired. Please log in again.
        </.alert_description>
      </.alert>

      <.alert variant="success">
        <.alert_title>Success</.alert_title>
        <.alert_description>Changes saved successfully.</.alert_description>
      </.alert>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # alert/1
  # ---------------------------------------------------------------------------

  attr :variant, :string,
    default: "default",
    values: ~w(default destructive success warning),
    doc: "The visual style variant of the alert."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The content of the alert (title, description, icons)."

  @doc """
  Renders an alert container with the specified variant styling.
  """
  def alert(assigns) do
    ~H"""
    <div
      role="alert"
      class={
        cn([
          "relative w-full rounded-lg border p-4 [&>svg~*]:pl-7 [&>svg+div]:translate-y-[-3px] [&>svg]:absolute [&>svg]:left-4 [&>svg]:top-4 [&>svg]:text-foreground",
          variant_classes(@variant),
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
  # alert_title/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The title text."

  @doc """
  Renders the title within an alert.
  """
  def alert_title(assigns) do
    ~H"""
    <h5
      class={
        cn([
          "mb-1 font-medium leading-none tracking-tight",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </h5>
    """
  end

  # ---------------------------------------------------------------------------
  # alert_description/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The description text."

  @doc """
  Renders a description within an alert.
  """
  def alert_description(assigns) do
    ~H"""
    <div
      class={
        cn([
          "text-sm [&_p]:leading-relaxed",
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

  defp variant_classes("default"), do: "bg-background text-foreground"
  defp variant_classes("destructive"), do: "border-destructive/50 text-destructive dark:border-destructive [&>svg]:text-destructive"
  defp variant_classes("success"), do: "border-ai-success/50 text-ai-success-foreground bg-ai-success"
  defp variant_classes("warning"), do: "border-ai-system/50 text-ai-system-foreground bg-ai-system"
end
