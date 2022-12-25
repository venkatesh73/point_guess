defmodule PointGuess.Scheduler.Behaviour do
  alias PointGuess.Schema.User

  @callback fetch_users(GenServer.server()) :: [User.t()]
end
