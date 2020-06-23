defmodule SlumberingmageWeb.Router do
  use SlumberingmageWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SlumberingmageWeb do
    pipe_through :browser

    resources "/articles", ArticleController, only: [:index]
    resources "/article", ArticleController, only: [:show]
    resources "/posts", PostController
    resources "/users", UserController, only: [:index, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/", ArticleController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SlumberingmageWeb do
  #   pipe_through :api
  # end
end
