---
tags:
  - add-on
---
# ![mailrise](https://cdn.jsdelivr.net/gh/selfhst/icons/png/mailrise.png){ width="32" } Mailrise

[Mailrise][1] is an SMTP gateway for Apprise notifications. It allows you to send email notifications to a fake SMTP server, which then forwards them to your actual notification services via Apprise.

## :gear: Config

!!! example ""

    :material-console-network: SMTP Port: `8025`

    URL: `smtp://smtp.l.nicholaswilde.io:8025`

### ![ha](https://cdn.jsdelivr.net/gh/selfhst/icons/png/home-assistant.png){ width="16" } Home Assistant

Integrate Mailrise via the [SMTP integration][2].

!!! example "ha/notify.yaml"

    ```yaml
    - name: mailrise
      platform: smtp
      server: smtp.l.nicholaswilde.io
      port: 8025
      recipient: email@mailrise.xyz
      sender: home-assistant@nicholaswilde.io
      sender_name: Home Assistant
    ```

## :link: References

- <https://github.com/YoRyan/mailrise>
- <https://www.home-assistant.io/integrations/smtp/>

[1]: <https://github.com/YoRyan/mailrise>
[2]: <https://www.home-assistant.io/integrations/smtp/>
