defmodule PlugWebsocket.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: PlugWebsocket.Worker.start_link(arg1, arg2, arg3)
      # worker(PlugWebsocket.Worker, [arg1, arg2, arg3]),

      Plug.Adapters.Cowboy.child_spec(:http, PlugWebsocket.Router, [], [
                                        dispatch: dispatch()
                                      ])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PlugWebsocket.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_, [
        {"/socket/websocket", PlugWebsocket.Socket, []},
        {"/*", Plug.Adapters.Cowboy.Handler, {PlugWebsocket.Router, []}}
      ]}
    ]
  end
end
