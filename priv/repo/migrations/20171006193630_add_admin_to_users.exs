defmodule Microblog.Repo.Migrations.AddAdminToUsers do
  use Ecto.Migration

  def change do 
    alter table("users") do
      add :is_admin?, :boolean, null: false, default: false
    end
  end
end
