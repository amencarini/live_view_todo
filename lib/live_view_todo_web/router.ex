defmodule LiveViewTodoWeb.Router do
  use LiveViewTodoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveViewTodoWeb do
    pipe_through :browser

    live "/", TodoAppLive
    live "/:filter", TodoAppLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveViewTodoWeb do
  #   pipe_through :api
  # end
end
