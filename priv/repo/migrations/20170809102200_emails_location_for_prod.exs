defmodule Askbywho.Repo.Migrations.EmailsLocationForProd do
  use Ecto.Migration

  def change do
    alter table(:emails) do
      add :latitude, :real
      add :longitude, :real
      add :location, :string
    end
  end
end
