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

alias Askbywho.Repo
alias Askbywho.Brand
alias Askbywho.User
alias Askbywho.Email

Repo.delete_all User
Repo.delete_all Email
Repo.delete_all Brand

changeset = User.changeset(%User{}, %{
  name: "Test User",
  email: "abw-user@email.com",
  password: "secret",
  password_confirmation: "secret"
})
Repo.insert! changeset

%Email{}
  |> Email.changeset(%{"email" => "test1@email.com", "name" => "Test1",
  "name_brands" => ["American Eagle", "Asos"]})
  |> Repo.insert

%Email{}
  |> Email.changeset(%{"email" => "test2@email.com", "name" => "Test2",
  "name_brands" => ["American Eagle", "Asos", "American Apparel"]})
  |> Repo.insert

%Email{}
  |> Email.changeset(%{"email" => "test3@email.com", "name" => "Test3",
  "name_brands" => ["Adidas", "Billabong", "Asics", "Boss", "Brooksfield",
  "Björn Borg", "Camper", "Change", "Aigle", "Puma", "Nike"]})
  |> Repo.insert

%Email{}
  |> Email.changeset(%{"email" => "test4@email.com", "name" => "Test4",
  "name_brands" => ["Adidas", "Billabong", "Asics", "Boss", "Brooksfield",
  "Björn Borg", "Camper", "Change", "Aigle", "Puma", "Nike", "Asics", "Calvin Klein",
  "Converse", "Desigual", "Diesel", "Mango", "Zara", "H&M"]})
  |> Repo.insert

%Email{}
  |> Email.changeset(%{"email" => "test5@email.com", "name" => "Test5",
  "name_brands" => ["Converse", "Desigual", "Diesel", "Mango", "Zara", "H&M"]})
  |> Repo.insert

%Email{}
  |> Email.changeset(%{"email" => "test6@email.com", "name" => "Test6",
  "name_brands" => ["H&M"]})
  |> Repo.insert

%Email{}
  |> Email.changeset(%{"email" => "test7@email.com", "name" => "Test8",
  "name_brands" => ["Reima", "Marimekko"]})
  |> Repo.insert

%Email{}
  |> Email.changeset(%{"email" => "test8@email.com", "name" => "Test9",
  "name_brands" => ["Aarrekid", "Nanso", "Marimekko", "Polarn O. Pyret"]})
  |> Repo.insert

%Email{}
  |> Email.changeset(%{"email" => "test9@email.com", "name" => "Test10",
  "name_brands" => ["Converse", "Aigle", "Stella McCartney"]})
  |> Repo.insert
