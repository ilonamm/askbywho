defmodule Askbywho.EmailTest do
  use Askbywho.ModelCase

  alias Askbywho.Email

  @valid_attrs %{email: "some@email.com", name: "Some Content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Email.changeset(%Email{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Email.changeset(%Email{}, @invalid_attrs)
    refute changeset.valid?
  end
end
