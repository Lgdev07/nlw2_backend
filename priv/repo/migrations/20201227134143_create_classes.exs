defmodule Nlw2Backend.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :subject, :string, null: false
      add :cost, :decimal, null: false
      add :user_id, references(:users, on_delete: :delete_all, on_update: :update_all), null: false

      timestamps()
    end

    create index(:classes, [:user_id])
  end
end
