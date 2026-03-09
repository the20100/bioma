defmodule Storybook.Molecules.Toast do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Toast.toast/1

  def variations do
    [
      %VariationGroup{
        id: :variants,
        description: "Toast variants",
        variations:
          for {variant, idx} <- Enum.with_index(~w(default success error warning info)) do
            %Variation{
              id: String.to_atom(variant),
              attributes: %{id: "toast-#{idx}", variant: variant},
              slots: ["This is a #{variant} toast notification."]
            }
          end
      }
    ]
  end
end
