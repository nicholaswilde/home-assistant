# ![zwave](https://cdn.jsdelivr.net/gh/selfhst/icons/png/z-wave-js-ui.png){ width="32" } Z-Wave JS UI

## :hammer_and_wrench: Hardware

- [Zooz 800 Series Z-Wave Long Range S2 USB Stick ZST39 LR][2]
- [Aeotec Range Extender 7 (Z-Wave)][3]

## :gear: Config

!!! example ""

    :material-console-network: Default Port: `3000`

!!! code ""

    ```shell
    ls /dev/serial/by-id
    ```

    ```shell
    # Output
    /dev/serial/by-id/usb-Zooz_800_Z-Wave_Stick_533D004242-if00
    ```
    
??? abstract "compose.yaml"

    ```yaml
    --8<-- "compose.yaml:zwave-js-ui"
    ```

### ![ha](){ width="32" } Home Assistant

WIP

## :link: References

- <https://zwave-js.github.io/zwave-js-ui/>

[1]: <https://zwave-js.github.io/zwave-js-ui/>
[2]: <https://www.amazon.com/dp/B0BW171KP3>
[3]: <https://www.amazon.com/gp/product/B081G97TLB/>
