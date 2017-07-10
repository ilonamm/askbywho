defmodule Askbywho.PageController do
  use Askbywho.Web, :controller

  plug :put_layout, "site.html"

  def index(conn, _params) do
    render conn, "index.html"
  end
end
