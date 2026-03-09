defmodule Bioma.Atoms.Kbd do
  @moduledoc """
  A keyboard shortcut indicator component.

  Renders an inline keyboard key style indicator, commonly used to display
  keyboard shortcuts.

  ## Examples

      <.kbd>Ctrl+C</.kbd>
      <.kbd>⌘K</.kbd>
      <.kbd class="ml-2">Esc</.kbd>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def kbd(assigns) do
    ~H"""
    <kbd
      class={
        cn([
          "pointer-events-none inline-flex h-5 select-none items-center gap-1 rounded border bg-muted px-1.5 font-mono text-[10px] font-medium text-muted-foreground",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </kbd>
    """
  end
end
