defmodule PointGuess.Users do
  @moduledoc """
  User context modules helps to do DB operations
  """
  import Ecto.Query

  alias PointGuess.Repo
  alias PointGuess.Schema.User

  @spec list_users_with_more_points(max_points :: integer()) :: list()
  def list_users_with_more_points(max_points) do
    User
    |> where([u], u.points > ^max_points)
    |> order_by(desc: :points)
    |> limit(2)
    |> Repo.all()
  end

  @spec update_all_users_with_points ::
          {:ok, :updated_successfully} | {:error, :error_failed_to_update}
  def update_all_users_with_points() do
    User
    |> update(set: [points: fragment("floor(random() * (? - ? + 1) + ?)", 100, 0, 0)])
    |> Repo.update_all([])
    |> case do
      nil ->
        {:error, :error_failed_to_update}

      _ ->
        {:ok, :updated_successfully}
    end
  end
end
