defmodule Askbywho.Repo.Migrations.CreateEmail do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :name, :string
      add :email, :string

      timestamps
    end

    create unique_index(:emails, [:email])

    create table(:brands_emails, primary_key: false) do
      add :brand_id, references(:brands)
      add :email_id, references(:emails)
    end

  end
end
