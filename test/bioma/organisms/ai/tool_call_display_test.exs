defmodule Bioma.Organisms.AI.ToolCallDisplayTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  alias Bioma.Organisms.AI.ToolCallDisplay

  describe "tool_call_display/1" do
    test "renders pending tool call" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "search_database",
        status: "pending"
      })

      assert html =~ "search_database"
      assert html =~ "font-mono"
      assert html =~ "border-border"
    end

    test "renders running tool call with spinner" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "execute_code",
        status: "running"
      })

      assert html =~ "execute_code"
      assert html =~ "animate-spin"
      assert html =~ "border-ai-running"
    end

    test "renders successful tool call" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "read_file",
        status: "success",
        duration_ms: 125
      })

      assert html =~ "read_file"
      assert html =~ "border-ai-success"
      assert html =~ "125ms"
    end

    test "renders error tool call" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "write_file",
        status: "error",
        error: "Permission denied"
      })

      assert html =~ "write_file"
      assert html =~ "border-ai-error"
      assert html =~ "Permission denied"
      assert html =~ "bg-ai-error"
    end

    test "renders with parameters section" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "search",
        status: "pending",
        parameters: "query: elixir genserver"
      })

      assert html =~ "Parameters"
      assert html =~ "query: elixir genserver"
    end

    test "renders with result section" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "read_file",
        status: "success",
        result: "content: hello world"
      })

      assert html =~ "Result"
      assert html =~ "content: hello world"
    end

    test "formats duration in milliseconds" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "tool",
        status: "success",
        duration_ms: 42
      })

      assert html =~ "42ms"
    end

    test "formats duration in seconds for >= 1000ms" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "tool",
        status: "success",
        duration_ms: 2500
      })

      assert html =~ "2.5s"
    end

    test "does not show parameters section when nil" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "tool",
        status: "pending"
      })

      refute html =~ "Parameters"
    end

    test "does not show result section when nil" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "tool",
        status: "pending"
      })

      refute html =~ "Result"
    end

    test "applies additional CSS classes" do
      html = render_component(&ToolCallDisplay.tool_call_display/1, %{
        name: "tool",
        status: "pending",
        class: "my-custom-class"
      })

      assert html =~ "my-custom-class"
    end
  end
end
