defmodule Bioma.Organisms.AI.CodeBlock do
  @moduledoc """
  A code block component for displaying code snippets in AI conversations.

  Renders syntax-highlighted code with optional language labels, filenames,
  and copy-to-clipboard functionality. Uses a `CopyToClipboard` LiveView hook
  for the copy button behavior.

  ## Examples

      <.code_block code={~s|defmodule Hello do\n  def world, do: "hello"\nend|} language="elixir" />

      <.code_block
        code={@snippet}
        language="python"
        filename="main.py"
      />

      <.code_block code={@raw_output} show_copy={false} />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :code, :string, required: true, doc: "The code content to display."

  attr :language, :string,
    default: nil,
    doc: "The programming language for display in the header."

  attr :filename, :string,
    default: nil,
    doc: "An optional filename to display in the header."

  attr :show_copy, :boolean,
    default: true,
    doc: "Whether to show the copy-to-clipboard button."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the container."

  @doc """
  Renders a code block with optional header and copy button.
  """
  def code_block(assigns) do
    assigns = assign(assigns, :copy_id, "copy-btn-#{System.unique_integer([:positive])}")
    has_header = assigns.language != nil or assigns.filename != nil
    assigns = assign(assigns, :has_header, has_header)

    ~H"""
    <div
      class={
        cn([
          "relative group rounded-lg border bg-muted overflow-hidden",
          @class
        ])
      }
      {@rest}
    >
      <%!-- Header bar with language/filename and copy button --%>
      <div
        :if={@has_header}
        class="flex items-center justify-between px-4 py-2 border-b bg-muted/50"
      >
        <span class="text-xs text-muted-foreground font-mono">
          {@filename || @language}
        </span>
        <button
          :if={@show_copy}
          id={@copy_id}
          phx-hook="CopyToClipboard"
          data-code={@code}
          type="button"
          class="opacity-0 group-hover:opacity-100 transition-opacity text-xs text-muted-foreground hover:text-foreground cursor-pointer"
        >
          Copy
        </button>
      </div>
      <%!-- Floating copy button when no header is present --%>
      <button
        :if={@show_copy && !@has_header}
        id={@copy_id}
        phx-hook="CopyToClipboard"
        data-code={@code}
        type="button"
        class="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity text-xs text-muted-foreground hover:text-foreground cursor-pointer"
      >
        Copy
      </button>
      <%!-- Code area --%>
      <div class="overflow-x-auto p-4">
        <pre><code class="text-sm font-mono">{@code}</code></pre>
      </div>
    </div>
    """
  end
end
