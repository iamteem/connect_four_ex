defmodule ConnectFourWeb.PageController do
  use ConnectFourWeb, :controller

  def index(conn, _params) do
    if conn.assigns.current_user do
      redirect conn, to: lobby_path(conn, :index)
    else
      render conn, "index.html"
    end
  end
end
