defmodule Bioma.Atoms.ButtonTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  alias Bioma.Atoms.Button

  describe "button/1" do
    test "renders a button with default variant and size" do
      html = render_component(&Button.button/1, %{inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Click me" end}]})

      assert html =~ "<button"
      assert html =~ "Click me"
      assert html =~ "bg-primary"
      assert html =~ "h-10 px-4 py-2"
    end

    test "renders with destructive variant" do
      html = render_component(&Button.button/1, %{
        variant: "destructive",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Delete" end}]
      })

      assert html =~ "bg-destructive"
      assert html =~ "Delete"
    end

    test "renders with outline variant" do
      html = render_component(&Button.button/1, %{
        variant: "outline",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Outline" end}]
      })

      assert html =~ "border"
      assert html =~ "bg-background"
    end

    test "renders with secondary variant" do
      html = render_component(&Button.button/1, %{
        variant: "secondary",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Secondary" end}]
      })

      assert html =~ "bg-secondary"
    end

    test "renders with ghost variant" do
      html = render_component(&Button.button/1, %{
        variant: "ghost",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Ghost" end}]
      })

      assert html =~ "hover:bg-accent"
      refute html =~ "bg-primary"
    end

    test "renders with link variant" do
      html = render_component(&Button.button/1, %{
        variant: "link",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Link" end}]
      })

      assert html =~ "underline-offset-4"
    end

    test "renders with sm size" do
      html = render_component(&Button.button/1, %{
        size: "sm",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Small" end}]
      })

      assert html =~ "h-9"
      assert html =~ "px-3"
    end

    test "renders with lg size" do
      html = render_component(&Button.button/1, %{
        size: "lg",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Large" end}]
      })

      assert html =~ "h-11"
      assert html =~ "px-8"
    end

    test "renders with icon size" do
      html = render_component(&Button.button/1, %{
        size: "icon",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "X" end}]
      })

      assert html =~ "h-10 w-10"
    end

    test "renders as disabled" do
      html = render_component(&Button.button/1, %{
        disabled: true,
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Disabled" end}]
      })

      assert html =~ "disabled"
    end

    test "applies additional CSS classes" do
      html = render_component(&Button.button/1, %{
        class: "mt-4 w-full",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Full Width" end}]
      })

      assert html =~ "mt-4 w-full"
    end
  end
end
