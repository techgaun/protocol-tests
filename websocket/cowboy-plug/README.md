# PlugWebsocket

- `mix deps.get`
- `iex -S mix`

### Network Usage

#### `status` test

The response sent over the wire was:

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
- total data transmission for 20 updates: 9448 bytes
- initial upgrade size: 1228
- individual update size: (9448 - 1228) / 20 = 411B
- overhead per update: 49B

Assuming 5 minutes update, `288` status updates a day happen and 8640 a month

Actual useful payload per month: 362 * 8640 / 1024 = 2.98MB
Overhead per month: 49 * 8640 / 1024 = 413KB

#### `compressed` test

Using gzip compression:

- total data transmission for 20 updates: 8919 bytes
- individual update size: (8919 - 1228) / 20 = 384.6B
- overhead per update: 22.6B

Overhead per month: 22.6 * 8640 / 1024 = 190KB

Using zip compression:

- total data transmission for 20 updates: 8612B
- individual update size: (8612 - 1228) / 20 = 369B
- overhead per update: 7B

Overhead per month: (7 * 8640) / 1024 = 59KB
