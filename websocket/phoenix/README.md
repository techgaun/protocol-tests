# PhoenixWebsocket

- `sudo apt install -y expect`
- `npm i -g wscat`
- `wscat -c ws://localhost:4000/socket/websocket?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbWFyLmFjaGFyeWErc3RhZ2VAYnJpZ2h0ZXJneS5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6InNhbWFyLmFjaGFyeWErc3RhZ2VAYnJpZ2h0ZXJneS5jb20iLCJhcHBfbWV0YWRhdGEiOnsiZGV2aWNlcyI6WzFdLCJyb2xlIjoiZGV2aWNlIn0sImlzcyI6Imh0dHBzOi8vY2FzYS1pcS5hdXRoMC5jb20vIiwic3ViIjoiYXV0aDB8NTg3NzAxZTVhY2JiYTQ2NDZhOWM3YjI2IiwiYXVkIjoiMzZQM3g5ajNOVkk1Mzczejl1RjVZSWhjWlNNWFZGV2siLCJleHAiOjE0ODg5NDk3NjUsImlhdCI6MTQ4ODkxMzc2NX0.mOkG4gvyJySezCj-ix35mDlTm4wIPThpD2w-znUnYfA`

### Sample commands for test

```json
> {"event": "phx_join", "payload": {}, "ref": "lkds", "topic": "device:testdevice"}
< {"topic":"device:testdevice","ref":"lkds","payload":{"status":"ok","response":{}},"event":"phx_reply"}
> {"event": "status", "payload": {}, "ref": "lkds", "topic": "device:testdevice"}
< {"topic":"device:testdevice","ref":"lkds","payload":{"status":"ok","response":{"msg":"ok"}},"event":"phx_reply"}
> {"event": "update", "payload": {}, "ref": "lkds", "topic": "device:testdevice"}
< {"topic":"device:testdevice","ref":null,"payload":{"unit_type":"c","type":"received","system_mode":"auto","status":"online","running_mode":"off","ref":"cd273ebe-f936-11e6-8c4c-82b9d03af3f9","occupied":"unknown","identifier":"00:1d:35:08:03:19:51:91","heat_setpoint":21.06,"effective_occupancy":"occupied","device_timestamp":"2017-02-22T19:40:44.268185Z","deadband":1.7,"current_temp":22.89,"cool_setpoint":24.39},"event":"update"}
```

### Automated Tests

- `./status.sh <count_of_requests>`
- `./status.sh <count_of_requests> <filename_with_payload>`

#### Example

- `./status.sh 20`
- `./status.sh update.event`

### Network Usage

#### `status` test with the response payload: `{"msg":"ok"}`

- useful payload size: 12 bytes per update
- total data transmission for 20 status: 7.63K
- initial join size: 954B
- individual status size: ((7.63 * 1024) - 954) / 20 = 343B
- overhead per status: 331B

Assuming 5 minutes status update, `288` status updates a day happen and 8640 events a month.

Actual useful payload per month: 12 * 8640 / 1024 = 101.25KB
Overhead per month: 331 * 8640 / 1024 = 2.73MB

#### `update` test with the following payload:

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

- useful payload size: 362B (whitespace ignored)
- total data transmission for 20 updates: 14.9K
- initial join size: 954B
- individual update size: ((14.9 * 1024) - 954) / 20 = 716B
- overhead per update: 354B

Assuming there are 50 updates a day, `1500` updates a month.

Actual useful payload per month: 362 * 1500 / 1024 = 530.3KB
Overhead per month: 354 * 1500 / 1024 = 518.6KB
