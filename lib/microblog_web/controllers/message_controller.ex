defmodule MicroblogWeb.MessageController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts
  alias Microblog.Accounts.Message

  def index(conn, _params) do
   messages = Enum.reverse(Accounts.list_messages())
   render(conn, "index.html", messages: messages)
end

  def new(conn, _params) do
    changeset = Accounts.change_message(%Message{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"message" => message_params}) do
    case Accounts.create_message(message_params) do
      {:ok, message} ->

MicroblogWeb.Endpoint.broadcast("updates:all", "new_m",
           %{"message_content" => message.content,
             "message_user" => Microblog.Accounts.get_user!(message.user_id).email,
             "user_show" => user_path(conn, :show, Microblog.Accounts.get_user!(message.user_id)),
"message_show" => message_path(conn, :show, message)})

        conn
        |> put_flash(:info, "Message created successfully.")
        |> redirect(to: message_path(conn, :show, message))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Accounts.get_message!(id) |> Microblog.Repo.preload([:user])
    render(conn, "show.html", message: message)
  end

  def edit(conn, %{"id" => id}) do
    message = Accounts.get_message!(id)
    changeset = Accounts.change_message(message)
    render(conn, "edit.html", message: message, changeset: changeset)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Accounts.get_message!(id)

    case Accounts.update_message(message, message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message updated successfully.")
        |> redirect(to: message_path(conn, :show, message))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", message: message, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Accounts.get_message!(id)
    {:ok, _message} = Accounts.delete_message(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: message_path(conn, :index))
  end
end
