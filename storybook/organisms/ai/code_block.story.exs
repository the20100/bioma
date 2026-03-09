defmodule Storybook.Organisms.AI.CodeBlock do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.CodeBlock.code_block/1

  def variations do
    [
      %Variation{
        id: :elixir,
        description: "Elixir code block",
        attributes: %{
          language: "elixir",
          code: """
          defmodule MyApp.Worker do
            use GenServer

            def start_link(opts) do
              GenServer.start_link(__MODULE__, opts, name: __MODULE__)
            end

            def init(state), do: {:ok, state}
          end
          """
        }
      },
      %Variation{
        id: :javascript,
        description: "JavaScript code block",
        attributes: %{
          language: "javascript",
          code: """
          const fetchData = async (url) => {
            const response = await fetch(url);
            return response.json();
          };
          """
        }
      },
      %Variation{
        id: :with_filename,
        description: "With filename",
        attributes: %{
          language: "elixir",
          filename: "lib/my_app/worker.ex",
          code: "defmodule MyApp.Worker do\n  # ...\nend"
        }
      }
    ]
  end
end
