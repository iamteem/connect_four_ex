defmodule ConnectFourWeb.SessionController do
  use ConnectFourWeb, :controller

  import ConnectFour.Accounts

  def new(conn, _opts) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case ConnectFourWeb.Auth.login_with_email_and_password(conn, email, pass) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: lobby_path(conn, :index))
      {:error, _reason, conn } ->
        conn
        |> put_flash(:error, "Invalid email/password combination.")
        |> render("new.html")
    end
  end

  def create(conn, _) do
    conn
    |> put_flash(:error, "Invalid email/password combination.")
    |> render("new.html")
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "See you soon!")
    |> redirect(to: page_path(conn, :index))
  end
end
