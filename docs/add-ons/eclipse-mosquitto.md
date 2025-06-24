# ![mosquitto](https://cdn.jsdelivr.net/gh/selfhst/icons/png/mosquitto.png){ width="32" } Eclipse Mosquitto

[Eclipse Mosquitto][1] is an open source (EPL/EDL licensed) message broker that implements the MQTT protocol. 

I use it to extract devices from [`rtl_433`](./rtl_433.md).

## :hammer_and_wrench: Hardware

WIP

## :gear: Config

!!! example ""

    Web port: `3000`
    
    Interface port: `1883`

??? abstract "compose.yaml"

    ```yaml
    --8<-- "compose.yaml:mosquitto"
    ```

## :link: References

[1]: <https://mosquitto.org/>
