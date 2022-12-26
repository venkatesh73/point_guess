defmodule PointGuess.Scheduler.State do
  @moduledoc """
  PointGuess Scheduler State to manage Scheduler related configs
  """

  defstruct max_number: nil, users: [], timestamp: nil, refresh_interval: nil

  @spec new(refresh_interval :: non_neg_integer(), max_number :: integer()) :: %__MODULE__{}
  def new(refresh_interval, max_number) do
    %__MODULE__{refresh_interval: refresh_interval, max_number: max_number}
  end

  @spec refresh_max(state :: map()) :: map()
  def refresh_max(state) do
    %{state | max_number: Enum.random(0..100)}
  end

  @spec put_users(state :: map(), users :: list()) :: map()
  def put_users(state, users) do
    %{state | users: users, timestamp: DateTime.utc_now()}
  end
end
