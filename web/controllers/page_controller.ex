defmodule Askbywho.PageController do
  require Logger
  @moduledoc """
   Add documentation
  """

  use Askbywho.Web, :controller
  alias Askbywho.Email
  alias Askbywho.Brand
  import Ecto.Query
  import Ecto.Changeset

  plug :put_layout, "site.html"

  def index(conn, params) do
    changeset = Email.changeset(%Email{})
    render(conn, "index.html", changeset: changeset, action: page_path(conn, :create), name_brands: [])
  end

  def create(conn, %{"email" => email_params}) do
    # email_params is a map, "email" => %{"email" => "ilona.mooney@gmail.com", "name" => "Ilona", "name_brands" => ["le"]}

    # fetching location
    %{location: location, latitude: latitude, longitude: longitude} = look_up_location(conn)

    email_object = Repo.get_by(Email, email: email_params["email"] || "") || %Email{}
    email = email_object
      |> Repo.preload([:brands])
      |> Map.put(:latitude, latitude)
      |> Map.put(:longitude, longitude)
      |> Map.put(:location, location)

    # IO.puts("inspecting email: #{inspect email}")
    old_name_brands = %{"name_brands" => email.brands |> Enum.map(fn(x) -> x.name end)}

    email_params = Map.merge(email_params, old_name_brands, fn _k, v1, v2 -> v1 ++ v2 end)
    Map.put(email_params, "latitude", latitude)
    Map.put(email_params, "longitude", longitude)
    Map.put(email_params, "location", location)

    IO.puts("env is_qa is #{Application.get_env(:askbywho, :is_qa)}")
    IO.puts("inspect conn #{inspect conn}")

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

  defp look_up_location(conn) do
    {:ok, %GeoIP.Location{:city => city, :region_name => region,
      :country_name => country, :latitude => latitude, :longitude => longitude}} = GeoIP.lookup(conn)
      # this is for testing on localhost
      # if conn.remote_ip == {127, 0, 0, 1} do
      # GeoIP.lookup({Enum.random(1..255), Enum.random(1..255), Enum.random(1..255), Enum.random(1..254)})
      # else
      # end
      IO.puts("3. inspecting ip: #{inspect conn.remote_ip}")
      IO.puts("inspecting geoIP result: #{inspect GeoIP.lookup(conn)}")

    location = formatted_location(%{city: city, region: region, country: country})

    if latitude == 0 && longitude == 0 do
      %{location: "n/a", latitude: 0.0, longitude: 0.0}
    else
      %{location: location, latitude: latitude, longitude: longitude}
    end
  end

  defp formatted_location(%{city: nil, region: nil, country: nil}) do
    "n/a"
  end
  defp formatted_location(%{city: "", region: "", country: country}) do
    country
  end
  defp formatted_location(%{city: "", region: region, country: country}) do
    region <> ", " <> country
  end
  defp formatted_location(%{city: city, region: region, country: country}) do
    city <> ", " <> region <> ", " <> country
  end

end
