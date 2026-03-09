defmodule Storybook.Organisms.AI.ChatMessage do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.ChatMessage.chat_message/1

  def variations do
    [
      %Variation{
        id: :user_message,
        description: "User message",
        attributes: %{
          role: "user",
          content: "How do I implement a GenServer in Elixir?",
          name: "Vincent"
        }
      },
      %Variation{
        id: :assistant_message,
        description: "Assistant message",
        attributes: %{
          role: "assistant",
          content: "A GenServer is a generic server process. You implement one by defining callbacks like init, handle_call, and handle_cast.",
          name: "Claude"
        }
      },
      %Variation{
        id: :system_message,
        description: "System message",
        attributes: %{
          role: "system",
          content: "You are a helpful Elixir programming assistant."
        }
      },
      %Variation{
        id: :tool_message,
        description: "Tool message",
        attributes: %{
          role: "tool",
          content: "status: ok, result: 42",
          name: "calculator"
        }
      },
      %Variation{
        id: :with_thinking,
        description: "Assistant with thinking block",
        attributes: %{
          role: "assistant",
          content: "The answer is 42.",
          thinking: "Let me analyze this step by step. First I need to consider the input...",
          name: "Claude"
        }
      }
    ]
  end
end
