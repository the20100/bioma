defmodule Storybook.Atoms.Textarea do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.Textarea.textarea/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default textarea",
        attributes: %{placeholder: "Type your message here..."}
      },
      %Variation{
        id: :with_value,
        description: "With initial value",
        attributes: %{value: "Hello, this is some initial content.", rows: 4}
      },
      %Variation{
        id: :disabled,
        description: "Disabled textarea",
        attributes: %{disabled: true, placeholder: "Cannot type here"}
      }
    ]
  end
end
