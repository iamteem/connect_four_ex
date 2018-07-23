defmodule ConnectFour.Repo.Migrations.CreateMoves do
  use Ecto.Migration

  def change do
    create table(:moves) do
      add :column, :integer
      add :turn_number, :integer
      add :player_id, references(:players, on_delete: :nothing)
      add :game_id, references(:games, on_delete: :nothing)

      timestamps()
    end

    create index(:moves, [:player_id])
    create index(:moves, [:game_id])
  end
end
