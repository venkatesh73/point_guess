defmodule PointGuess.UsersTest do
  use PointGuess.DataCase, async: true

  alias PointGuess.Repo
  alias PointGuess.Schema.User
  alias PointGuess.Users

  describe "list_users_with_more_points/1" do
    test "list all users with more points than random number" do
      user_1 = Repo.insert!(%User{points: 55})
      user_2 = Repo.insert!(%User{points: 60})

      assert Users.list_users_with_more_points(50) == [user_2, user_1]
    end

    test "returns empty list when no users with more points available" do
      _user_1 = Repo.insert!(%User{points: 55})
      _user_2 = Repo.insert!(%User{points: 60})

      assert Users.list_users_with_more_points(70) == []
    end

    test "returns at max 2 users when random points matches" do
      for _ <- 1..10 do
        Repo.insert!(%User{points: 75})
      end

      users = Users.list_users_with_more_points(70)
      assert length(users) == 2
    end
  end

  describe "update_all_users_with_points/0" do
    test "updates all users with the random points" do
      _user_1 = Repo.insert!(%User{points: 55})
      _user_2 = Repo.insert!(%User{points: 60})

      assert {:ok, :updated_successfully} == Users.update_all_users_with_points()
    end
  end
end
