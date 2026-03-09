defmodule DevWeb.Storybook do
  use PhoenixStorybook,
    otp_app: :bioma,
    content_path: Path.expand("../../storybook", __DIR__),
    css_path: "/assets/storybook.css",
    js_path: "/assets/storybook.js",
    title: "Bioma",
    sandbox_class: "bioma-sandbox"
end
