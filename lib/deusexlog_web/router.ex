defmodule DeusexlogWeb.Router do
  use DeusexlogWeb, :router

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
    plug Deusexlog.UserManager.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :guardian do
    plug DeusexlogWeb.Authentication.Pipeline
  end

  # Maybe logged in scope
  scope "/", DeusexlogWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
    get "/articles", ArticleController, :index
    get "/article/:slug", ArticleController, :show
  end

  # Definitely logged in scope
  scope "/", DeusexlogWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    # get "/admin", AdminController, :index
    get "/user", CurrentUserController, :show
    patch "/user/:id", CurrentUserController, :update
    put "/user/:id", CurrentUserController, :update
    get "/user/edit", CurrentUserController, :edit
    resources "/users", UserController
    resources "/comments", CommentController
    resources "/posts", PostController
  end

  scope "/", DeusexlogWeb do
    pipe_through [:browser, :guardian]

    get "/admin", AdminController, :index

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    get "/login", SessionController, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", DeusexlogWeb do
  #   pipe_through :api
  # end
end
