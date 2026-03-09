defmodule Storybook.Organisms.AI.ChatInput do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.ChatInput.chat_input/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default chat input",
        attributes: %{id: "demo-chat-input"}
      },
      %Variation{
        id: :submitting,
        description: "Submitting state",
        attributes: %{id: "demo-chat-submitting", submitting: true}
      },
      %Variation{
        id: :disabled,
        description: "Disabled",
        attributes: %{id: "demo-chat-disabled", disabled: true}
      }
    ]
  end
end
