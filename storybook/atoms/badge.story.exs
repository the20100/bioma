defmodule Storybook.Atoms.Badge do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Badge.badge/1

  def variations do
    [
      %VariationGroup{
        id: :variants,
        description: "Badge variants",
        variations:
          for variant <- ~w(default secondary destructive outline success warning) do
            %Variation{
              id: String.to_atom(variant),
              attributes: %{variant: variant},
              slots: [String.capitalize(variant)]
            }
          end
      }
    ]
  end
end
