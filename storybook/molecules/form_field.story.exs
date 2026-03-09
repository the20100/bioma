defmodule Storybook.Molecules.FormField do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.FormField.form_field/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Form field with label and description",
        slots: [
          ~s|<Bioma.Molecules.FormField.form_label for="email-input">Email</Bioma.Molecules.FormField.form_label>|,
          ~s|<input id="email-input" type="email" placeholder="you@example.com" class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2" />|,
          ~s|<Bioma.Molecules.FormField.form_description>We'll never share your email.</Bioma.Molecules.FormField.form_description>|
        ]
      },
      %Variation{
        id: :with_error,
        description: "Form field with error",
        slots: [
          ~s|<Bioma.Molecules.FormField.form_label for="name-input" error={true}>Name</Bioma.Molecules.FormField.form_label>|,
          ~s|<input id="name-input" type="text" class="flex h-10 w-full rounded-md border border-destructive bg-background px-3 py-2 text-sm ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-destructive focus-visible:ring-offset-2" />|,
          ~s|<Bioma.Molecules.FormField.form_message errors={["can't be blank"]} />|
        ]
      }
    ]
  end
end
