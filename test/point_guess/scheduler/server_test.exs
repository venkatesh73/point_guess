defmodule PointGuess.Scheduler.ServerTest do
  use PointGuess.DataCase, async: true

  alias PointGuess.Repo
  alias PointGuess.Scheduler.Server
  alias PointGuess.Schema.User

  describe "fetch_users/1" do
    test "returns initial state" do
      server = start_supervised!({Server, refresh_interval: :timer.hours(24)})
      Ecto.Adapters.SQL.Sandbox.allow(Repo, self(), server)

      assert Server.fetch_users(server) == %{timestamp: nil, users: []}
    end

    test "retrieves users of the previous call" do
      server = start_supervised!({Server, refresh_interval: :timer.hours(24), max_number: 1})
      Ecto.Adapters.SQL.Sandbox.allow(Repo, self(), server)

      user_1 = Repo.insert!(%User{points: 2})
      user_2 = Repo.insert!(%User{points: 3})

      Server.fetch_users(server)

      %{timestamp: current_timestamp} = :sys.get_state(server)

      assert Server.fetch_users(server) == %{
               timestamp: current_timestamp,
               users: [user_2, user_1]
             }
    end

    test "updates the timestamp" do
      server = start_supervised!({Server, refresh_interval: :timer.hours(24), max_number: 1})
      Ecto.Adapters.SQL.Sandbox.allow(Repo, self(), server)

      assert %{timestamp: nil} = Server.fetch_users(server)
      assert %{timestamp: %DateTime{}} = :sys.get_state(server)
    end
  end

  describe "refresh" do
    test "periodically refresh" do
      server = start_supervised!({Server, refresh_interval: 1})
      Ecto.Adapters.SQL.Sandbox.allow(Repo, self(), server)

      :erlang.trace(server, true, [:receive])

      assert_receive {:trace, ^server, :receive, :refresh}
    end

    test "updates max_number" do
      server = start_supervised!({Server, refresh_interval: :timer.hours(24), max_number: 1})
      Ecto.Adapters.SQL.Sandbox.allow(Repo, self(), server)

      send(server, :refresh)

      assert :sys.get_state(server).max_number in 0..100
    end

    test "updates users with random point numbers" do
      server = start_supervised!({Server, refresh_interval: :timer.hours(24), max_number: 1})
      Ecto.Adapters.SQL.Sandbox.allow(Repo, self(), server)

      user_1 = Repo.insert!(%User{points: 0})
      user_2 = Repo.insert!(%User{points: 0})

      send(server, :refresh)

      assert Repo.reload!(user_1).points in 0..100
      assert Repo.reload!(user_2).points in 0..100
    end
  end
end
