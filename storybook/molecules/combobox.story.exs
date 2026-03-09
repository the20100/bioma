defmodule Storybook.Molecules.Combobox do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Combobox.combobox/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default combobox",
        attributes: %{
          id: "demo-combobox",
          name: "language",
          placeholder: "Select language...",
          class: "w-[200px]",
          options: [
            %{value: "elixir", label: "Elixir"},
            %{value: "rust", label: "Rust"},
            %{value: "go", label: "Go"},
            %{value: "python", label: "Python"},
            %{value: "typescript", label: "TypeScript"}
          ]
        }
      },
      %Variation{
        id: :with_value,
        description: "With selected value",
        attributes: %{
          id: "demo-combobox-val",
          name: "language",
          value: "elixir",
          class: "w-[200px]",
          options: [
            %{value: "elixir", label: "Elixir"},
            %{value: "rust", label: "Rust"},
            %{value: "go", label: "Go"}
          ]
        }
      }
    ]
  end
end
