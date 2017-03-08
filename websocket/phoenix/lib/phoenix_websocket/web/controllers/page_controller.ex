defmodule PhoenixWebsocket.Web.PageController do
  use PhoenixWebsocket.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
