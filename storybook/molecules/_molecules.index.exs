defmodule Storybook.Molecules do
  use PhoenixStorybook.Index

  def folder_name, do: "Molecules"
  def folder_icon, do: {:fa, "puzzle-piece", :thin}
  def folder_open?, do: true
end
