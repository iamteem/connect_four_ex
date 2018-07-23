defmodule ConnectFour.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :state, :string
      add :player_one_id, references(:players, on_delete: :nothing)
      add :player_two_id, references(:players, on_delete: :nothing)
      add :winner_id, references(:players, on_delete: :nothing)

      timestamps()
    end

    create index(:games, [:player_one_id])
    create index(:games, [:player_two_id])
    create index(:games, [:winner_id])
  end
end
