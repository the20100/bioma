defmodule DevWeb.Router do
  use Phoenix.Router
  import Phoenix.LiveView.Router
  import PhoenixStorybook.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_live do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DevWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/" do
    storybook_assets()
  end

  scope "/", DevWeb do
    pipe_through :browser_live

    live "/", ThemeLive, :index
  end

  scope "/", DevWeb do
    pipe_through :browser

    live_storybook("/storybook",
      backend_module: DevWeb.Storybook,
      session_name: :live_storybook
    )
  end
end
