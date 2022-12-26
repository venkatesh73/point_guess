defmodule PointGuess.Scheduler.Behaviour do
  @moduledoc """
  PointGuess Scheduler behaviour
  """
  alias PointGuess.Schema.User

  @callback fetch_users(GenServer.server()) :: [User.t()]
end
