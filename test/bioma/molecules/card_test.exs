defmodule Bioma.Molecules.CardTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  alias Bioma.Molecules.Card

  describe "card/1" do
    test "renders a card container" do
      html = render_component(&Card.card/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Card content" end}]
      })

      assert html =~ "<div"
      assert html =~ "Card content"
      assert html =~ "rounded-lg"
      assert html =~ "border"
      assert html =~ "bg-card"
      assert html =~ "shadow-sm"
    end

    test "applies additional CSS classes" do
      html = render_component(&Card.card/1, %{
        class: "max-w-md",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Content" end}]
      })

      assert html =~ "max-w-md"
    end
  end

  describe "card_header/1" do
    test "renders a card header" do
      html = render_component(&Card.card_header/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Header" end}]
      })

      assert html =~ "Header"
      assert html =~ "p-6"
      assert html =~ "flex flex-col"
    end
  end

  describe "card_title/1" do
    test "renders a card title as h3" do
      html = render_component(&Card.card_title/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "My Title" end}]
      })

      assert html =~ "<h3"
      assert html =~ "My Title"
      assert html =~ "text-2xl"
      assert html =~ "font-semibold"
    end
  end

  describe "card_description/1" do
    test "renders a card description" do
      html = render_component(&Card.card_description/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Description text" end}]
      })

      assert html =~ "<p"
      assert html =~ "Description text"
      assert html =~ "text-muted-foreground"
    end
  end

  describe "card_content/1" do
    test "renders card content" do
      html = render_component(&Card.card_content/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Body content" end}]
      })

      assert html =~ "Body content"
      assert html =~ "p-6"
    end
  end

  describe "card_footer/1" do
    test "renders a card footer" do
      html = render_component(&Card.card_footer/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Footer" end}]
      })

      assert html =~ "Footer"
      assert html =~ "flex items-center"
    end
  end
end
