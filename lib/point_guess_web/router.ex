defmodule PointGuessWeb.Router do
  use PointGuessWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PointGuessWeb do
    pipe_through :api

    get "/", UsersController, :index
  end
end
