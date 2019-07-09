defmodule WeMeApi.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :user_id, references(:users, on_delete: :nothing)
      add :connection_id, references(:connections, on_delete: :nothing)

      timestamps()
    end

    create index(:links, [:user_id])
    create index(:links, [:connection_id])
  end
end
