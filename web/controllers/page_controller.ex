defmodule Askbywho.PageController do
  use Askbywho.Web, :controller
  alias Askbywho.Email

  plug :put_layout, "site.html"

  def index(conn, _params) do
    changeset = Email.changeset(%Email{})
    render(conn, "index.html", changeset: changeset, action: page_path(conn, :create))
  end

  def create(conn, %{"email" => email_params}) do
    result =
      case Repo.get_by(Email, email: email_params["email"]) do
        nil  -> %Email{}  # Email not found, we build one
        email -> email    # Email exists, let's use it
      end
      |> Repo.preload([:brands])
      |> Email.changeset(email_params)
      |> Repo.insert_or_update
    case result do
      {:ok, _email}        -> # Inserted or updated with success
        conn
        |> put_flash(:info, "Email created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} -> # Something went wrong
        render(conn, "index.html", changeset: changeset, action: page_path(conn, :create))
    end
  end

end
