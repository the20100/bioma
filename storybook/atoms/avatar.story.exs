defmodule Storybook.Atoms.Avatar do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Avatar.avatar/1

  def variations do
    [
      %Variation{
        id: :with_fallback,
        description: "Avatar with fallback initials",
        slots: [
          ~s|<Bioma.Atoms.Avatar.avatar_fallback>JD</Bioma.Atoms.Avatar.avatar_fallback>|
        ]
      },
      %Variation{
        id: :small,
        description: "Small avatar",
        attributes: %{size: "sm"},
        slots: [
          ~s|<Bioma.Atoms.Avatar.avatar_fallback>S</Bioma.Atoms.Avatar.avatar_fallback>|
        ]
      },
      %Variation{
        id: :large,
        description: "Large avatar",
        attributes: %{size: "lg"},
        slots: [
          ~s|<Bioma.Atoms.Avatar.avatar_fallback>LG</Bioma.Atoms.Avatar.avatar_fallback>|
        ]
      }
    ]
  end
end
