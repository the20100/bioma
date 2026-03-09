defmodule Storybook.Organisms.AI.AgentStatus do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.AgentStatus.agent_status/1

  def variations do
    [
      %VariationGroup{
        id: :statuses,
        description: "All status states",
        variations:
          for status <- ~w(idle running error offline) do
            %Variation{
              id: String.to_atom(status),
              attributes: %{status: status}
            }
          end
      },
      %Variation{
        id: :small,
        description: "Small size",
        attributes: %{status: "running", size: "sm"}
      },
      %Variation{
        id: :custom_label,
        description: "Custom label",
        attributes: %{status: "running", label: "Processing request..."}
      }
    ]
  end
end
