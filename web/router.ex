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
    plug Askbywho.Locale
    plug Coherence.Authentication.Session  # Add this
    plug Askbywhoplugs.RemoteIPPlug
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true  # Add this
  end

  pipeline :api do
    plug :accepts, ["json"]
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
    get "/nominate", PageController, :mobile_brands
    get "/share/:id", PageController, :share

    resources "/pages", PageController, only: [:show, :create]
  end

  scope "/", Askbywho do
    pipe_through :protected
    resources "/emails", EmailController
    resources "/brands", BrandController
    resources "/users", UserController
  end

  scope "/api", Askbywho do
    pipe_through :api
    scope "/v1" do
      resources "/brands", BrandController, only: [:index]
    end
  end
end
