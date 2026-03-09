defmodule Storybook.Atoms.Input do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Input.input/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default input",
        attributes: %{type: "text", placeholder: "Enter text..."}
      },
      %Variation{
        id: :email,
        description: "Email input",
        attributes: %{type: "email", placeholder: "email@example.com"}
      },
      %Variation{
        id: :password,
        description: "Password input",
        attributes: %{type: "password", placeholder: "Password"}
      },
      %Variation{
        id: :disabled,
        description: "Disabled input",
        attributes: %{disabled: true, placeholder: "Disabled", value: "Cannot edit"}
      },
      %Variation{
        id: :with_errors,
        description: "Input with errors",
        attributes: %{
          placeholder: "Enter email...",
          errors: ["is required", "must be a valid email"]
        }
      }
    ]
  end
end
