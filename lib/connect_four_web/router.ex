defmodule ConnectFourWeb.Router do
  use ConnectFourWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ConnectFourWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ConnectFourWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/register", UserController, :new
    post "/users", UserController, :create
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/", ConnectFourWeb do
    pipe_through [:browser, :require_login]
    get "/lobby", GameController, :index, as: :lobby
    resources "/games", GameController, only: [:new, :create, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", ConnectFourWeb do
  #   pipe_through :api
  # end
end
