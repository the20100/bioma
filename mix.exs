defmodule Bioma.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/the20100/bioma"

  def project do
    [
      app: :bioma,
      version: @version,
      elixir: "~> 1.17",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      name: "Bioma",
      description: "A composable Phoenix LiveView component library for AI agentic platforms",
      package: package(),
      docs: docs(),
      source_url: @source_url,
      homepage_url: @source_url,
      listeners: [Phoenix.CodeReloader]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ] ++ application_mod(Mix.env())
  end

  defp elixirc_paths(:dev), do: ["lib", "dev"]
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp application_mod(:dev), do: [mod: {DevApp, []}]
  defp application_mod(_), do: []

  defp deps do
    [
      # Core (shipped with library)
      {:phoenix, "~> 1.7"},
      {:phoenix_live_view, "~> 1.1"},
      {:phoenix_html, "~> 4.2"},
      {:heroicons, "~> 0.5", optional: true},
      {:mdex, "~> 0.4", optional: true},
      {:jason, "~> 1.4"},

      # Dev only
      {:phoenix_storybook, "~> 0.6", only: :dev},
      {:phoenix_live_reload, "~> 1.5", only: :dev},
      {:esbuild, "~> 0.8", only: :dev, runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2", only: :dev, runtime: Mix.env() == :dev},
      {:bandit, "~> 1.0", only: :dev},

      # Test
      {:floki, "~> 0.37", only: :test},

      # Docs
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      dev: ["phx.server"],
      "assets.setup": [
        "tailwind.install --if-missing",
        "esbuild.install --if-missing"
      ],
      "assets.build": [
        "tailwind bioma",
        "esbuild bioma"
      ]
    ]
  end

  defp package do
    [
      maintainers: ["the20100"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
      files: ~w(lib assets/js/hooks priv .formatter.exs mix.exs README.md LICENSE.md CHANGELOG.md)
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "CHANGELOG.md"],
      source_ref: "v#{@version}",
      groups_for_modules: [
        Atoms: ~r/Bioma\.Atoms\./,
        Molecules: ~r/Bioma\.Molecules\./,
        "AI Organisms": ~r/Bioma\.Organisms\.AI\./,
        "Layout Organisms": ~r/Bioma\.Organisms\.Layout\./
      ]
    ]
  end
end
