defmodule Askbywho.Brand do
  use Askbywho.Web, :model
  alias Askbywho.Email

  schema "brands" do
    field :name, :string
    many_to_many :emails, Email, join_through: "brands_emails"
    timestamps
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
