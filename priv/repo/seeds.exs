# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Microblog.Repo.insert!(%Microblog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Microblog.Repo
alias Microblog.Accounts.User


Repo.insert!(%User{email: "admin@163.com", is_admin?: true, password: "adminadmin", password_confirmation: "adminadmin"})
