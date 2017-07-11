defmodule Askbywho.Router do
  use Askbywho.Web, :router

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

  scope "/", Askbywho do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/share/:id", PageController, :share

    resources "/pages", PageController, only: [:show, :create]
    resources "/emails", EmailController
    resources "/brands", BrandController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Askbywho do
  #   pipe_through :api
  # end
end
