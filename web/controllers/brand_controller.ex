defmodule Askbywho.BrandController do
  use Askbywho.Web, :controller
  use Filterable.Phoenix.Controller
  import Ecto.Query

  alias Askbywho.Brand

  plug :scrub_params, "brand" when action in [:create, :update]

  def index(conn, params) do
    with {:ok, query, filter_values} <- Brand.apply_filters(conn),
         page                       <- Repo.paginate(query, params),
     do: render(conn, :index, brands: page.entries, meta: filter_values, page: page)
  end

  def new(conn, _params) do
    changeset = Brand.changeset(%Brand{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"brand" => brand_params}) do
    changeset = Brand.changeset(%Brand{}, brand_params)

    case Repo.insert(changeset) do
      {:ok, _brand} ->
        conn
        |> put_flash(:info, "Brand created successfully.")
        |> redirect(to: brand_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    brand = Repo.get!(Brand, id)
    render(conn, "show.html", brand: brand)
  end

  def edit(conn, %{"id" => id}) do
    brand = Repo.get!(Brand, id)
    changeset = Brand.changeset(brand)
    render(conn, "edit.html", brand: brand, changeset: changeset)
  end

  def update(conn, %{"id" => id, "brand" => brand_params}) do
    brand = Repo.get!(Brand, id)
    changeset = Brand.changeset(brand, brand_params)

    case Repo.update(changeset) do
      {:ok, brand} ->
        conn
        |> put_flash(:info, "Brand updated successfully.")
        |> redirect(to: brand_path(conn, :show, brand))
      {:error, changeset} ->
        render(conn, "edit.html", brand: brand, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    brand = Repo.get!(Brand, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(brand)

    conn
    |> put_flash(:info, "Brand deleted successfully.")
    |> redirect(to: brand_path(conn, :index))
  end
end
