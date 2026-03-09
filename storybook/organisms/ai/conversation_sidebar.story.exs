defmodule Storybook.Organisms.AI.ConversationSidebar do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Organisms.AI.ConversationSidebar.conversation_sidebar/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Conversation sidebar",
        attributes: %{class: "h-[400px] w-[280px]"},
        slots: [
          ~s|<:header>|,
          ~s|  <div class="flex items-center justify-between">|,
          ~s|    <h3 class="font-semibold text-sm">Conversations</h3>|,
          ~s|    <button class="text-sm text-muted-foreground hover:text-foreground">+ New</button>|,
          ~s|  </div>|,
          ~s|</:header>|,
          ~s|<Bioma.Organisms.AI.ConversationSidebar.conversation_item id="conv-1" title="Elixir GenServer help" subtitle="How do I implement..." timestamp="2m ago" active={true} />|,
          ~s|<Bioma.Organisms.AI.ConversationSidebar.conversation_item id="conv-2" title="Phoenix deployment" subtitle="Best practices for..." timestamp="1h ago" />|,
          ~s|<Bioma.Organisms.AI.ConversationSidebar.conversation_item id="conv-3" title="Tailwind CSS setup" subtitle="Configure Tailwind..." timestamp="2d ago" />|
        ]
      }
    ]
  end
end
