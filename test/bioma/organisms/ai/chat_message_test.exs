defmodule Bioma.Organisms.AI.ChatMessageTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  alias Bioma.Organisms.AI.ChatMessage

  describe "chat_message/1 with user role" do
    test "renders user message right-aligned" do
      html = render_component(&ChatMessage.chat_message/1, %{
        role: "user",
        content: "Hello, how are you?"
      })

      assert html =~ "Hello, how are you?"
      assert html =~ "items-end"
      assert html =~ "bg-ai-user"
      assert html =~ "ml-auto"
    end

    test "renders user message with name and avatar initial" do
      html = render_component(&ChatMessage.chat_message/1, %{
        role: "user",
        content: "Test message",
        name: "Vincent"
      })

      assert html =~ "Vincent"
      assert html =~ "V"
    end

    test "renders user message with timestamp" do
      html = render_component(&ChatMessage.chat_message/1, %{
        role: "user",
        content: "Test",
        timestamp: "2:34 PM"
      })

      assert html =~ "2:34 PM"
    end
  end

  describe "chat_message/1 with assistant role" do
    test "renders assistant message left-aligned" do
      html = render_component(&ChatMessage.chat_message/1, %{
        role: "assistant",
        content: "I can help with that!"
      })

      assert html =~ "I can help with that!"
      assert html =~ "items-start"
      assert html =~ "bg-ai-assistant"
    end

    test "renders assistant message with name" do
      html = render_component(&ChatMessage.chat_message/1, %{
        role: "assistant",
        content: "Response",
        name: "Claude"
      })

      assert html =~ "Claude"
      assert html =~ "C"
    end

    test "renders thinking block when provided" do
      html = render_component(&ChatMessage.chat_message/1, %{
        role: "assistant",
        content: "The answer is 42.",
        thinking: "Let me think step by step..."
      })

      assert html =~ "Show thinking"
      assert html =~ "Let me think step by step..."
      assert html =~ "bg-ai-thinking"
      assert html =~ "The answer is 42."
    end

    test "does not render thinking block when nil" do
      html = render_component(&ChatMessage.chat_message/1, %{
        role: "assistant",
        content: "Simple response"
      })

      refute html =~ "Show thinking"
      refute html =~ "bg-ai-thinking"
    end
  end

  describe "chat_message/1 with system role" do
    test "renders system message center-aligned with italic" do
      html = render_component(&ChatMessage.chat_message/1, %{
        role: "system",
        content: "You are a helpful assistant."
      })

      assert html =~ "You are a helpful assistant."
      assert html =~ "items-center"
      assert html =~ "bg-ai-system"
      assert html =~ "italic"
    end
  end

  describe "chat_message/1 with tool role" do
    test "renders tool message with monospace font" do
      html = render_component(&ChatMessage.chat_message/1, %{
        role: "tool",
        content: "result: 42",
        name: "calculator"
      })

      assert html =~ "result: 42"
      assert html =~ "calculator"
      assert html =~ "bg-ai-tool"
      assert html =~ "font-mono"
    end
  end

  describe "chat_message/1 with custom class" do
    test "applies additional CSS classes" do
      html = render_component(&ChatMessage.chat_message/1, %{
        role: "user",
        content: "Test",
        class: "my-custom-class"
      })

      assert html =~ "my-custom-class"
    end
  end
end
