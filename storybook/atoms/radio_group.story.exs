defmodule Storybook.Atoms.RadioGroup do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.RadioGroup.radio_group/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default radio group",
        attributes: %{name: "plan"},
        slots: [
          ~s|<Bioma.Atoms.RadioGroup.radio_group_item value="free" id="plan-free" name="plan" checked={true} />|,
          ~s|<span class="text-sm">Free</span>|,
          ~s|<Bioma.Atoms.RadioGroup.radio_group_item value="pro" id="plan-pro" name="plan" />|,
          ~s|<span class="text-sm">Pro</span>|,
          ~s|<Bioma.Atoms.RadioGroup.radio_group_item value="enterprise" id="plan-enterprise" name="plan" />|,
          ~s|<span class="text-sm">Enterprise</span>|
        ]
      },
      %Variation{
        id: :disabled,
        description: "Disabled radio item",
        attributes: %{name: "disabled-plan"},
        slots: [
          ~s|<Bioma.Atoms.RadioGroup.radio_group_item value="option" id="disabled-option" name="disabled-plan" disabled={true} />|,
          ~s|<span class="text-sm text-muted-foreground">Disabled option</span>|
        ]
      }
    ]
  end
end
