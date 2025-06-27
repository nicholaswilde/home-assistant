---
tags:
  - add-on
---
# ![esphome](https://cdn.jsdelivr.net/gh/selfhst/icons/png/esphome.png){width="32"} ESPHome

[ESPHome][1] is used to connect my custom IoT devices to Home Assistant.

I prefer to use [ESP32][2] devices over [ESP8266][3].

## :gear: Config

!!! example ""

    :material-console-network: Default Port: `6052`

??? abstract "compose.yaml"

    ```yaml
    --8<-- "compose.yaml:esphome"
    ```

### ![ha](https://cdn.jsdelivr.net/gh/selfhst/icons/png/home-assistant.png){ width="16" } Home Assistant

!!! note

    The `Host` should match the container name of ESPHome.

!!! example ""

    === "ESPHome"
    
        Host: `esphome`

        Port: `6052`

## :bulb: Devices

### :hot_springs: Water Heater Monitor

I have added a device to monitor my water heater pilot to ensure that the pilot is still lit. I had an issue where my water heater thermocouple malfunctioned which caused my pilot light to go out.

## :link: References

- <https://esphome.io/>
- <https://www.home-assistant.io/integrations/esphome/>

[1]: <https://esphome.io/>
[2]: <https://en.wikipedia.org/wiki/ESP32>
[3]: <https://en.wikipedia.org/wiki/ESP8266>
