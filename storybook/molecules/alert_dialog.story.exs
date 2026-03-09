defmodule Storybook.Molecules.AlertDialog do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.AlertDialog.alert_dialog/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default alert dialog",
        attributes: %{id: "demo-alert-dialog"},
        slots: [
          ~s|<Bioma.Molecules.AlertDialog.alert_dialog_trigger target="demo-alert-dialog">|,
          ~s|  <button class="inline-flex items-center justify-center rounded-md text-sm font-medium bg-destructive text-destructive-foreground h-10 px-4 py-2 hover:bg-destructive/90">Delete Account</button>|,
          ~s|</Bioma.Molecules.AlertDialog.alert_dialog_trigger>|,
          ~s|<Bioma.Molecules.AlertDialog.alert_dialog_content target="demo-alert-dialog">|,
          ~s|  <Bioma.Molecules.AlertDialog.alert_dialog_header>|,
          ~s|    <Bioma.Molecules.AlertDialog.alert_dialog_title>Are you absolutely sure?</Bioma.Molecules.AlertDialog.alert_dialog_title>|,
          ~s|    <Bioma.Molecules.AlertDialog.alert_dialog_description>This action cannot be undone. This will permanently delete your account.</Bioma.Molecules.AlertDialog.alert_dialog_description>|,
          ~s|  </Bioma.Molecules.AlertDialog.alert_dialog_header>|,
          ~s|  <Bioma.Molecules.AlertDialog.alert_dialog_footer>|,
          ~s|    <Bioma.Molecules.AlertDialog.alert_dialog_cancel target="demo-alert-dialog">Cancel</Bioma.Molecules.AlertDialog.alert_dialog_cancel>|,
          ~s|    <Bioma.Molecules.AlertDialog.alert_dialog_action>Continue</Bioma.Molecules.AlertDialog.alert_dialog_action>|,
          ~s|  </Bioma.Molecules.AlertDialog.alert_dialog_footer>|,
          ~s|</Bioma.Molecules.AlertDialog.alert_dialog_content>|
        ]
      }
    ]
  end
end
