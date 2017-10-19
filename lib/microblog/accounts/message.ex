defmodule Microblog.Accounts.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.Message
  alias Microblog.Accounts.Like


  schema "messages" do
    field :content, :string
    belongs_to :user, Microblog.Accounts.User
    has_many :likes, Like, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:user_id, :content])
    |> validate_required([:user_id, :content])
  end
end

