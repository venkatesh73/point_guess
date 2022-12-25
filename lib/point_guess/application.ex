defmodule PointGuess.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        # Start the Ecto repository
        PointGuess.Repo,
        # Start the Telemetry supervisor
        PointGuessWeb.Telemetry,
        # Start the PubSub system
        {Phoenix.PubSub, name: PointGuess.PubSub},
        # Start the Endpoint (http/https)
        PointGuessWeb.Endpoint
        # Start a worker by calling: PointGuess.Worker.start_link(arg)
        # {PointGuess.Worker, arg}
      ] ++ runtime_children()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PointGuess.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PointGuessWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  @env Mix.env()
  def runtime_children do
    if @env == :test do
      []
    else
      [
        {PointGuess.Scheduler.Server, name: PointGuess.Scheduler}
      ]
    end
  end
end
