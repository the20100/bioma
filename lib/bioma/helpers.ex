defmodule Bioma.Helpers do
  @moduledoc """
  Shared utility functions for Bioma.
  """

  @doc """
  Merges CSS class names, filtering out nil and empty values.

  ## Examples

      iex> cn(["bg-primary", nil, "text-white", ""])
      "bg-primary text-white"

      iex> cn(["base-class", some_condition && "conditional-class"])
      "base-class conditional-class"
  """
  def cn(classes) when is_list(classes) do
    classes
    |> List.flatten()
    |> Enum.reject(&(is_nil(&1) or &1 == "" or &1 == false))
    |> Enum.join(" ")
    |> String.trim()
  end

  def cn(class) when is_binary(class), do: class
  def cn(nil), do: ""
end
