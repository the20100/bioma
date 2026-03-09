defmodule Bioma.Molecules.DropdownMenuTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  alias Bioma.Molecules.DropdownMenu

  describe "dropdown/1" do
    test "renders a dropdown with trigger and content slots" do
      html = render_component(&DropdownMenu.dropdown/1, %{
        id: "test-dropdown",
        trigger: [%{__slot__: :trigger, inner_block: fn _, _ -> "Open" end}],
        content: [%{__slot__: :content, inner_block: fn _, _ -> "Menu items" end}]
      })

      assert html =~ ~s(id="test-dropdown")
      assert html =~ "Open"
      assert html =~ "Menu items"
      assert html =~ ~s(role="menu")
      assert html =~ "hidden"
    end

    test "renders with bottom-start position by default" do
      html = render_component(&DropdownMenu.dropdown/1, %{
        id: "pos-dropdown",
        trigger: [%{__slot__: :trigger, inner_block: fn _, _ -> "Trigger" end}],
        content: [%{__slot__: :content, inner_block: fn _, _ -> "Content" end}]
      })

      assert html =~ "top-full"
      assert html =~ "left-0"
    end

    test "renders with bottom-end position" do
      html = render_component(&DropdownMenu.dropdown/1, %{
        id: "end-dropdown",
        position: "bottom-end",
        trigger: [%{__slot__: :trigger, inner_block: fn _, _ -> "Trigger" end}],
        content: [%{__slot__: :content, inner_block: fn _, _ -> "Content" end}]
      })

      assert html =~ "right-0"
    end
  end

  describe "dropdown_item/1" do
    test "renders a menu item" do
      html = render_component(&DropdownMenu.dropdown_item/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Edit" end}]
      })

      assert html =~ "Edit"
      assert html =~ ~s(role="menuitem")
      assert html =~ "cursor-pointer"
    end

    test "renders a disabled menu item" do
      html = render_component(&DropdownMenu.dropdown_item/1, %{
        disabled: true,
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Disabled" end}]
      })

      assert html =~ "pointer-events-none"
      assert html =~ "opacity-50"
    end
  end

  describe "dropdown_separator/1" do
    test "renders a separator" do
      html = render_component(&DropdownMenu.dropdown_separator/1, %{})

      assert html =~ ~s(role="separator")
      assert html =~ "h-px"
      assert html =~ "bg-muted"
    end
  end

  describe "dropdown_label/1" do
    test "renders a label" do
      html = render_component(&DropdownMenu.dropdown_label/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Actions" end}]
      })

      assert html =~ "Actions"
      assert html =~ "font-semibold"
    end
  end
end
