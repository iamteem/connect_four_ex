defmodule ConnectFour.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset


  schema "games" do
    field :state, :string
    belongs_to :player_one, Player
    belongs_to :player_two, Player
    belongs_to :winner, Player

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:state])
    |> validate_required([:state])
  end
end
