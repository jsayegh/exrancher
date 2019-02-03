defmodule Exrancher.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :files, {:array, :string}
    field :name, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :files])
    |> validate_required([:name, :username, :files])
    |> unique_constraint(:username)
  end
end
