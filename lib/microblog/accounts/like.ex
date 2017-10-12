defmodule Microblog.Accounts.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.Like


  schema "likes" do
    belongs_to :message, Microblog.Accounts.Message
    belongs_to :user, Microblog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:user_id, :message_id])
    |> validate_required([:user_id, :message_id])
  end
end
