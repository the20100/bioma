defmodule Bioma.Molecules.MarkdownEditor do
  @moduledoc """
  A markdown editor with formatting toolbar and optional live preview.

  Renders a textarea with toolbar buttons for common markdown actions (bold,
  italic, strikethrough, inline code, code block, link, blockquote, bullet
  list, ordered list, heading). Supports three display modes:

  - `"edit"` — textarea only
  - `"preview"` — rendered HTML only
  - `"split"` — side-by-side editor and preview

  The preview pane renders pre-supplied `preview_html`. For live preview, wire
  `phx-change` on the textarea (`name` attribute) in your parent LiveView and
  pass the re-rendered `MDEx.to_html!(@content)` back as `preview_html`.

  Requires the `MarkdownEditor` JS hook to be registered in `BiomaHooks`.

  ## Examples

      <%!-- Basic editor (no live preview) --%>
      <.markdown_editor id="post-body" name="body" value={@draft} />

      <%!-- With live preview (parent LiveView handles phx-change) --%>
      <.markdown_editor
        id="post-body"
        name="body"
        value={@draft}
        preview_html={MDEx.to_html!(@draft)}
        mode="split"
      />
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  alias Phoenix.LiveView.JS

  # ---------------------------------------------------------------------------
  # markdown_editor/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique component ID, also scopes child element IDs."

  attr :name, :string, default: nil, doc: "Form `name` attribute for the textarea."

  attr :value, :string, default: "", doc: "Current markdown text content."

  attr :placeholder, :string,
    default: "Write markdown here…",
    doc: "Textarea placeholder text."

  attr :preview_html, :string,
    default: nil,
    doc: """
    Pre-rendered HTML string for the preview pane.
    Typically: `MDEx.to_html!(@content)` from the parent LiveView.
    When `nil`, the preview pane shows a setup hint.
    """

  attr :mode, :string,
    default: "edit",
    values: ~w(edit preview split),
    doc: "Initial display mode: `\"edit\"`, `\"preview\"`, or `\"split\"`."

  attr :rows, :integer, default: 12, doc: "Textarea row count."

  attr :class, :string, default: nil, doc: "Additional CSS classes on the outer wrapper."

  attr :rest, :global, doc: "Additional HTML attributes on the outer wrapper."

  @doc """
  Renders a markdown editor with toolbar and optional live preview.
  """
  def markdown_editor(assigns) do
    ~H"""
    <div
      id={@id}
      data-mode={@mode}
      phx-hook="MarkdownEditor"
      class={cn(["rounded-lg border bg-background overflow-hidden", @class])}
      {@rest}
    >
      <%!-- ── Toolbar ─────────────────────────────────────────────────────── --%>
      <div class="flex flex-wrap items-center gap-0.5 border-b bg-muted/30 px-2 py-1.5">
        <%!-- Mode switcher --%>
        <div class="flex rounded-md border overflow-hidden mr-2">
          <button
            :for={{mode_val, label} <- [{"edit", "Edit"}, {"preview", "Preview"}, {"split", "Split"}]}
            type="button"
            data-mode-btn={mode_val}
            phx-click={JS.dispatch("md-editor:switch-mode", to: "##{@id}", detail: %{mode: mode_val})}
            class={cn([
              "px-2.5 py-1 text-xs transition-colors hover:bg-muted",
              @mode == mode_val && "bg-background font-medium"
            ])}
          >
            {label}
          </button>
        </div>

        <div class="h-4 w-px bg-border mx-0.5" />

        <%!-- Format buttons --%>
        <button
          :for={{action, title, icon_svg} <- toolbar_buttons()}
          type="button"
          title={title}
          phx-click={JS.dispatch("md-editor:action", to: "##{@id}", detail: %{action: action})}
          class="h-7 w-7 flex items-center justify-center rounded hover:bg-muted transition-colors text-muted-foreground hover:text-foreground"
        >
          {Phoenix.HTML.raw(icon_svg)}
        </button>
      </div>

      <%!-- ── Content area ─────────────────────────────────────────────────── --%>
      <div class="flex divide-x" style="min-height: 0;">
        <%!-- Edit pane --%>
        <div
          id={"#{@id}-edit-pane"}
          class={cn(["flex-1", @mode == "preview" && "hidden"])}
        >
          <textarea
            id={"#{@id}-textarea"}
            name={@name}
            rows={@rows}
            placeholder={@placeholder}
            class="w-full resize-none bg-background px-4 py-3 font-mono text-sm focus:outline-none placeholder:text-muted-foreground"
          >{@value}</textarea>
        </div>

        <%!-- Preview pane --%>
        <div
          id={"#{@id}-preview-pane"}
          class={cn(["flex-1 overflow-auto", @mode == "edit" && "hidden"])}
        >
          <div class="px-4 py-3">
            <div
              :if={@preview_html}
              class="prose prose-sm dark:prose-invert max-w-none"
            >
              {Phoenix.HTML.raw(@preview_html)}
            </div>
            <p
              :if={!@preview_html}
              class="text-sm text-muted-foreground italic leading-relaxed"
            >
              Preview requires <code class="text-xs bg-muted px-1 py-0.5 rounded">preview_html</code>.
              In your LiveView: handle <code class="text-xs bg-muted px-1 py-0.5 rounded">phx-change</code>
              and pass <code class="text-xs bg-muted px-1 py-0.5 rounded">MDEx.to_html!(@content)</code>.
            </p>
          </div>
        </div>
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # Private helpers
  # ---------------------------------------------------------------------------

  # Returns {action_key, tooltip_title, inline_svg_html}
  defp toolbar_buttons do
    [
      {"bold", "Bold",
       ~s|<svg class="h-3.5 w-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/></svg>|},
      {"italic", "Italic",
       ~s|<svg class="h-3.5 w-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="19" x2="10" y1="4" y2="4"/><line x1="14" x2="5" y1="20" y2="20"/><line x1="15" x2="9" y1="4" y2="20"/></svg>|},
      {"strikethrough", "Strikethrough",
       ~s|<svg class="h-3.5 w-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 4H9a3 3 0 0 0-2.83 4"/><path d="M14 12a4 4 0 0 1 0 8H6"/><line x1="4" x2="20" y1="12" y2="12"/></svg>|},
      {"code", "Inline code",
       ~s|<svg class="h-3.5 w-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="16,18 22,12 16,6"/><polyline points="8,6 2,12 8,18"/></svg>|},
      {"code_block", "Code block",
       ~s|<svg class="h-3.5 w-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="18" height="18" x="3" y="3" rx="2"/><path d="m9 9-2 3 2 3"/><path d="m15 9 2 3-2 3"/></svg>|},
      {"link", "Link",
       ~s|<svg class="h-3.5 w-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"/><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"/></svg>|},
      {"quote", "Blockquote",
       ~s|<svg class="h-3.5 w-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 21c3 0 7-1 7-8V5c0-1.25-.756-2.017-2-2H4c-1.25 0-2 .75-2 1.972V11c0 1.25.75 2 2 2 1 0 1 0 1 1v1c0 1-1 2-2 2s-1 .008-1 1.031V20c0 1 0 1 1 1z"/><path d="M15 21c3 0 7-1 7-8V5c0-1.25-.757-2.017-2-2h-4c-1.25 0-2 .75-2 1.972V11c0 1.25.75 2 2 2h.75c0 2.25.25 4-2.75 4v3c0 1 0 1 1 1z"/></svg>|},
      {"ul", "Bullet list",
       ~s|<svg class="h-3.5 w-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="8" x2="21" y1="6" y2="6"/><line x1="8" x2="21" y1="12" y2="12"/><line x1="8" x2="21" y1="18" y2="18"/><line x1="3" x2="3.01" y1="6" y2="6"/><line x1="3" x2="3.01" y1="12" y2="12"/><line x1="3" x2="3.01" y1="18" y2="18"/></svg>|},
      {"ol", "Numbered list",
       ~s|<svg class="h-3.5 w-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="10" x2="21" y1="6" y2="6"/><line x1="10" x2="21" y1="12" y2="12"/><line x1="10" x2="21" y1="18" y2="18"/><path d="M4 6h1v4"/><path d="M4 10h2"/><path d="M6 18H4c0-1 2-2 2-3s-1-1.5-2-1"/></svg>|},
      {"heading", "Heading",
       ~s|<svg class="h-3.5 w-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 12h12"/><path d="M6 20V4"/><path d="M18 20V4"/></svg>|}
    ]
  end
end
