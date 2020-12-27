defmodule Nlw2Backend.Repo do
  use Ecto.Repo,
    otp_app: :nlw2_backend,
    adapter: Ecto.Adapters.Postgres
end
