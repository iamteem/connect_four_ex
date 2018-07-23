defmodule ConnectFour.Games.Player do
  use Ecto.Schema
  import Ecto.Changeset


  schema "players" do
    field :user_id, :id
    field :game_id, :id

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [])
    |> validate_required([])
  end
end
