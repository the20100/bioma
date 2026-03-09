defmodule Storybook.Organisms.AI.ToolCallDisplay do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.ToolCallDisplay.tool_call_display/1

  def variations do
    [
      %Variation{
        id: :pending,
        description: "Pending tool call",
        attributes: %{
          id: "tool-1",
          name: "search_database",
          status: "pending",
          parameters: "query: elixir genserver, limit: 10"
        }
      },
      %Variation{
        id: :running,
        description: "Running tool call",
        attributes: %{
          id: "tool-2",
          name: "execute_code",
          status: "running",
          parameters: "language: elixir, code: 1 + 1"
        }
      },
      %Variation{
        id: :success,
        description: "Successful tool call",
        attributes: %{
          id: "tool-3",
          name: "read_file",
          status: "success",
          parameters: "path: lib/my_app.ex",
          result: "content: defmodule MyApp do...end, lines: 42",
          duration_ms: 125
        }
      },
      %Variation{
        id: :error,
        description: "Failed tool call",
        attributes: %{
          id: "tool-4",
          name: "write_file",
          status: "error",
          parameters: "path: /etc/config",
          error: "Permission denied: cannot write to /etc/config",
          duration_ms: 15
        }
      }
    ]
  end
end
