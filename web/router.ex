defmodule CedaRealty.Router do
  use CedaRealty.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CedaRealty do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/blog", PostController, :index

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/admin", CedaRealty.Admin, as: :admin do
    pipe_through :browser # Use the default browser stack

    resources "/pages", PageController
    resources "/pictures", PictureController, except: [:edit, :update]
    resources "/posts", PostController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CedaRealty do
  #   pipe_through :api
  # end
end
