defmodule Askbywho.PageController do
  require Logger
  @moduledoc """
   Add documentation
  """

  use Askbywho.Web, :controller
  alias Askbywho.Email

  plug :put_layout, "site.html"

  def index(conn, _params) do
    changeset = Email.changeset(%Email{})
    render(conn, "index.html", changeset: changeset, action: page_path(conn, :create), name_brands: [])
  end

  def create(conn, %{"email" => email_params}) do
    email_object = Repo.get_by(Email, email: email_params["email"] || "") || %Email{}
    email = email_object |> Repo.preload([:brands])
    old_name_brands = %{"name_brands" => email.brands |> Enum.map(fn(x) -> x.name end)}
    email_params = Map.merge(email_params, old_name_brands, fn _k, v1, v2 -> v1 ++ v2 end)

    result =
      email
      |> Email.changeset(email_params)
      |> Repo.insert_or_update

    case result do
      {:ok, email} -> # Inserted or updated with success
        redirect(conn, to: page_path(conn, :share, email.id))
      {:error, changeset} -> # Something went wrong
        brands = email_params["name_brands"] || []
        name_brands = brands |> Enum.map(&{&1, &1})
        render(conn, "index.html", changeset: changeset, action: page_path(conn, :create), name_brands: name_brands)
    end
  end

  def share(conn, %{"id" => id}) do
    email = Repo.get!(Email, id)
    brands = Repo.preload(email, :brands).brands
    render(conn, "share.html", email: email, brands: brands)
  end

end
