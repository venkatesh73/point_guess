defmodule PointGuessWeb.UsersControllerTestuse do
  use PointGuessWeb.ConnCase, async: true

  import Mox

  alias PointGuess.SchedulerMock
  alias PointGuess.Schema.User

  setup :verify_on_exit!

  describe "/" do
    test "initial state", %{conn: conn} do
      expect(SchedulerMock, :fetch_users, fn _ -> %{users: [], timestamp: nil} end)

      response =
        conn
        |> get(Routes.users_path(conn, :index))
        |> json_response(:ok)

      assert response == %{"users" => [], "timestamp" => nil}
    end

    test "render users", %{conn: conn} do
      user_1 = %User{id: 1, points: 30}
      user_2 = %User{id: 72, points: 30}
      timestamp = ~U[2022-12-26 07:01:26Z]

      expect(SchedulerMock, :fetch_users, fn _ ->
        %{users: [user_1, user_2], timestamp: timestamp}
      end)

      response =
        conn
        |> get(Routes.users_path(conn, :index))
        |> json_response(:ok)

      assert response == %{
               "users" => [%{"id" => 1, "points" => 30}, %{"id" => 72, "points" => 30}],
               "timestamp" => "2022-12-26T07:01:26Z"
             }
    end
  end
end
