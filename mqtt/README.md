# MqttTest

- install mosquito (or any other mqtt broker)
- `mix deps.get`
- `iex -S mix`
- `MqttTest.start_test`

### Network Usage

payload:

```json
{
  "unit_type": "c",
  "type": "received",
  "system_mode": "auto",
  "status": "online",
  "running_mode": "off",
  "ref": "cd273ebe-f936-11e6-8c4c-82b9d03af3f9",
  "occupied": "unknown",
  "identifier": "00:1d:35:08:03:19:51:91",
  "heat_setpoint": 21.06,
  "effective_occupancy": "occupied",
  "device_timestamp": "2017-02-22T19:40:44.268185Z",
  "deadband": 1.7,
  "current_temp": 22.89,
  "cool_setpoint": 24.39
}
```

- useful payload size: 362B
- total data transmission for 20 updates: 10854 bytes
- individual size: 10854 / 20 = 543B
- overhead per update: 181B

Actual useful payload per month: 2.98MB
Overhead per month: 181 * 8640 / 1024: 1.49MB

- It seems that ACK is 70 bytes and Publish message is 452B for 362B of payload.
