defmodule Storybook.Atoms.Spinner do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Spinner.spinner/1

  def variations do
    [
      %VariationGroup{
        id: :sizes,
        description: "Spinner sizes",
        variations:
          for size <- ~w(sm md lg) do
            %Variation{
              id: String.to_atom(size),
              attributes: %{size: size}
            }
          end
      }
    ]
  end
end
