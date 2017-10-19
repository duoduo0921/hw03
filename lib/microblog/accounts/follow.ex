defmodule Microblog.Accounts.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.Follow
  alias Microblog.Accounts.User


  schema "follows" do
    belongs_to :follower, User, foreign_key: :follower_id
    belongs_to :following, User, foreign_key: :following_id
    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [:follower_id, :following_id])
    |> validate_required([:follower_id, :following_id])
  end
end
