defmodule Nlw2Backend.Classes do
  @moduledoc """
  The Classes context.
  """

  import Ecto.Query, warn: false

  alias Nlw2Backend.Repo
  alias Nlw2Backend.Classes.Class

  alias Ecto.Multi

  def list_classes do
    Repo.all(Class)
  end

  def get_class!({:ok, %Class{:id => id}}), do: id
  def get_class!(id), do: Repo.get!(Class, id)

  def create_class(user_id, attrs \\ %{}) do
    changeset = build(user_id, attrs)
    |> Class.changeset(attrs)

    Multi.new()
    |> Multi.insert(:class, changeset)
  end

  def create_class_changeset(user_id, attrs \\ %{}) do
    build(user_id, attrs)
    |> Class.changeset(attrs)
  end

  def build(user_id, %{"subject" => subject, "cost" => cost}) do
    %Class{
      subject: subject,
      cost: cost,
      user_id: user_id
    }
  end

  def update_class(%Class{} = class, attrs) do
    class
    |> Class.changeset(attrs)
    |> Repo.update()
  end

  def delete_class(%Class{} = class) do
    Repo.delete(class)
  end

  def change_class(%Class{} = class, attrs \\ %{}) do
    Class.changeset(class, attrs)
  end
end
