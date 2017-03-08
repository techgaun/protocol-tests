defmodule MqttTest do
  use Hulaaki.Client
  alias __MODULE__, as: MT

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


  def on_connect_ack(opts) do
    IO.inspect opts
  end

  def on_subscribed_publish(opts) do
    IO.inspect opts
  end

  def on_subscribed_ack(opts) do
    IO.inspect opts
  end

  def on_pong(opts) do
    IO.inspect opts
  end

  def start_test do
    {:ok, pid} = MT.start_link(%{})
    opts = [client_id: "samar-mqtt-client", host: "localhost", port: 1883]

    MT.connect(pid, opts)

    payload = [id: 10_000, topic: "device:testdevice", message: Poison.encode!(@sample_payload),
               dup: 0, qos: 1, retain: 1
              ]

    0..20
    |> Enum.map(fn _ ->
      MT.publish(pid, payload)
    end)
  end
end
