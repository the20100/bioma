defmodule Storybook.Organisms.AI.MarkdownRenderer do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.MarkdownRenderer.markdown/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Markdown content",
        attributes: %{
          content: "This is a **markdown** renderer component. It supports _italic_ and `inline code`."
        }
      }
    ]
  end
end
