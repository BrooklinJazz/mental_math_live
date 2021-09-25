defmodule MentalMath.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      MentalMath.Repo,
      # Start the Telemetry supervisor
      MentalMathWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MentalMath.PubSub},
      # Start the Endpoint (http/https)
      MentalMathWeb.Endpoint
      # Start a worker by calling: MentalMath.Worker.start_link(arg)
      # {MentalMath.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MentalMath.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MentalMathWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
