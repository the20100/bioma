defmodule Storybook.Root do
  use PhoenixStorybook.Index

  def folder_name, do: "Bioma"
  def folder_icon, do: {:fa, "cubes", :thin}
  def folder_open?, do: true
end
