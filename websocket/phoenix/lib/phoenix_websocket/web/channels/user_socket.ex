defmodule PhoenixWebsocket.Web.UserSocket do
  use Phoenix.Socket

  ## Channels
  # channel "room:*", PhoenixWebsocket.Web.RoomChannel
  channel "device:*", PhoenixWebsocket.Web.TestChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(params, socket) do
    if jwt?(params["token"]) do
      {:ok, socket}
    else
      :error
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     PhoenixWebsocket.Web.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil

  # this is just a quick fake check to see we've jwt
  defp jwt?(token) when is_binary(token) do
    case String.split(token, ".") do
      [h, p, s] ->
        decode(h) !== :error
        and
        decode(p) !== :error
        and
        decode(s) !== :error
      _ ->
        false
    end
  end
  defp jwt?(_), do: false
  defp decode(v), do: Base.url_decode64(v, padding: false)
end
