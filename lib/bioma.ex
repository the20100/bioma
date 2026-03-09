defmodule Bioma do
  @moduledoc """
  A composable Phoenix LiveView component library for AI agentic platforms.

  ## Usage

      # Import all components
      use Bioma

      # Import specific groups
      use Bioma, only: [:atoms]
      use Bioma, only: [:atoms, :molecules]

      # Import individual components
      import Bioma.Atoms.Button
  """

  defmacro __using__(opts \\ []) do
    groups = Keyword.get(opts, :only, [:atoms, :molecules, :organisms])
    groups = List.wrap(groups)

    imports =
      Enum.flat_map(groups, fn
        :atoms ->
          [
            quote(do: import(Bioma.Atoms.Button)),
            quote(do: import(Bioma.Atoms.Input)),
            quote(do: import(Bioma.Atoms.Textarea)),
            quote(do: import(Bioma.Atoms.Label)),
            quote(do: import(Bioma.Atoms.Badge)),
            quote(do: import(Bioma.Atoms.Avatar)),
            quote(do: import(Bioma.Atoms.Separator)),
            quote(do: import(Bioma.Atoms.Skeleton)),
            quote(do: import(Bioma.Atoms.Spinner)),
            quote(do: import(Bioma.Atoms.Switch)),
            quote(do: import(Bioma.Atoms.Checkbox)),
            quote(do: import(Bioma.Atoms.Toggle)),
            quote(do: import(Bioma.Atoms.Tooltip)),
            quote(do: import(Bioma.Atoms.Kbd)),
            quote(do: import(Bioma.Atoms.Typography))
          ]

        :molecules ->
          [
            quote(do: import(Bioma.Molecules.Card)),
            quote(do: import(Bioma.Molecules.Alert)),
            quote(do: import(Bioma.Molecules.Tabs)),
            quote(do: import(Bioma.Molecules.Toast)),
            quote(do: import(Bioma.Molecules.Progress)),
            quote(do: import(Bioma.Molecules.DropdownMenu)),
            quote(do: import(Bioma.Molecules.Popover)),
            quote(do: import(Bioma.Molecules.ScrollArea)),
            quote(do: import(Bioma.Molecules.CommandPalette))
          ]

        :organisms ->
          [
            quote(do: import(Bioma.Organisms.AI.CodeBlock)),
            quote(do: import(Bioma.Organisms.AI.MarkdownRenderer)),
            quote(do: import(Bioma.Organisms.AI.StreamingText)),
            quote(do: import(Bioma.Organisms.AI.ChatMessage)),
            quote(do: import(Bioma.Organisms.AI.ChatInput)),
            quote(do: import(Bioma.Organisms.AI.ChatThread)),
            quote(do: import(Bioma.Organisms.AI.ThinkingIndicator)),
            quote(do: import(Bioma.Organisms.AI.ToolCallDisplay)),
            quote(do: import(Bioma.Organisms.AI.AgentCard)),
            quote(do: import(Bioma.Organisms.AI.AgentStatus)),
            quote(do: import(Bioma.Organisms.AI.TokenCounter)),
            quote(do: import(Bioma.Organisms.AI.ModelSelector)),
            quote(do: import(Bioma.Organisms.AI.ConversationSidebar))
          ]
      end)

    quote do
      unquote_splicing(imports)
    end
  end
end
