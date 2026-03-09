defmodule Bioma.Organisms.AI.MarkdownRenderer do
  @moduledoc """
  A markdown renderer component for displaying AI-generated markdown content.

  Wraps content in a Tailwind CSS Typography (`prose`) container with dark mode
  support. This is a simple implementation that renders raw content within a
  prose-styled div.

  For full markdown rendering (headings, lists, code blocks, tables, etc.),
  consumers should integrate [MDEx](https://hexdocs.pm/mdex) or another markdown
  library and pass the rendered HTML as the `content` attribute.

  ## Examples

      <.markdown content={@assistant_response} />

      <.markdown content={MDEx.to_html!(@raw_markdown)} class="my-custom-prose" />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :content, :string, required: true, doc: "The content to render, ideally pre-rendered HTML from a markdown library."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the container."

  @doc """
  Renders content inside a prose-styled container.

  For best results, pass HTML that has been pre-rendered from markdown using a
  library such as MDEx. When raw text is passed, it will be displayed as-is
  within the prose wrapper.
  """
  def markdown(assigns) do
    ~H"""
    <div
      class={
        cn([
          "prose prose-sm dark:prose-invert max-w-none",
          @class
        ])
      }
      {@rest}
    >
      {Phoenix.HTML.raw(@content)}
    </div>
    """
  end
end
