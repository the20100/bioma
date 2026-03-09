defmodule Storybook.Atoms.Button do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Button.button/1

  def variations do
    [
      %VariationGroup{
        id: :variants,
        description: "Button variants",
        variations:
          for variant <- ~w(default destructive outline secondary ghost link) do
            %Variation{
              id: String.to_atom(variant),
              attributes: %{variant: variant},
              slots: ["#{String.capitalize(variant)}"]
            }
          end
      },
      %VariationGroup{
        id: :sizes,
        description: "Button sizes",
        variations: [
          %Variation{
            id: :size_sm,
            attributes: %{size: "sm"},
            slots: ["Small"]
          },
          %Variation{
            id: :size_default,
            attributes: %{size: "default"},
            slots: ["Default"]
          },
          %Variation{
            id: :size_lg,
            attributes: %{size: "lg"},
            slots: ["Large"]
          },
          %Variation{
            id: :size_icon,
            attributes: %{size: "icon"},
            slots: ["+"]
          }
        ]
      },
      %Variation{
        id: :disabled,
        description: "Disabled state",
        attributes: %{disabled: true},
        slots: ["Disabled"]
      }
    ]
  end
end
