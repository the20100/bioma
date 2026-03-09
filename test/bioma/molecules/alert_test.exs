defmodule Bioma.Molecules.AlertTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  alias Bioma.Molecules.Alert

  describe "alert/1" do
    test "renders a default alert" do
      html = render_component(&Alert.alert/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Alert content" end}]
      })

      assert html =~ "Alert content"
      assert html =~ "role=\"alert\""
      assert html =~ "rounded-lg"
      assert html =~ "border"
    end

    test "renders with destructive variant" do
      html = render_component(&Alert.alert/1, %{
        variant: "destructive",
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Error!" end}]
      })

      assert html =~ "border-destructive"
      assert html =~ "text-destructive"
    end
  end

  describe "alert_title/1" do
    test "renders alert title" do
      html = render_component(&Alert.alert_title/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Warning" end}]
      })

      assert html =~ "<h5"
      assert html =~ "Warning"
      assert html =~ "font-medium"
    end
  end

  describe "alert_description/1" do
    test "renders alert description" do
      html = render_component(&Alert.alert_description/1, %{
        inner_block: [%{__slot__: :inner_block, inner_block: fn _, _ -> "Something happened." end}]
      })

      assert html =~ "Something happened."
      assert html =~ "text-sm"
    end
  end
end
