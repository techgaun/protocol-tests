// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"
window.userToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbWFyLmFjaGFyeWErc3RhZ2VAYnJpZ2h0ZXJneS5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6InNhbWFyLmFjaGFyeWErc3RhZ2VAYnJpZ2h0ZXJneS5jb20iLCJ1c2VyX21ldGFkYXRhIjp7Im5hbWUiOiJTYW1hciBBd2Vzb21lIEFjaGFyeWEifSwiYXBwX21ldGFkYXRhIjp7ImFkbWluIjp0cnVlLCJ1bml0cyI6WzFdLCJyb2xlIjoiYWRtaW4ifSwicGljdHVyZSI6Imh0dHBzOi8vcy5ncmF2YXRhci5jb20vYXZhdGFyLzNjZGE5MzNhNDdlZmFlODA0Y2M5ZTFmOTQ1NGVkODI2P3M9NDgwJnI9cGcmZD1odHRwcyUzQSUyRiUyRmNkbi5hdXRoMC5jb20lMkZhdmF0YXJzJTJGc2EucG5nIiwiaXNzIjoiaHR0cHM6Ly9jYXNhLWlxLmF1dGgwLmNvbS8iLCJzdWIiOiJhdXRoMHw1ODc3MDFlNWFjYmJhNDY0NmE5YzdiMjYiLCJhdWQiOiIzNlAzeDlqM05WSTUzNzN6OXVGNVlJaGNaU01YVkZXayIsImV4cCI6MTQ4ODk0OTc2NSwiaWF0IjoxNDg4OTEzNzY1fQ.NKEZkLxjw3-uO1ou60F-qYFQvM6wD17mrhEXgQk-JOw"
let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("device:testdevice", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
