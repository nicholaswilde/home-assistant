# ![ha](https://cdn.jsdelivr.net/gh/selfhst/icons/png/home-assistant.png){ width="32" } Home Assistant

## :gear: Config

!!! example ""

    :material-console-network: Default Port: `8123`

??? abstract "compose.yaml"

    ```yaml
    --8<-- "compose.yaml:home-assistant"
    ```

## :pencil: Notes

- [Remove unwanted entities][1] - `Development tools` → `Services` → `recorder.purge_entities`
- Remove ZHA device
- Copy `Settings` → `Devices & services` → `Zigbee Home Automation` → `<Device>` → `Device info` → `Zigbee info` → `IEEE`
- `Development tools` → `Services` → `zha.remove`
- List all entities `Template` → `{{ states | map(attribute='entity_id') | list | join('\n') }}`

## :link: References

[1]: <https://community.home-assistant.io/t/how-to-remove-unwanted-entities/433103/10>
