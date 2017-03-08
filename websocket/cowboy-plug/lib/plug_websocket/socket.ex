defmodule PlugWebsocket.Socket do
  @behaviour :cowboy_websocket_handler
  @timeout 300_000

  @sample_payload %{
    "unit_type" => "c",
    "type" => "received",
    "system_mode" => "auto",
    "status" => "online",
    "running_mode" => "off",
    "ref" => "cd273ebe-f936-11e6-8c4c-82b9d03af3f9",
    "occupied" => "unknown",
    "identifier" => "00:1d:35:08:03:19:51:91",
    "heat_setpoint" => 21.06,
    "effective_occupancy" => "occupied",
    "device_timestamp" => "2017-02-22T19:40:44.268185Z",
    "deadband" => 1.7,
    "current_temp" => 22.89,
    "cool_setpoint" => 24.39
  }


  def init(_, _req, _opts) do
    {:upgrade, :protocol, :cowboy_websocket}
  end

  def websocket_init(_type, req, _opts) do
    state = %{}
    {:ok, req, state, @timeout}
  end

  def websocket_handle({:text, "ping"}, req, state) do
    {:reply, {:text, "response:pong"}, req, state}
  end

  def websocket_handle({:text, "gzip"}, req, state) do
    {:reply, {:text, "response:" <> :zlib.gzip(Poison.encode!(@sample_payload))}, req, state}
  end

  def websocket_handle({:text, "zip"}, req, state) do
    {:reply, {:text, "response:" <> :zlib.zip(Poison.encode!(@sample_payload))}, req, state}
  end

  def websocket_handle({:text, "status"}, req, state) do
    {:reply, {:text, "response:" <>Poison.encode!(@sample_payload)}, req, state}
  end

  def websocket_handle({:text, msg}, req, state) do
    IO.puts msg
    {:ok, req, state}
  end

  def websocket_info(msg, req, state) do
    {:reply, {:text, msg}, req, state}
  end

  def websocket_terminate(_reason, _req, _state), do: :ok
end
