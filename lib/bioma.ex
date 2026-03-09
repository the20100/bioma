defmodule Bioma do
  @moduledoc """
  A composable Phoenix LiveView component library for AI agentic platforms.

  Inspired by [shadcn/ui](https://ui.shadcn.com), Bioma provides atomic,
  molecule, and AI-specific organism components built with Tailwind CSS v4
  and Phoenix LiveView.

  ## Setup

  ### 1. Add to `mix.exs`

      def deps do
        [
          {:bioma, "~> 0.1"},
          # Optional: markdown rendering in ChatMessage/CodeBlock
          {:mdex, "~> 0.4"},
          # Optional: icons
          {:heroicons, "~> 0.5"}
        ]
      end

  ### 2. Tailwind CSS (`assets/css/app.css`)

  Add a `@source` directive and copy the `@theme { ... }` and `.dark { ... }`
  blocks from `deps/bioma/assets/css/app.css`:

      @import "tailwindcss";

      @source "../../deps/bioma/lib/**/*.ex";

      @theme {
        /* paste contents from deps/bioma/assets/css/app.css */
      }

  ### 3. JS Hooks (`assets/js/app.js`)

      import { BiomaHooks } from "../../deps/bioma/assets/js/hooks/index.js";

      let liveSocket = new LiveSocket("/live", Socket, {
        hooks: { ...BiomaHooks, ...YourOwnHooks },
      });

  ## Usage

      # Import all components
      use Bioma

      # Import specific groups
      use Bioma, only: [:atoms]
      use Bioma, only: [:atoms, :molecules]

      # Import individual components
      import Bioma.Atoms.Button
      import Bioma.Organisms.AI.ChatMessage
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
            quote(do: import(Bioma.Molecules.CommandPalette)),
            quote(do: import(Bioma.Molecules.Tree)),
            quote(do: import(Bioma.Molecules.MarkdownEditor)),
            quote(do: import(Bioma.Molecules.Kanban))
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
