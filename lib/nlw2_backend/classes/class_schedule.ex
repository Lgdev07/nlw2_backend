defmodule Nlw2Backend.Classes.ClassSchedule do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nlw2Backend.Classes.Class

  schema "class_schedule" do
    field :week_day, :integer
    field :from, :integer
    field :to, :integer
    belongs_to(:class, Class)

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:week_day, :from, :to])
    |> validate_required([:week_day, :from, :to])
    |> assoc_constraint(:class)
  end
end
