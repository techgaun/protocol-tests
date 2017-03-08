defmodule PhoenixWebsocket.Web.TestChannel do
  use Phoenix.Channel

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

  def join("device:" <> _ident, _, socket) do
    {:ok, socket}
  end

  def handle_in("create", _, socket) do
    {:reply, @sample_payload, socket}
  end

  def handle_in("status", _, socket) do
    {:reply, {:ok, %{msg: "ok"}}, socket}
  end

  def handle_in("update", _, socket) do
    broadcast socket, "update", @sample_payload
    {:noreply, socket}
  end
end
