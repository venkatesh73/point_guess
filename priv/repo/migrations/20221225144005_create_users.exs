defmodule PointGuess.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :points, :integer, null: false

      timestamps(type: :utc_datetime, usec: true)
    end

    create constraint(:users, :points_between_zero_and_one_hundred,
             check: "points >= 0 AND points <= 100"
           )
  end
end
