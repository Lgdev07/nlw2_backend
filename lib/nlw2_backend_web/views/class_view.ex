defmodule Nlw2BackendWeb.ClassView do
  use Nlw2BackendWeb, :view
  alias Nlw2BackendWeb.ClassView

  def render("index.json", %{classes: classes}) do
    %{data: render_many(classes, ClassView, "class.json")}
  end

  def render("show.json", %{class: class}) do
    %{data: render_one(class, ClassView, "class.json")}
  end

  # def render("class.json", %{class: class}) do
  #   %{id: class.id,
  #     subject: class.subject,
  #     cost: class.cost}
  # end

  def render("class.json", class) do
    class
  end
end
