defmodule Askbywho.BrandControllerTest do
  use Askbywho.ConnCase

  alias Askbywho.Brand
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, brand_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing brands"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, brand_path(conn, :new)
    assert html_response(conn, 200) =~ "New brand"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, brand_path(conn, :create), brand: @valid_attrs
    assert redirected_to(conn) == brand_path(conn, :index)
    assert Repo.get_by(Brand, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, brand_path(conn, :create), brand: @invalid_attrs
    assert html_response(conn, 200) =~ "New brand"
  end

  test "shows chosen resource", %{conn: conn} do
    brand = Repo.insert! %Brand{}
    conn = get conn, brand_path(conn, :show, brand)
    assert html_response(conn, 200) =~ "Show brand"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, brand_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    brand = Repo.insert! %Brand{}
    conn = get conn, brand_path(conn, :edit, brand)
    assert html_response(conn, 200) =~ "Edit brand"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    brand = Repo.insert! %Brand{}
    conn = put conn, brand_path(conn, :update, brand), brand: @valid_attrs
    assert redirected_to(conn) == brand_path(conn, :show, brand)
    assert Repo.get_by(Brand, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    brand = Repo.insert! %Brand{}
    conn = put conn, brand_path(conn, :update, brand), brand: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit brand"
  end

  test "deletes chosen resource", %{conn: conn} do
    brand = Repo.insert! %Brand{}
    conn = delete conn, brand_path(conn, :delete, brand)
    assert redirected_to(conn) == brand_path(conn, :index)
    refute Repo.get(Brand, brand.id)
  end
end
