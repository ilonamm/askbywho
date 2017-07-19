defmodule Askbywho.PageControllerTest do
  use Askbywho.ConnCase

  @valid_attrs %{email: "some@email.com", name: "Some Content"}
  @invalid_attrs %{}

  test "renders form for new subscriber", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Ssh! Welcome to our secret beta!"
  end
end
