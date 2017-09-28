defmodule Microblog.Micro.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Micro.Message


  schema "messages" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
