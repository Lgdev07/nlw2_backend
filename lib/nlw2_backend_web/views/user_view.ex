defmodule Nlw2BackendWeb.UserView do
  use Nlw2BackendWeb, :view
  alias Nlw2BackendWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      avatar: user.avatar,
      whatsapp: user.whatsapp,
      bio: user.bio}
  end
end
