defmodule Storybook.Organisms.AI.ChatInput do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.ChatInput.chat_input/1

  def variations do
    [
      %Variation{
        id: :card,
        description: "Card variant (default)",
        attributes: %{id: "demo-card-input"}
      },
      %Variation{
        id: :flat_bar,
        description: "Legacy flat bar variant",
        attributes: %{id: "demo-flat-input", variant: "default"}
      },
      %Variation{
        id: :submitting,
        description: "Submitting state with pixel loader",
        attributes: %{id: "demo-submitting", submitting: true}
      },
      %Variation{
        id: :disabled,
        description: "Disabled",
        attributes: %{id: "demo-disabled", disabled: true}
      },
      %Variation{
        id: :no_send,
        description: "Hidden send button",
        attributes: %{id: "demo-no-send", show_send: false}
      },
      %Variation{
        id: :custom_max_rows,
        description: "Custom max rows (10)",
        attributes: %{id: "demo-max-rows", max_rows: 10}
      }
    ]
  end
end
