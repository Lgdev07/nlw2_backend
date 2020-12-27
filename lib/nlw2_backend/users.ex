defmodule Nlw2Backend.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias Nlw2Backend.Repo
  alias Nlw2Backend.Users.User

  alias Ecto.Multi

  def list_users do
    Repo.all(User)
  end

  def get_user!({:ok, %User{:id => id}}), do: id
  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    changeset = build(attrs)
    |> User.changeset(attrs)

    Multi.new()
    |> Multi.insert(:user, changeset)
  end

  def create_user_changeset(attrs \\ %{}) do
    build(attrs)
    |> User.changeset(attrs)
  end

  def build(%{"name" => name, "avatar" => avatar, "whatsapp" => whatsapp, "bio" => bio}) do
    %User{
      name: name,
      avatar: avatar,
      whatsapp: whatsapp,
      bio: bio
    }
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
