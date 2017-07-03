defmodule Askbywho.PageController do
  use Askbywho.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
