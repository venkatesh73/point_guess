defmodule PointGuess.Scheduler.StateTest do
  use PointGuess.DataCase, async: true

  alias PointGuess.Scheduler.State
  alias PointGuess.Schema.User

  describe "new/2" do
    test "inits with a max number" do
      refresh_interval = 1
      max_number = 2

      state = State.new(refresh_interval, max_number)

      assert state.refresh_interval == refresh_interval
      assert state.max_number == max_number
    end
  end

  describe "refresh_max/1" do
    test "refresh max" do
      state = State.new(1, 2) |> State.refresh_max()

      assert state.max_number in 0..100
    end
  end

  describe "put_users/1" do
    test "adds users to state" do
      users = [%User{points: 1}]

      state = State.new(1, 2) |> State.put_users(users)

      assert state.users == users
      assert state.timestamp != nil
    end
  end
end
