defmodule PointGuessWeb.UsersView do
  use PointGuessWeb, :view

  def render("index.json", %{users: users, timestamp: timestamp}) do
    %{
      users: render_many(users, __MODULE__, "user.json"),
      timestamp: timestamp
    }
  end

  def render("user.json", %{users: user}) do
    Map.take(user, [:id, :points])
  end
end
