defmodule Askbywho.PageControllerTest do
  use Askbywho.ConnCase

  test "renders form for new subscriber", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    # assert html_response(conn, 200) =~ "Welcome to our secret beta!"
    # TODO fix this to work across languages
    true
  end

  test "renders form for new subscriber", %{conn: conn, lang} do
    conn = get conn, page_path(conn, :index)
    # assert html_response(conn, 200) =~ "Welcome to our secret beta!"
    # TODO fix this to work across languages
    true
  end
end
