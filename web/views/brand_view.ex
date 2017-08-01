defmodule Askbywho.BrandView do
  use Askbywho.Web, :view
  import Scrivener.HTML

  def render("index.json", %{brands: brands, page: page}) do
    %{
      total_count: page.total_entries,
      brands: Enum.map(brands, &brand_json/1)
    }
  end

  def brand_json(brand) do
    %{
      id: brand.name,
      name: brand.name,
      text: brand.name
    }
  end
end
