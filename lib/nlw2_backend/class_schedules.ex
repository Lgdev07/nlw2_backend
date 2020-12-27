defmodule Nlw2Backend.ClassSchedules do
  @moduledoc """
  The ClassSchedules context.
  """
  import Ecto.Query, warn: false

  alias Nlw2Backend.Repo
  alias Nlw2Backend.Classes.ClassSchedule

  alias Ecto.Multi

  def create_class_schedule(class_id, attrs \\ %{}) do
    schedule_list = build(class_id, attrs)

    Multi.new()
    |> Multi.insert_all(:class_schedule, ClassSchedule, schedule_list)
  end

  def create_class_schedule_list(class_id, attrs \\ %{}) do
    build(class_id, attrs)
  end

  def build(class_id, %{"schedule" => schedule_list}) do
    schedule_list
    |> transform_strings_to_atom()
    |> transform_map_values(class_id)

  end

  def convert_hour_to_minutes(hours) do
    [hour, minute] =
      hours
      |> String.split(":")
      |> Enum.map(fn x -> String.to_integer x end)

    (hour * 60) + minute
  end

  defp transform_strings_to_atom(schedule_list) do
    schedule_list
    |> Enum.map(fn map -> Map.new(map, fn {key, value} -> {String.to_atom(key), value} end) end)
  end

  defp transform_map_values(schedule_list, class_id) do
    schedule_list
    |> Enum.map(fn map -> Map.merge(map, %{
      inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
      updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
      class_id: class_id,
      from: convert_hour_to_minutes(map[:from]),
      to: convert_hour_to_minutes(map[:to])
    }) end)
  end

end
