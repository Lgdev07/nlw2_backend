defmodule Nlw2Backend.Repo.Migrations.CreateClassSchedule do
  use Ecto.Migration

  def change do
    create table(:class_schedule) do
      add :week_day, :integer, null: false
      add :from, :integer, null: false
      add :to, :integer, null: false
      add :class_id, references(:classes, on_delete: :delete_all, on_update: :update_all), null: false

      timestamps()
    end

  create index(:class_schedule, [:class_id])
  end
end
