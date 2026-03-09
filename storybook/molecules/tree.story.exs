defmodule Storybook.Molecules.Tree do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Tree.tree/1

  def variations do
    [
      %Variation{
        id: :file_browser,
        description: "File browser — expand/collapse folders, selected file highlighted",
        attributes: %{id: "tree-file-browser"},
        slots: [
          ~s|<Bioma.Molecules.Tree.tree_node id="fb-src" label="src" expanded={true}>|,
          ~s|  <:icon><svg class="h-4 w-4 text-amber-500" viewBox="0 0 24 24" fill="currentColor"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg></:icon>|,
          ~s|  <Bioma.Molecules.Tree.tree_node id="fb-atoms" label="atoms" expanded={true}>|,
          ~s|    <:icon><svg class="h-4 w-4 text-amber-500" viewBox="0 0 24 24" fill="currentColor"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg></:icon>|,
          ~s|    <Bioma.Molecules.Tree.tree_node id="fb-button" label="button.ex" selected={true}>|,
          ~s|      <:icon><svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg></:icon>|,
          ~s|    </Bioma.Molecules.Tree.tree_node>|,
          ~s|    <Bioma.Molecules.Tree.tree_node id="fb-input" label="input.ex">|,
          ~s|      <:icon><svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg></:icon>|,
          ~s|    </Bioma.Molecules.Tree.tree_node>|,
          ~s|    <Bioma.Molecules.Tree.tree_node id="fb-badge" label="badge.ex">|,
          ~s|      <:icon><svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg></:icon>|,
          ~s|    </Bioma.Molecules.Tree.tree_node>|,
          ~s|  </Bioma.Molecules.Tree.tree_node>|,
          ~s|  <Bioma.Molecules.Tree.tree_node id="fb-molecules" label="molecules">|,
          ~s|    <:icon><svg class="h-4 w-4 text-amber-500" viewBox="0 0 24 24" fill="currentColor"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg></:icon>|,
          ~s|    <Bioma.Molecules.Tree.tree_node id="fb-card" label="card.ex">|,
          ~s|      <:icon><svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg></:icon>|,
          ~s|    </Bioma.Molecules.Tree.tree_node>|,
          ~s|    <Bioma.Molecules.Tree.tree_node id="fb-tree" label="tree.ex">|,
          ~s|      <:icon><svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg></:icon>|,
          ~s|    </Bioma.Molecules.Tree.tree_node>|,
          ~s|  </Bioma.Molecules.Tree.tree_node>|,
          ~s|</Bioma.Molecules.Tree.tree_node>|,
          ~s|<Bioma.Molecules.Tree.tree_node id="fb-mix" label="mix.exs">|,
          ~s|  <:icon><svg class="h-4 w-4 text-muted-foreground" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg></:icon>|,
          ~s|</Bioma.Molecules.Tree.tree_node>|
        ]
      },
      %Variation{
        id: :skill_library,
        description: "Skill library browser — no icons, minimal style",
        attributes: %{id: "tree-skills"},
        slots: [
          ~s|<Bioma.Molecules.Tree.tree_node id="sk-skills" label="Skills" expanded={true}>|,
          ~s|  <Bioma.Molecules.Tree.tree_node id="sk-code" label="Code Generation" expanded={true}>|,
          ~s|    <Bioma.Molecules.Tree.tree_node id="sk-python" label="python_gen.md" selected={true} />|,
          ~s|    <Bioma.Molecules.Tree.tree_node id="sk-elixir" label="elixir_gen.md" />|,
          ~s|    <Bioma.Molecules.Tree.tree_node id="sk-ts" label="typescript_gen.md" />|,
          ~s|  </Bioma.Molecules.Tree.tree_node>|,
          ~s|  <Bioma.Molecules.Tree.tree_node id="sk-search" label="Search">|,
          ~s|    <Bioma.Molecules.Tree.tree_node id="sk-web" label="web_search.md" />|,
          ~s|    <Bioma.Molecules.Tree.tree_node id="sk-semantic" label="semantic_search.md" />|,
          ~s|  </Bioma.Molecules.Tree.tree_node>|,
          ~s|  <Bioma.Molecules.Tree.tree_node id="sk-tools" label="Tools" />|,
          ~s|</Bioma.Molecules.Tree.tree_node>|
        ]
      }
    ]
  end
end
