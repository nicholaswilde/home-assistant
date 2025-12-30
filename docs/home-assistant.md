# ![ha](https://cdn.jsdelivr.net/gh/selfhst/icons/png/home-assistant.png){ width="32" } Home Assistant

## :whale2: Docker Compose

I run HA in a Docker container using Docker compose to enable the ease of updating via Renovate.

## ![ha](https://cdn.jsdelivr.net/gh/selfhst/icons/png/home-assistant.png){ width="24" } HAOS

I toyed around with moving to HAOS to make it easier to install and manage integratios, but I didn't like the command line.

## :gear: Config

!!! example ""

    :material-console-network: Default Port: `8123`

!!! code ""

    ```shell
    sudo ls -la /dev/serial/by-id
    ```

    ```shell title="Output"
    /dev/serial/by-id//dev/serial/by-id/usb-Nabu_Casa_SkyConnect_v1.0_8aaab0838e91ed1196c1c3d13b20a988-if00-port0
    ```

??? abstract "compose.yaml"

    ```yaml
    --8<-- "compose.yaml:home-assistant"
    ```

## :bell: Notifications

I use several notification platforms to stay informed about my home's status.

- **[Mailrise](./add-on/mailrise.md)**: SMTP gateway for Apprise notifications.
- **HTML5**: Browser-based notifications.
- **Alexa**: Voice notifications via Echo devices.

## :pencil: Notes

- [Remove unwanted entities][1] - `Development tools` → `Services` → `recorder.purge_entities`
- Remove ZHA device
- Copy `Settings` → `Devices & services` → `Zigbee Home Automation` → `<Device>` → `Device info` → `Zigbee info` → `IEEE`
- `Development tools` → `Services` → `zha.remove`
- List all entities `Template` → `{{ states | map(attribute='entity_id') | list | join('\n') }}`

## :rocket: Upgrade

!!! code

    === "Task"

        ```shell
        task upgrade
        ```

    === "Manual"

        ```shell
        
        ```

## :link: References

[1]: <https://community.home-assistant.io/t/how-to-remove-unwanted-entities/433103/10>
