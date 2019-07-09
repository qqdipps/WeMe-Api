defmodule WeMeApi.Repo.Migrations.CreateConnections do
  use Ecto.Migration

  def change do
    create table(:connections) do

      timestamps()
    end

  end
end
