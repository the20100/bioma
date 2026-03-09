defmodule Storybook.Organisms.AI.ChatThread do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.ChatThread.chat_thread/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Chat thread container",
        attributes: %{id: "demo-thread", class: "h-[300px] border rounded-lg"},
        slots: [
          "<p class=\"text-sm text-muted-foreground text-center py-8\">Messages will appear here</p>"
        ]
      }
    ]
  end
end
