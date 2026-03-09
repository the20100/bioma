defmodule Storybook.Organisms.AI do
  use PhoenixStorybook.Index

  def folder_name, do: "AI / Agent"
  def folder_icon, do: {:fa, "robot", :thin}
  def folder_open?, do: true
end
