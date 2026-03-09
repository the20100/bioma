defmodule Storybook.Molecules.MarkdownEditor do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.MarkdownEditor.markdown_editor/1

  @sample_markdown """
  # Hello from Bioma

  This is a **markdown editor** with a formatting toolbar and live preview.

  ## Features

  - **Bold**, _italic_, ~~strikethrough~~
  - `inline code` and code blocks
  - [Links](https://hexdocs.pm/bioma)
  - Blockquotes, lists, headings

  > Use the toolbar buttons above to format selected text, or type markdown directly.

  ```elixir
  def greet(name) do
    "Hello, #{name}!"
  end
  ```
  """

  def variations do
    [
      %Variation{
        id: :edit_mode,
        description: "Edit mode — textarea with toolbar",
        attributes: %{
          id: "md-editor-edit",
          value: @sample_markdown,
          mode: "edit",
          rows: 10
        }
      },
      %Variation{
        id: :split_mode,
        description: "Split mode — editor + rendered preview side-by-side",
        attributes: %{
          id: "md-editor-split",
          value: @sample_markdown,
          preview_html: MDEx.to_html!(@sample_markdown),
          mode: "split",
          rows: 10
        }
      },
      %Variation{
        id: :preview_mode,
        description: "Preview mode — rendered HTML only",
        attributes: %{
          id: "md-editor-preview",
          value: @sample_markdown,
          preview_html: MDEx.to_html!(@sample_markdown),
          mode: "preview",
          rows: 10
        }
      },
      %Variation{
        id: :no_preview_html,
        description: "Without preview_html — shows setup hint in preview pane",
        attributes: %{
          id: "md-editor-hint",
          value: "# Title\n\nSwitch to Preview to see the hint.",
          mode: "split",
          rows: 6
        }
      }
    ]
  end
end
