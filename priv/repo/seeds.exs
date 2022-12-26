alias PointGuess.Repo
alias PointGuess.Schema.User

timestamps = DateTime.utc_now() |> DateTime.truncate(:second)

list_of_users =
  1..1_000_000
  |> Enum.map(fn _ ->
    %{points: 0, inserted_at: timestamps, updated_at: timestamps}
  end)
  |> Enum.chunk_every(10000)

Repo.transaction(
  fn ->
    Enum.each(list_of_users, fn rows ->
      Repo.insert_all(User, rows)
    end)
  end,
  timeout: :infinity
)
