defmodule Storybook.Molecules.Dialog do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Dialog.dialog/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default dialog",
        attributes: %{id: "demo-dialog"},
        slots: [
          ~s|<Bioma.Molecules.Dialog.dialog_trigger target="demo-dialog">|,
          ~s|  <button class="inline-flex items-center justify-center rounded-md text-sm font-medium bg-primary text-primary-foreground h-10 px-4 py-2 hover:bg-primary/90">Open Dialog</button>|,
          ~s|</Bioma.Molecules.Dialog.dialog_trigger>|,
          ~s|<Bioma.Molecules.Dialog.dialog_content target="demo-dialog">|,
          ~s|  <Bioma.Molecules.Dialog.dialog_header>|,
          ~s|    <Bioma.Molecules.Dialog.dialog_title>Edit Profile</Bioma.Molecules.Dialog.dialog_title>|,
          ~s|    <Bioma.Molecules.Dialog.dialog_description>Make changes to your profile here. Click save when you're done.</Bioma.Molecules.Dialog.dialog_description>|,
          ~s|  </Bioma.Molecules.Dialog.dialog_header>|,
          ~s|  <div class="grid gap-4 py-4">|,
          ~s|    <div class="grid grid-cols-4 items-center gap-4">|,
          ~s|      <label class="text-right text-sm">Name</label>|,
          ~s|      <input class="col-span-3 flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm" value="Alice" />|,
          ~s|    </div>|,
          ~s|  </div>|,
          ~s|  <Bioma.Molecules.Dialog.dialog_footer>|,
          ~s|    <Bioma.Molecules.Dialog.dialog_close target="demo-dialog">|,
          ~s|      <button class="inline-flex items-center justify-center rounded-md text-sm font-medium bg-primary text-primary-foreground h-10 px-4 py-2 hover:bg-primary/90">Save changes</button>|,
          ~s|    </Bioma.Molecules.Dialog.dialog_close>|,
          ~s|  </Bioma.Molecules.Dialog.dialog_footer>|,
          ~s|</Bioma.Molecules.Dialog.dialog_content>|
        ]
      }
    ]
  end
end
