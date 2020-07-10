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

  pipeline :auth do
    plug Slumberingmage.UserManager.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  # Maybe logged in scope
  scope "/", SlumberingmageWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
    get "/articles", ArticleController, :index
    get "/article/:slug", ArticleController, :show
  end

  # Definitely logged in scope
  scope "/", SlumberingmageWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/admin", AdminController, :index
    get "/account", AccountController, :show
    get "/account/edit", AccountController, :edit
    resources "/users", UserController
    resources "/comments", CommentController
    resources "/posts", PostController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SlumberingmageWeb do
  #   pipe_through :api
  # end
end
