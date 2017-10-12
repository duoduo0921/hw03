defmodule Microblog.Accounts.Message do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Microblog.Accounts.Message


  schema "messages" do
    field :content, :string
    belongs_to :user, Microblog.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:user_id, :content])
    |> validate_required([:user_id, :content])
  end
end

