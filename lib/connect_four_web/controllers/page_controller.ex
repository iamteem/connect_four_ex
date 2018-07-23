defmodule ConnectFourWeb.PageController do
  use ConnectFourWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
