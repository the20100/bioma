defmodule Bioma.Atoms.BadgeTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  alias Bioma.Atoms.Badge

  describe "badge/1" do
    test "renders a badge with default variant" do
      html = render_component(&Badge.badge/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Default" end}]
      })

      assert html =~ "<div"
      assert html =~ "Default"
      assert html =~ "bg-primary"
      assert html =~ "rounded-full"
    end

    test "renders with destructive variant" do
      html = render_component(&Badge.badge/1, %{
        variant: "destructive",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Error" end}]
      })

      assert html =~ "bg-destructive"
    end

    test "renders with secondary variant" do
      html = render_component(&Badge.badge/1, %{
        variant: "secondary",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Secondary" end}]
      })

      assert html =~ "bg-secondary"
    end

    test "renders with outline variant" do
      html = render_component(&Badge.badge/1, %{
        variant: "outline",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Outline" end}]
      })

      assert html =~ "text-foreground"
    end

    test "renders with success variant" do
      html = render_component(&Badge.badge/1, %{
        variant: "success",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Active" end}]
      })

      assert html =~ "bg-green-500/15"
    end

    test "renders with warning variant" do
      html = render_component(&Badge.badge/1, %{
        variant: "warning",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Warning" end}]
      })

      assert html =~ "bg-yellow-500/15"
    end

    test "applies additional CSS classes" do
      html = render_component(&Badge.badge/1, %{
        class: "ml-2",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Custom" end}]
      })

      assert html =~ "ml-2"
    end
  end
end
