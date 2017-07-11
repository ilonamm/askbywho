defmodule Askbywho.PageControllerTest do
  use Askbywho.ConnCase

  alias Askbywho.Page

  @valid_attrs %{email: "some@email.com", name: "Some Content"}
  @invalid_attrs %{}

  test "renders form for new subscriber", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Ssh! Welcome to our secret beta!"
  end

  # test "create new subscriber and redirects when data is valid", %{conn: conn} do
  #   conn = get conn, page_path(conn, "/"), email: @valid_attrs
  #   assert redirected_to(conn) == email_path(conn, :show)
  #   assert Repo.get_by(Email, @valid_attrs)
  #   # assert Repo.get_by(Email, @valid_attrs)
  #   # assert redirected_to(conn) == email_path(conn, :show)
  #   # assert Repo.get_by(Email, @valid_attrs)
  #   # show email
  # end
end
