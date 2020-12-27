defmodule Nlw2BackendWeb.ClassController do
  use Nlw2BackendWeb, :controller

  alias Nlw2Backend.Repo
  alias Nlw2Backend.Classes
  alias Nlw2Backend.ClassSchedules
  alias Nlw2Backend.Classes.Class
  alias Nlw2Backend.Users
  alias Nlw2Backend.Users.User
  alias Nlw2Backend.Classes.ClassSchedule
  alias Nlw2Backend.Classes.Class

  action_fallback Nlw2BackendWeb.FallbackController

  def index(conn, _params) do
    classes = Classes.list_classes()
    render(conn, "index.json", classes: classes)
  end

  def create(conn, class_params) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:user, Users.create_user_changeset(class_params))
    |> Ecto.Multi.insert(:class, fn %{user: %User{id: user_id}} ->
      Classes.create_class_changeset(user_id, class_params)
    end)
    |> Ecto.Multi.insert_all(:class_schedule, ClassSchedule, fn %{
      class: %Class{id: class_id}} ->
      ClassSchedules.create_class_schedule_list(class_id, class_params)
    end)
    |> Repo.transaction()

    render(conn, "show.json", class: class_params)
  end

  def show(conn, %{"id" => id}) do
    class = Classes.get_class!(id)
    render(conn, "show.json", class: class)
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = Classes.get_class!(id)

    with {:ok, %Class{} = class} <- Classes.update_class(class, class_params) do
      render(conn, "show.json", class: class)
    end
  end

  def delete(conn, %{"id" => id}) do
    class = Classes.get_class!(id)

    with {:ok, %Class{}} <- Classes.delete_class(class) do
      send_resp(conn, :no_content, "")
    end
  end
end
