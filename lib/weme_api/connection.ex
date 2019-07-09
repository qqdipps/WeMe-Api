defmodule WeMeApi.Connection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "connections" do

    timestamps()
  end

  @doc false
  def changeset(connection, attrs) do
    connection
    |> cast(attrs, [])
    |> validate_required([])
  end
end
