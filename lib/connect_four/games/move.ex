defmodule ConnectFour.Games.Move do
  use Ecto.Schema
  import Ecto.Changeset


  schema "moves" do
    field :column, :integer
    field :turn_number, :integer
    field :player_id, :id
    field :game_id, :id

    timestamps()
  end

  @doc false
  def changeset(move, attrs) do
    move
    |> cast(attrs, [:column, :turn_number])
    |> validate_required([:column, :turn_number])
  end
end
