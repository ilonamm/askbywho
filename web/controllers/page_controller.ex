defmodule Askbywho.PageController do
  @moduledoc """
   Add documentation
  """

  use Askbywho.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
