defmodule PointGuess.Scheduler do
  @moduledoc """
  PointGuess Scheduler Module
  """
  @behaviour PointGuess.Scheduler.Behaviour

  @impl true
  def fetch_users(server) do
    server_adapter().fetch_users(server)
  end

  defp server_adapter do
    :point_guess
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:adapter)
  end
end
