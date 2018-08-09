defmodule ConnectFourWeb.GameChannel do
  use ConnectFourWeb, :channel

  def join("game:" <> game_id, _params, socket) do
    {:ok, assign(socket, :game_id, String.to_integer(game_id))}
  end
end
