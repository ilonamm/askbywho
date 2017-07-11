defmodule Askbywho.PageView do
  use Askbywho.Web, :view

  alias Askbywho.Repo
  alias Askbywho.Email
  alias Askbywho.Brand

  def count_emails do
    Repo.aggregate Email, :count, :id
  end

  def count_brands_message([a]) do
    "1 brand"
  end

  def count_brands_message(list) do
    count = length list
    "#{count} brands"
  end

  def count_brands do
    Repo.aggregate Brand, :count, :id
  end

  def count_nominations do
    {_status, result} = Ecto.Adapters.SQL.query(
      Repo, "select count(1) from brands_emails"
    )
    List.flatten(result.rows) |> Enum.at(0)
  end

  def count_nominations(brand_id) do
    {_status, result} = Ecto.Adapters.SQL.query(
      Repo, "select count(1) from brands_emails where brand_id = $1", [brand_id]
    )
    List.flatten(result.rows) |> Enum.at(0)
  end

  def percent_nominations(brand_id) do
    count_nominations(brand_id) / 1000
  end

  def to_go(brand_id) do
    result = 1000 - count_nominations(brand_id)
    case result do
      x when (x > 0) -> "#{x} to go!"
      _ -> ""
    end
  end

end
