defmodule Nlw2Backend.Repo.Migrations.CreateConnections do
  use Ecto.Migration

  def change do
    create table(:connections) do
      add :user_id, references(:users, on_delete: :delete_all, on_update: :update_all), null: false

      timestamps()
    end

  create index(:connections, [:user_id])
  end
end
