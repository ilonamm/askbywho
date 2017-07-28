defmodule Askbywho.EmailView do
  use Askbywho.Web, :view

  def render("scripts.html", _assigns) do
    ~s{<script>require("web/static/js/pages")</script>}
    |> raw
  end

end
