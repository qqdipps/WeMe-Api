defmodule WeMeApi.Associates.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :user_id, :id
    field :connection_id, :id

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:user_id, :connection_id])
    |> validate_required([:user_id, :connection_id]])
    |> foreign_key_constraint([:user_id, :connection_id]])
  end
end
