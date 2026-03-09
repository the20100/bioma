defmodule Storybook.Atoms.InputOTP do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Atoms.InputOTP.input_otp/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "6-digit OTP input",
        attributes: %{id: "demo-otp", length: 6, name: "code"}
      },
      %Variation{
        id: :four_digit,
        description: "4-digit OTP input",
        attributes: %{id: "demo-otp-4", length: 4, name: "pin"}
      },
      %Variation{
        id: :with_value,
        description: "Pre-filled OTP",
        attributes: %{id: "demo-otp-filled", length: 6, name: "code", value: "123456"}
      }
    ]
  end
end
