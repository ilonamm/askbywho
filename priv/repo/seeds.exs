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
