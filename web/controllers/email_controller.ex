defmodule Askbywho.EmailController do
  use Askbywho.Web, :controller

  alias Askbywho.Email
  

  #plug :scrub_params, "email" when action in [:create, :update]

  def index(conn, _params) do
    emails = Repo.all(Email)
    render(conn, "index.html", emails: emails)
  end

  def new(conn, _params) do
    changeset = Email.changeset(%Email{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"email" => email_params}) do
    result =
      case Repo.get_by(Email, email: (email_params["email"] || "")) do
        nil   -> %Email{} # Email not found, so build one
        email -> email    # Email already exists, let's use it
      end
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
      |> Repo.preload(:brands)
    changeset = Email.changeset(email)
    render(conn, "edit.html", email: email, changeset: changeset)
  end

  def update(conn, %{"id" => id, "email" => email_params}) do
    email = Repo.get!(Email, id)
      |> Repo.preload(:brands)
    changeset = Email.changeset(email, email_params)

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
