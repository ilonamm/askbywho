# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Askbywho.Repo.insert!(%Askbywho.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Askbywho.Repo.delete_all Askbywho.User

changeset = Askbywho.User.changeset(%Askbywho.User{}, %{
  name: "Test User",
  email: "abw-user@email.com",
  password: "secret",
  password_confirmation: "secret"
})
Askbywho.Repo.insert! changeset

%Email{}
  |> Email.changeset(%{"email" => "test1@email.com", "name" => "Test1", "name_brands" => ["American Eagle", "Asos"]})
  |> Repo.insert

%Email{}
  |> Email.changeset(%{"email" => "test2@email.com", "name" => "Test2", "name_brands" => ["American Eagle", "Asos", "American Apparel"]})
  |> Repo.insert

  %Email{}
    |> Email.changeset(%{"email" => "test3@email.com", "name" => "Test3", "name_brands" => ["Adidas", "Billabong", "Asics", "Boss", "Brooksfield", "Björn Borg", "Camper", "Change", "Aigle", "Puma", "Nike"]})
    |> Repo.insert
