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

  pipeline :guardian do
    plug SlumberingmageWeb.Authentication.Pipeline
  end

  pipeline :browser_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", SlumberingmageWeb do
    pipe_through [:browser]


    resources "/articles", ArticleController, only: [:index]
    resources "/article", ArticleController, only: [:show]
    resources "/posts", PostController
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/profile", ProfileController, only: [:show], singleton: true

    get "/", PageController, :index

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    get "/login", SessionController, :new

  end

  # Other scopes may use custom stacks.
  # scope "/api", SlumberingmageWeb do
  #   pipe_through :api
  # end
end
