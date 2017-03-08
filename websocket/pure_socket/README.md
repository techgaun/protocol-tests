# PureSocket

- `mix deps.get`
- `iex -S mix`

### Sample commands for test

```json
$ telnet localhost 4000

{"cmd": "status"}
```

### Network Usage

Sample payload is as below:

```json
{
  "cmd_type": "status",
  "payload": {
    "status": "off"
  }
}
```

JSON-minified:
```
{"cmd_type":"status","payload":{"status":"off"}}
```

- useful payload size: 48 bytes per message
- total data transmission for 20 status: 5.22K
- initial join size: 172B
- individual payload size: ((5.22 * 1024) - 172) / 20 = 259B
- overhead per status: (259 - (2 * 48) + 10) = 173 bytes

Assuming 5 minutes status updates, `288` status updates a day and 8640 events a month

Actual useful payload per month: 48 * 8640 / 1024 = 405K
Overhead per month: 173 * 8640 / 1024 = 1.43MB
