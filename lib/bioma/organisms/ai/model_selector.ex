defmodule Bioma.Organisms.AI.ModelSelector do
  @moduledoc """
  A model selector component for choosing AI models.

  Renders a themed native HTML `<select>` element populated from a list of model
  maps. Each model must have `:id` and `:name` keys, with an optional
  `:description`. Supports disabled state and integrates with Phoenix LiveView
  change events via `phx-change`.

  ## Examples

      <.model_selector
        models={[
          %{id: "claude-opus-4-6", name: "Claude Opus 4.6"},
          %{id: "claude-sonnet-4", name: "Claude Sonnet 4", description: "Fast and capable"},
          %{id: "gpt-4o", name: "GPT-4o"}
        ]}
        selected="claude-opus-4-6"
      />

      <.model_selector
        id="my-selector"
        models={@available_models}
        selected={@current_model}
        phx-change="model_changed"
      />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :id, :string,
    default: "model-selector",
    doc: "The HTML id attribute for the select element."

  attr :models, :list,
    required: true,
    doc: "A list of model maps, each with :id, :name, and optional :description keys."

  attr :selected, :string,
    default: nil,
    doc: "The id of the currently selected model."

  attr :disabled, :boolean,
    default: false,
    doc: "Whether the selector is disabled."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global,
    include: ~w(phx-change name form),
    doc: "Additional HTML attributes, including phx-change for LiveView integration."

  @doc """
  Renders a native select element styled to match the design system.
  """
  def model_selector(assigns) do
    ~H"""
    <div class="relative">
      <select
        id={@id}
        disabled={@disabled}
        class={
          cn([
            "flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50",
            @class
          ])
        }
        {@rest}
      >
        <option :for={model <- @models} value={model.id} selected={model.id == @selected}>
          {model.name}{if Map.get(model, :description), do: " — #{model.description}", else: ""}
        </option>
      </select>
    </div>
    """
  end
end
