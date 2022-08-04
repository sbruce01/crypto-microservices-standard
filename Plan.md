# Plan for Implementing Microservices

## Get Publishing to TP

1. Try using a custom TP as has been done so far
2. Try using RT logic

For both of these use cases try to pump into just the RDB with a SM. 
If this doesn't work straight away go for the worker-leader structure there are examples for.

### Custom TP

<!-- (1. Worker-Controller Code: https://code.kx.com/insights/1.1/microservices/stream-processor/quickstart/docker.html) Maybe skip this for now and try the RDB first -->
1. Running with Minimal Configuration: https://code.kx.com/insights/1.1/microservices/storage-manager/running.html#running-with-minimal-configuration
- Copy Code
- Add to startup script

### KX Insights RT message bus
1. Code base here: https://code.kx.com/insights/1.1/microservices/assembly/tick-example.html
