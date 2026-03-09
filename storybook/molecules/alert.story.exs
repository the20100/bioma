defmodule Storybook.Molecules.Alert do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Alert.alert/1

  def variations do
    [
      %VariationGroup{
        id: :variants,
        description: "Alert variants",
        variations:
          for variant <- ~w(default destructive success warning) do
            %Variation{
              id: String.to_atom(variant),
              attributes: %{variant: variant},
              slots: [
                ~s|<Bioma.Molecules.Alert.alert_title>#{String.capitalize(variant)}</Bioma.Molecules.Alert.alert_title>|,
                ~s|<Bioma.Molecules.Alert.alert_description>This is a #{variant} alert message.</Bioma.Molecules.Alert.alert_description>|
              ]
            }
          end
      }
    ]
  end
end
