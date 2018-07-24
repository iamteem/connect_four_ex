defmodule ConnectFourWeb.UserController do
  use ConnectFourWeb, :controller

  alias ConnectFour.Accounts
  alias ConnectFour.Accounts.User

  def new(conn, _) do
    changeset = Accounts.change_user(%User{})
    render conn, "new.html", %{changeset: changeset}
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> ConnectFourWeb.Auth.login(user)
        |> redirect(to: lobby_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, "new.html", %{changeset: changeset}
    end
  end
end
