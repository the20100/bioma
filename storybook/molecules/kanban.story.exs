defmodule Storybook.Molecules.Kanban do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Kanban.kanban/1

  def variations do
    [
      %Variation{
        id: :sprint_board,
        description: "Sprint board — drag cards between columns",
        attributes: %{id: "kanban-sprint"},
        slots: [
          ~s|<Bioma.Molecules.Kanban.kanban_column id="backlog" title="Backlog" count={3}>|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-task-1" title="Design system audit" label="Design" priority="low" />|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-task-2" title="Set up CI/CD pipeline" label="Infra" description="Configure GitHub Actions with Elixir + Docker." priority="medium" assignee="AR" />|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-task-3" title="Write onboarding documentation" label="Docs" />|,
          ~s|</Bioma.Molecules.Kanban.kanban_column>|,
          ~s|<Bioma.Molecules.Kanban.kanban_column id="in-progress" title="In Progress" count={2}>|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-task-4" title="Build Kanban component" label="Feature" priority="high" description="Drag-and-drop with native HTML5 DnD API." assignee="VM" />|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-task-5" title="Markdown editor toolbar" label="Feature" priority="medium" assignee="VM" />|,
          ~s|</Bioma.Molecules.Kanban.kanban_column>|,
          ~s|<Bioma.Molecules.Kanban.kanban_column id="review" title="Review" count={1}>|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-task-6" title="Tree view component" label="Feature" priority="low" assignee="AR" />|,
          ~s|</Bioma.Molecules.Kanban.kanban_column>|,
          ~s|<Bioma.Molecules.Kanban.kanban_column id="done" title="Done" count={2}>|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-task-7" title="Initial project scaffolding" label="Infra" />|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-task-8" title="Tailwind v4 theme setup" label="Design" />|,
          ~s|</Bioma.Molecules.Kanban.kanban_column>|
        ]
      },
      %Variation{
        id: :ai_agent_tasks,
        description: "AI agent task board — priority indicators + assignee avatars",
        attributes: %{id: "kanban-agents"},
        slots: [
          ~s|<Bioma.Molecules.Kanban.kanban_column id="queue" title="Queue" count={2}>|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-a1" title="Scrape competitor pricing" label="Research" priority="medium" description="Extract pricing tables from 5 competitor sites." assignee="A1" />|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-a2" title="Summarise weekly reports" label="Analysis" priority="low" />|,
          ~s|</Bioma.Molecules.Kanban.kanban_column>|,
          ~s|<Bioma.Molecules.Kanban.kanban_column id="running" title="Running" count={1}>|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-a3" title="Generate release notes" label="Docs" priority="high" description="Summarise commits since v0.3.0 into a changelog." assignee="A2" />|,
          ~s|</Bioma.Molecules.Kanban.kanban_column>|,
          ~s|<Bioma.Molecules.Kanban.kanban_column id="completed" title="Completed" count={1}>|,
          ~s|  <Bioma.Molecules.Kanban.kanban_card id="k-a4" title="Index new codebase files" label="Infra" />|,
          ~s|</Bioma.Molecules.Kanban.kanban_column>|
        ]
      }
    ]
  end
end
