# protocol-tests

> Testing Websocket and MQTT with various configurations

- I used iftop and wireshark for analyzing network traffic.
- We're going to choose websocket with cowboy and plug as catch-all for routes. It would still be compatible with the system we have and still be good enough for bandwidth.
- With cowboy, we can still control certain details of how we want to format data.
- Phoenix provides ability to specify custom serializer
