defmodule Askbywho.Email do
  use Askbywho.Web, :model
  alias Askbywho.Repo
  alias Askbywho.Brand

  schema "emails" do
    field :name, :string
    field :email, :string
    many_to_many :brands, Brand, join_through: "brands_emails"
    timestamps
  end

  #@required_fields ~w(name email)
  #@optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
    |> put_assoc(:brands, parse_brands(params))
  end

  defp parse_brands(params)  do
    (params["brands"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(& &1 == "")
    |> Enum.map(&get_or_insert_brand/1)
  end

  defp get_or_insert_brand(name) do
    Repo.get_by(Brand, name: name) || maybe_insert_brand(name)
  end

  defp maybe_insert_brand(name) do
    %Brand{}
    |> Ecto.Changeset.change(name: name)
    |> Repo.insert
    |> case do
      {:ok, brand} -> brand
      {:error, _} -> Repo.get_by!(Brand, name: name)
    end
  end

end
