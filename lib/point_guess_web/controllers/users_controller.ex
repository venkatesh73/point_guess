defmodule PointGuessWeb.UsersController do
  use PointGuessWeb, :controller

  alias PointGuess.Scheduler

  def index(conn, _params) do
    render(conn, "index.json", Scheduler.fetch_users(Scheduler))
  end
end
