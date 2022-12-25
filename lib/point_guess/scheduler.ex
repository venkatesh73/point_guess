defmodule PointGuess.Scheduler do
  @moduledoc """
  """
  @behaviour PointGuess.Scheduler.Behaviour

  @impl true
  def fetch_users(server) do
    PointGuess.Scheduler.Server.fetch_users(server)
  end
end
