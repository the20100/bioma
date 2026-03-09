import Config

if config_env() == :dev do
  config :esbuild,
    version: "0.24.2",
    bioma: [
      args: ~w(
        js/app.js
        --bundle
        --target=es2020
        --outdir=../priv/static/assets
        --external:/fonts/*
        --external:/images/*
      ),
      cd: Path.expand("../assets", __DIR__),
      env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
    ],
    storybook: [
      args: ~w(
        js/storybook.js
        --bundle
        --target=es2020
        --outdir=../priv/static/assets
        --external:/fonts/*
        --external:/images/*
      ),
      cd: Path.expand("../assets", __DIR__),
      env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
    ]

  config :tailwind,
    version: "4.1.3",
    bioma: [
      args: ~w(
        --input=css/app.css
        --output=../priv/static/assets/app.css
      ),
      cd: Path.expand("../assets", __DIR__)
    ],
    storybook: [
      args: ~w(
        --input=css/storybook.css
        --output=../priv/static/assets/storybook.css
      ),
      cd: Path.expand("../assets", __DIR__)
    ]
end

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
