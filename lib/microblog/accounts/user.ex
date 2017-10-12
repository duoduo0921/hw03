defmodule Microblog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.User
alias Microblog.Accounts.Message
alias Microblog.Accounts.Follow
  


  schema "users" do
    field :email, :string
    field :is_admin?, :boolean

    has_many :messages, Message
    has_many :following_follows, Follow, foreign_key: :follower_id
    has_many :followers_follows, Follow, foreign_key: :follower_id
    
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :is_admin?])
    |> validate_required([:email])
  end
end
