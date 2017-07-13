defmodule Askbywho.EmailController do
  use Askbywho.Web, :controller

  alias Askbywho.Email


  def index(conn, _params) do
    emails = Repo.all(Email)
    render(conn, "index.html", emails: emails)
  end

  def new(conn, _params) do
    changeset = Email.changeset(%Email{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"email" => email_params}) do
    address = (email_params["email"] || "")
    email   = Repo.get_by(Email, email: address) || %Email{}

    result  =
      email
      |> Repo.preload([:brands])
      |> Email.changeset(email_params)
      |> Repo.insert_or_update

    case result do
      {:ok, _email}       -> # Inserted or updated with success
        conn
        |> put_flash(:info, "Email created successfully.")
        |> redirect(to: email_path(conn, :index))
      {:error, changeset} -> # Something went wrong
        render(conn, "new.html", changeset: changeset)
    end
  end

#  def create(conn, %{"email" => email_params}) do
#    changeset = Email.changeset(%Email{}, email_params)
#
#    case Repo.insert(changeset) do
#      {:ok, _email} ->
#        conn
#        |> put_flash(:info, "Email created successfully.")
#        |> redirect(to: email_path(conn, :index))
#      {:error, changeset} ->
#        render(conn, "new.html", changeset: changeset)
#    end
#  end

  def show(conn, %{"id" => id}) do
    email = Repo.get!(Email, id)
    render(conn, "show.html", email: email)
  end

  def edit(conn, %{"id" => id}) do
    email = Repo.get!(Email, id)
    email_with_brands = Repo.preload(email, :brands)
    changeset = Email.changeset(email_with_brands)
    render(conn, "edit.html", email: email, changeset: changeset)
  end

  def update(conn, %{"id" => id, "email" => email_params}) do
    email = Repo.get!(Email, id)
    email_with_brands = Repo.preload(email, :brands)
    changeset = Email.changeset(email_with_brands, email_params)

    case Repo.update(changeset) do
      {:ok, email} ->
        conn
        |> put_flash(:info, "Email updated successfully.")
        |> redirect(to: email_path(conn, :show, email))
      {:error, changeset} ->
        render(conn, "edit.html", email: email, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    email = Repo.get!(Email, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(email)

    conn
    |> put_flash(:info, "Email deleted successfully.")
    |> redirect(to: email_path(conn, :index))
  end
end
