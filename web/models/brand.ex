defmodule Askbywho.Brand do
  use Askbywho.Web, :model
  alias Askbywho.Email
  use Filterable.Phoenix.Model
  import Ecto.Query

  filterable do
    orderable [:name]

    @options param: :q
    filter search(query, value, _conn) do
      query |> where([u], ilike(u.name, ^"%#{value}%"))
    end
  end

  schema "brands" do
    field :name, :string
    many_to_many :emails, Email, join_through: "brands_emails"
    timestamps()
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
