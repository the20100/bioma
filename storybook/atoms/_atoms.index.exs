defmodule Storybook.Atoms do
  use PhoenixStorybook.Index

  def folder_name, do: "Atoms"
  def folder_icon, do: {:fa, "atom", :thin}
  def folder_open?, do: true
end
