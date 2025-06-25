# ![mosquitto](https://cdn.jsdelivr.net/gh/selfhst/icons/png/mosquitto.png){ width="32" } Eclipse Mosquitto

[Eclipse Mosquitto][1] is an open source (EPL/EDL licensed) message broker that implements the MQTT protocol. 

I use it to extract devices from [`rtl_433`](./rtl_433.md).

## :hammer_and_wrench: Hardware

WIP

## :gear: Config

!!! example ""

    :material-console-network: Web port: `9001`
    
    :material-console-network: Interface port: `1883`

??? abstract "compose.yaml"

    ```yaml
    --8<-- "compose.yaml:mosquitto"
    ```

### ![ha](https://cdn.jsdelivr.net/gh/selfhst/icons/png/home-assistant.png){ width="16" } Home Assistant

!!! note

    The `Broker` should match the container name of Eclipse Mosquitto.

!!! example ""

    === "MQTT"
    
        Broker: `mosquitto`

        Port: `1883`

## :link: References

- <https://mosquitto.org/>
- <https://www.home-assistant.io/integrations/mqtt/>

[1]: <https://mosquitto.org/>
