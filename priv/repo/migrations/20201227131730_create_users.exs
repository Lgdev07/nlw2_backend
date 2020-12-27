defmodule Nlw2Backend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :avatar, :string, null: false
      add :whatsapp, :string, null: false
      add :bio, :string, null: false

      timestamps()
    end

  end
end
