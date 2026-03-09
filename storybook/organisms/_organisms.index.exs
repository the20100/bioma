defmodule Storybook.Organisms do
  use PhoenixStorybook.Index

  def folder_name, do: "Organisms"
  def folder_icon, do: {:fa, "layer-group", :thin}
  def folder_open?, do: true
end
