import Config

# Runtime config for fly.io deployment (MIX_ENV=dev, but hosted)
if System.get_env("FLY_APP_NAME") || System.get_env("PHX_HOST") do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise "SECRET_KEY_BASE environment variable is missing"

  host = System.get_env("PHX_HOST") || "#{System.get_env("FLY_APP_NAME")}.fly.dev"
  port = String.to_integer(System.get_env("PORT") || "8080")

  config :bioma, DevWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [ip: {0, 0, 0, 0, 0, 0, 0, 0}, port: port],
    secret_key_base: secret_key_base,
    code_reloader: false,
    debug_errors: false,
    watchers: [],
    live_reload: [patterns: []]
end
