defmodule PointGuess.Schema.User do
  @moduledoc """
  User Schema
  """
  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "users" do
    field :points, :integer

    timestamps(type: :utc_datetime, usec: true)
  end

  @spec changeset(user :: __MODULE__.t(), attrs :: map()) :: Ecto.Changeset.t()
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> validate_number(:points, greater_than_or_equal_to: 0, less_than_or_equal_to: 100)
  end
end
