defmodule Askbywho.PageControllerTest do
  use Askbywho.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Ssh! Welcome to our secret beta!"
  end
end
