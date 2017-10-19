defmodule Microblog.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
     add :follower_id, references(:users, on_delete: :nothing)
     add :following_id, references(:users, on_delete: :nothing)
      timestamps()
    end
 
  end
end
