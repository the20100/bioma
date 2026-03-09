defmodule Bioma.HelpersTest do
  use ExUnit.Case, async: true

  import Bioma.Helpers

  describe "cn/1" do
    test "joins multiple class strings" do
      assert cn(["foo", "bar", "baz"]) == "foo bar baz"
    end

    test "filters out nil values" do
      assert cn(["foo", nil, "bar"]) == "foo bar"
    end

    test "filters out empty strings" do
      assert cn(["foo", "", "bar"]) == "foo bar"
    end

    test "filters out false values" do
      assert cn(["foo", false, "bar"]) == "foo bar"
    end

    test "handles conditional classes" do
      active = true
      disabled = false

      assert cn([
        "base",
        active && "active-class",
        disabled && "disabled-class"
      ]) == "base active-class"
    end

    test "handles nested lists" do
      assert cn(["foo", ["bar", "baz"]]) == "foo bar baz"
    end

    test "returns empty string for empty list" do
      assert cn([]) == ""
    end

    test "returns empty string for all-nil list" do
      assert cn([nil, nil, nil]) == ""
    end

    test "handles single class string" do
      assert cn(["single-class"]) == "single-class"
    end

    test "handles string input" do
      assert cn("foo bar") == "foo bar"
    end

    test "trims leading and trailing whitespace from result" do
      result = cn(["foo", "bar"])
      assert result == "foo bar"
      assert String.trim(result) == result
    end
  end
end
