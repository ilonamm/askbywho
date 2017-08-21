defmodule Askbywho.PageView do
  @moduledoc """
   Add documentation
  """

  use Askbywho.Web, :view

  require Logger
  alias Askbywho.Repo
  alias Askbywho.Email
  alias Askbywho.Brand
  import Askbywho.Gettext


  def count_emails do
    Repo.aggregate Email, :count, :id
  end

  def count_brands_message([_]) do
    gettext "1 brand"
  end

  def count_brands_message(list) do
    count = length list
    text = ngettext " brand", " brands", count
    Integer.to_string(count) <> text
  end

  def count_brands do
    Repo.aggregate Brand, :count, :id
  end

  def count_nominations do
    {_status, result} = Ecto.Adapters.SQL.query(
      Repo, "select count(1) from brands_emails"
    )
    flattened = List.flatten(result.rows)
    Enum.at(flattened, 0)
  end

  def count_nominations(brand_id) do
    {_status, result} = Ecto.Adapters.SQL.query(
      Repo, "select count(1) from brands_emails where brand_id = $1", [brand_id]
    )
    flattened = List.flatten(result.rows)
    Enum.at(flattened, 0)
  end

  def percent_nominations(brand_id) do
    count_nominations(brand_id) / 1000 * 100
  end

  def to_go(brand_id) do
    result = 1000 - count_nominations(brand_id)
    case result do
      x when (x > 0) -> "#{x} to go!"
      _ -> ""
    end
  end

  def render("scripts.html", _assigns) do
    ~s{<script>require("web/static/js/pages")</script>}
    |> raw
  end

  def on_qa do
    Logger.info fn ->
      "Environment variable is_qa is #{inspect System.get_env("is_qa")}"
    end
    System.get_env("is_qa") == "yes"
  end

  def add_nominate do
    gettext "Nominate"
  end

  def done_choosing do
    gettext "Send"
  end

  def add_autocomplete_placeholder do
    gettext "Click to write/choose brands"
  end

  def add_languages do
    menu = %{"en" => "in english", "fi" => "suomeksi", "pt-BR" => "em português"}
    Map.delete(menu, Gettext.get_locale(Askbywho.Gettext))
  end
end
