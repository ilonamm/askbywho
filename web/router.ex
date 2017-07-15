defmodule Askbywho.Router do
  @moduledoc """
   Add documentation
  """

  use Askbywho.Web, :router
  use Coherence.Router         # Add this

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session  # Add this
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true  # Add this
  end

  # Add this block
  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  # Add this block
  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/", Askbywho do
    pipe_through :browser
    get "/", PageController, :index
    get "/share/:id", PageController, :share

    resources "/pages", PageController, only: [:show, :create]
  end

  scope "/", Askbywho do
    pipe_through :protected
    resources "/emails", EmailController
    resources "/brands", BrandController
    resources "/users", UserController
  end
end
