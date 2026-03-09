defmodule Storybook.Organisms.AI.AgentCard do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.AgentCard.agent_card/1

  def variations do
    [
      %Variation{
        id: :idle,
        description: "Idle agent",
        attributes: %{
          name: "Code Assistant",
          model: "claude-opus-4-6",
          description: "An AI agent specialized in code review and generation.",
          status: "idle"
        }
      },
      %Variation{
        id: :running,
        description: "Running agent",
        attributes: %{
          name: "Research Agent",
          model: "claude-sonnet-4-6",
          description: "Searches and synthesizes information from multiple sources.",
          status: "running"
        }
      },
      %Variation{
        id: :error,
        description: "Error state agent",
        attributes: %{
          name: "Deploy Agent",
          model: "claude-haiku-4-5",
          description: "Handles deployment pipelines.",
          status: "error"
        }
      }
    ]
  end
end
