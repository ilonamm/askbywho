defmodule Askbywho.PageController do
  require Logger
  @moduledoc """
   Add documentation
  """

  use Askbywho.Web, :controller
  alias Askbywho.Email
  alias Askbywho.Brand

  plug :put_layout, "site.html"

  def index(conn, _params) do
    brands = Repo.all(Brand)
    name_brands = brands |> Enum.map(&{&1.name, &1.name})
    changeset = Email.changeset(%Email{})
    render(conn, "index.html", changeset: changeset, action: page_path(conn, :create), name_brands: name_brands)
  end

  def create(conn, %{"email" => email_params}) do
    email = Repo.get_by(Email, email: email_params["email"] || "") || %Email{}

    result =
      email
      |> Repo.preload([:brands])
      |> Email.changeset(email_params)
      |> Repo.insert_or_update

    case result do
      {:ok, email} -> # Inserted or updated with success
        redirect(conn, to: page_path(conn, :share, email.id))
      {:error, changeset} -> # Something went wrong
        brands = Repo.all(Brand)
        name_brands = brands |> Enum.map(&{&1.name, &1.name})
        render(conn, "index.html", changeset: changeset, action: page_path(conn, :create), name_brands: name_brands)
    end
  end

  def share(conn, %{"id" => id}) do
    email = Repo.get!(Email, id)
    brands = Repo.preload(email, :brands).brands
    render(conn, "share.html", email: email, brands: brands)
  end
end
