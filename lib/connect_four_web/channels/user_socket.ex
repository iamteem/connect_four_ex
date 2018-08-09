defmodule ConnectFourWeb.UserSocket do
  use Phoenix.Socket
  channel "game:*", ConnectFourWeb.GameChannel
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "user salt", token, max_age: 86400) do
      {:ok, user_id} ->
        socket = assign(socket, :user, ConnectFour.Accounts.get_user(user_id))
        {:ok, socket}
      {:error, _} ->
        :error
    end
  end

  def id(socket), do: "user_socket:#{socket.assigns.user.id}"
end
