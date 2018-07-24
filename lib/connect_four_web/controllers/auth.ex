defmodule ConnectFourWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias ConnectFour.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    cond do
      user = conn.assigns[:current_user] -> conn
      user = user_id && Accounts.get_user(user_id) ->
        assign(conn, :current_user, user)
      true ->
        assign(conn, :current_user, nil)
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  alias ConnectFourWeb.Router.Helpers, as: Routes

  def require_login(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def login_with_email_and_password(conn, email, pass) do
    case Accounts.authenticate_by_email_and_pass(email, pass) do
      {:ok, user} -> {:ok, conn |> login(user) }
      {:error, :not_found} -> {:error, :not_found, conn}
      {:error, :bad_password} -> {:error, :bad_password, conn}
    end
  end
end
