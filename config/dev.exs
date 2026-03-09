import Config

config :bioma, DevWeb.Endpoint,
  adapter: Bandit.PhoenixAdapter,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "dev-secret-key-base-that-is-at-least-64-bytes-long-for-development-only!!",
  pubsub_server: Bioma.PubSub,
  live_view: [signing_salt: "GJqrXcAWBsW1mw3H"],
  watchers: [
    esbuild:
      {Esbuild, :install_and_run,
       [:bioma, ~w(--sourcemap=inline --watch)]},
    esbuild:
      {Esbuild, :install_and_run,
       [:storybook, ~w(--sourcemap=inline --watch)]},
    tailwind:
      {Tailwind, :install_and_run,
       [:bioma, ~w(--watch)]},
    tailwind:
      {Tailwind, :install_and_run,
       [:storybook, ~w(--watch)]}
  ],
  live_reload: [
    debounce: 500,
    patterns: [
      ~r"lib/.*(ex|heex)$",
      ~r"dev/.*(ex|heex)$",
      ~r"storybook/.*(exs)$",
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$"
    ]
  ]

config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
