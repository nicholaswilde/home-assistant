---
tags:
  - hardware
---
# :hammer_and_wrench: &nbsp; Hardware

## :computer: Intel NUC

I used to run HA on a bare-metal NUC running Ubuntu Server, but a lot of computing potential was wasted on the NUC.

## ![rpi](https://cdn.jsdelivr.net/gh/selfhst/icons/png/raspberry-pi.png){ width="24" } [Raspberry Pi 4 8GB][12]

I have since moved over to a dedicated Raspberry Pi 4 8GB running Raspberry Pi OS. This, too, may be underutilized.

This is a repurposed Raspberry Pi.

## ![ha](https://cdn.jsdelivr.net/gh/selfhst/icons/png/home-assistant.png){ width="24" } [Home Assistant Yellow][21]

I know that that the Home Assistant Yellow exists, but just haven't looked into it.

## :bulb: Devices

- [SkyConnect (ZigBee)][13]
- [NooElec NESDR Mini 2 SDR & DVB-T USB Stick (RTL2832 + R820T2)][16]
- [Aeotec Range Extender 7 (Z-Wave)][10]
- [Minoston Z-Wave Outlet Mini Plug-in Socket][7]
- [Innr Zigbee Smart Plugs][2]
- [GE Enbrighten Z-Wave Plus Smart Light Switch][1]
- [Enbrighten 14298 Z-Wave Plus Plug-In Outdoor Smart Switch, Gen5][3]
- [Aeotec Recessed Door Sensor Gen5][4]
- [GE 12730 Z-Wave Smart Fan Control][5]
- [Aeon Labs Aeotec Z-Wave Door/Window Sensor, 2nd Edition][6]
- [Aqara Door and Window][8]
- [Enbrighten Zigbee Smart Light Switch Outdoor Plug-In][9]

## Qingping Air Monitor Pro 2 CGS2

I use the [Qingping integration](https://github.com/mash2k3/qingping_cgs1) via MQTT.

### Enabling Local MQTT

To enable local MQTT on the air monitor, follow these instructions (based on [mash2k3/qingping_cgs1](https://github.com/mash2k3/qingping_cgs1/blob/main/enableMQTT.md)):

**Option 1: Contact Support**

Contact `support@qingping.co` and request the "Privatization function". Provide your device's MAC address and MQTT details. After they reply, factory reset the device.

**Option 2: Self-Configuration**

1. Ensure firmware is at least `4.1.8_0267`.
2. Pair the device using the "Qingping+ App" or "Qingping IoT App".
3. Log in to the [Qingping Developer Platform](https://developer.qingping.co/login).
4. Go to 'Private Access Config' -> 'Configurations' and create a new configuration with your MQTT details.
5. Go to 'Private Access Config' -> 'Device', add your device, and select the configuration.
6. Reboot the device if necessary.

**Important:** The user name and password set in the [Access Configuration](https://developer.qingping.co/private/access-configuration) must match the `RTL_USER` and `RTL_PASS` variables in your `.env` file (or `compose.yaml`).

### Home Assistant Configuration

In the MQTT integration configuration:
1. Listen to MQTT devices using the `#` wildcard to discover the device.
2. Then listen to the `qingping#` topic to subscribe to the device topics.

## :link: References

[1]: <https://www.amazon.com/gp/product/B01M1AHC3R/>
[2]: <https://www.amazon.com/gp/product/B07SQGG8Z7/>
[3]: <https://www.amazon.com/gp/product/B07VFQBBJS>
[4]: <https://www.amazon.com/gp/product/B0151Z49BO>
[5]: <https://www.amazon.com/gp/product/B00PYMGVVQ>
[6]: <https://www.amazon.com/gp/product/B00DJALAIE/>
[7]: <https://www.amazon.com/gp/product/B08LN2NPZ3/>
[8]: <https://www.amazon.com/gp/product/B09TP7VMKB/>
[9]: <https://www.amazon.com/gp/product/B0842B57S3/>
[10]: <https://www.amazon.com/gp/product/B081G97TLB/>
[12]: <https://www.amazon.com/Intel-NUC-10-Performance-Kit/dp/B083GGZ6TG/>
[13]: <https://www.seeedstudio.com/Home-Assistant-SkyConnect-p-5479.html>
[14]: <https://github.com/getsops/sops>
[15]: <https://ui-lovelace-minimalist.github.io/UI/>
[16]: <https://www.amazon.com/dp/B00P2UOU72>
[17]: <https://community.home-assistant.io/t/how-to-remove-unwanted-entities/433103/10>
[18]: <https://github.com/hertzg/rtl_433_docker/issues/14#issuecomment-868524131>
[19]: <https://www.home-assistant.io/>
[20]: <https://github.com/nicholaswilde/>
[21]: <https://www.home-assistant.io/yellow>
