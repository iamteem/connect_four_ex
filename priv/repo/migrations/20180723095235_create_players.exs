defmodule ConnectFour.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:players, [:user_id])
  end
end
