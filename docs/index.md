---
# :house_with_garden: Home Assistant :robot:
[![task](https://img.shields.io/badge/Task-Enabled-brightgreen?style=for-the-badge&logo=task&logoColor=white)](https://taskfile.dev/#/)
[![ci](https://img.shields.io/github/actions/workflow/status/nicholaswilde/home-assistant/ci.yaml?label=ci&style=for-the-badge&branch=main)](https://github.com/nicholaswilde/home-assistant/actions/workflows/ci.yaml)

My [Home Assistant][19] backup.

## :rocket: TL;DR

!!! code

    === "Task"

        ```
        task up-d
        ```

    === "Manual"

        ```
        cp .env.tmpl .env
        # Update .env
        # Update .sop.yaml to include the age public key id
        docker compose up -d
        ```

## :frame_with_picture: Background

My home automation journey has been quite long. I started off with a z-wave stick that used with a software package that I can't remember.

### ![st](){ width="20" }SmartThings

I then moved over to SmartThings when it was first created as a Kickstarter project. That opened my world into home automation and my investment into devices.

Creating custom devices was a bit difficult due to the programming language.

After SmartThings was bought by Samsung, I didn't do much with home automation.

### ![ha](https://cdn.jsdelivr.net/gh/selfhst/icons/png/home-assistant.png){ width="20" } Home Assistant

I started using Home Assistant for all of it's third party integrations. I kept my z-wave and zigbee devices on SmartThings and integrated SmartThings and Home Assistant together.

I've since moved over to Home Assistant completely, which has been great and pretty seamless.

## :scales: License

​[​Apache License 2.0](https://raw.githubusercontent.com/nicholaswilde/home-assistant/refs/heads/main/docs/LICENSE)

## :pencil:​Author

​This project was started in 2023 by [​Nicholas Wilde​][2].

## :link: References

- <https://docs.techdox.nz/>

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
