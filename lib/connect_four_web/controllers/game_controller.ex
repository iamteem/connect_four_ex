defmodule ConnectFourWeb.GameController do
  use ConnectFourWeb, :controller

  alias ConnectFour.Games
  alias ConnectFour.Games.Game

  def index(conn, _params, _) do
    changeset = Games.change_game(%Game{})
    render conn, "index.html", %{games: [], changeset: changeset}
  end

  def create(conn, _params, current_user) do
    changeset = Games.start_game(current_user)
    redirect conn, to: page_path(conn, :index)
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
end
