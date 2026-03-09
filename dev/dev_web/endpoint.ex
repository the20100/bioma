defmodule DevWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :bioma

  @session_options [
    store: :cookie,
    key: "_bioma_dev",
    signing_salt: "dev_signing_salt",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  @static_paths ~w(assets fonts images favicon.ico robots.txt)

  plug Plug.Static,
    at: "/",
    from: {:bioma, "priv/static"},
    gzip: false,
    only: @static_paths

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug DevWeb.Router

  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)
end
