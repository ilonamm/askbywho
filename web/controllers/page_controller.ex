defmodule Askbywho.PageController do
  @moduledoc """
   Add documentation
  """

  use Askbywho.Web, :controller
  alias Askbywho.Email

  plug :put_layout, "site.html"

  def index(conn, _params) do
    changeset = Email.changeset(%Email{})
    render(conn, "index.html", changeset: changeset, action: page_path(conn, :create))
  end

  def create(conn, %{"email" => email_params}) do
    result =
      case Repo.get_by(Email, email: email_params["email"] || "") do
        nil   -> %Email{} # Email not found, so build one
        email -> email    # Email already exists, let's use it
      end
      |> Repo.preload([:brands])
      |> Email.changeset(email_params)
      |> Repo.insert_or_update

    case result do
      {:ok, email} -> # Inserted or updated with success
        redirect(conn, to: page_path(conn, :share, email.id))
      {:error, changeset} -> # Something went wrong
        render(conn, "index.html", changeset: changeset, action: page_path(conn, :create))
    end
  end

  def share(conn, %{"id" => id}) do
    email = Repo.get!(Email, id)
    brands = Repo.preload(email, :brands).brands
    render(conn, "share.html", email: email, brands: brands)
  end
end
