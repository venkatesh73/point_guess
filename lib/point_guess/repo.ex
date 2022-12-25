defmodule PointGuess.Repo do
  use Ecto.Repo,
    otp_app: :point_guess,
    adapter: Ecto.Adapters.Postgres
end
