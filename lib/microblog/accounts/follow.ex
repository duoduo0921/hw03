defmodule Microblog.Accounts.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.Follow
  alias Microblog.Accounts.User


  schema "follows" do

  belongs_to :following, User
  belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [:user_id, :following_id])
    |> validate_required([])
  end
end
