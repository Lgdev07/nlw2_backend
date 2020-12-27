defmodule Nlw2Backend.Classes.Class do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nlw2Backend.Users.User

  schema "classes" do
    field :cost, :decimal
    field :subject, :string
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:subject, :cost])
    |> validate_required([:subject, :cost])
    |> assoc_constraint(:user)
  end
end
