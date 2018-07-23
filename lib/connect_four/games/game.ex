defmodule ConnectFour.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset


  schema "games" do
    field :state, :string
    field :player_one_id, :id
    field :player_two_id, :id
    field :winner_id, :id

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:state])
    |> validate_required([:state])
  end
end
