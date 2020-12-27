defmodule Nlw2Backend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Nlw2Backend.Repo,
      # Start the Telemetry supervisor
      Nlw2BackendWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Nlw2Backend.PubSub},
      # Start the Endpoint (http/https)
      Nlw2BackendWeb.Endpoint
      # Start a worker by calling: Nlw2Backend.Worker.start_link(arg)
      # {Nlw2Backend.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nlw2Backend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Nlw2BackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
