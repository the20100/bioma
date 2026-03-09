defmodule Bioma.Atoms.InputTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  alias Bioma.Atoms.Input

  describe "input/1" do
    test "renders a text input by default" do
      html = render_component(&Input.input/1, %{})

      assert html =~ "<input"
      assert html =~ ~s(type="text")
    end

    test "renders with specified type" do
      html = render_component(&Input.input/1, %{type: "email"})

      assert html =~ ~s(type="email")
    end

    test "renders with name attribute" do
      html = render_component(&Input.input/1, %{name: "username"})

      assert html =~ ~s(name="username")
    end

    test "renders with placeholder" do
      html = render_component(&Input.input/1, %{placeholder: "Enter text..."})

      assert html =~ ~s(placeholder="Enter text...")
    end

    test "renders as disabled" do
      html = render_component(&Input.input/1, %{disabled: true})

      assert html =~ "disabled"
    end

    test "renders with error messages" do
      html = render_component(&Input.input/1, %{errors: ["is required", "is too short"]})

      assert html =~ "border-destructive"
      assert html =~ "is required"
      assert html =~ "is too short"
      assert html =~ "text-destructive"
    end

    test "renders without errors when list is empty" do
      html = render_component(&Input.input/1, %{errors: []})

      refute html =~ "border-destructive"
    end

    test "applies additional CSS classes" do
      html = render_component(&Input.input/1, %{class: "max-w-sm"})

      assert html =~ "max-w-sm"
    end
  end
end
