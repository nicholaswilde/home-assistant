---
tags:
  - add-on
---
# ![zwave](https://cdn.jsdelivr.net/gh/selfhst/icons/png/z-wave-js-ui.png){ width="32" } Z-Wave JS UI

## :hammer_and_wrench: Hardware

- [Zooz 800 Series Z-Wave Long Range S2 USB Stick ZST39 LR][2]
- [Aeotec Range Extender 7 (Z-Wave)][3]

## :gear: Config

!!! example ""

    :material-console-network: Default Port: `3000`

!!! code "Find USB device ID"

    ```shell
    sudo ls -la /dev/serial/by-id
    ```

    ```shell title="Output"
    /dev/serial/by-id/usb-Zooz_800_Z-Wave_Stick_533D004242-if00
    ```

Add the device ID to `devices`.

??? abstract "compose.yaml"

    ```yaml
    --8<-- "compose.yaml:zwave-js-ui"
    ```

### ![ha](https://cdn.jsdelivr.net/gh/selfhst/icons/png/home-assistant.png){ width="20" } Home Assistant

!!! note

    The hostname in the URL should match the container name of Z-Wave JS.

!!! example ""

    === "URL"
    
        ```
        ws://zwave-js-ui:3000
        ```


## :link: References

- <https://zwave-js.github.io/zwave-js-ui/>
- <https://www.home-assistant.io/integrations/zwave_js/>

[1]: <https://zwave-js.github.io/zwave-js-ui/>
[2]: <https://www.amazon.com/dp/B0BW171KP3>
[3]: <https://www.amazon.com/gp/product/B081G97TLB/>
