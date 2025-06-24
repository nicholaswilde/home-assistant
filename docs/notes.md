# :pencil: Notes

- [Remove unwanted entities][17] - `Development tools` → `Services` → `recorder.purge_entities`
- Remove ZHA device
    - Copy `Settings` → `Devices & services` → `Zigbee Home Automation` → `<Device>` → `Device info` → `Zigbee info` → `IEEE`
    - `Development tools` → `Services` → `zha.remove`
- Debug `rtl_433` - `Settings` → `Devices & services` → `MQTT` → `Configure` → `Listen to a topic` → `rtl_433/#` → `Start listening`
- List all entities `Template` → `{{ states | map(attribute='entity_id') | list | join('\n') }}`

## :link: References

[17]: <https://community.home-assistant.io/t/how-to-remove-unwanted-entities/433103/10>