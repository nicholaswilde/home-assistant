---
tags:
  - add-on
---
# ![mosquitto](https://cdn.jsdelivr.net/gh/selfhst/icons/png/mosquitto.png){ width="32" } Eclipse Mosquitto

[Eclipse Mosquitto][1] is an open source (EPL/EDL licensed) message broker that implements the MQTT protocol. 

I use it to extract devices from [`rtl_433`](./rtl_433.md).

## :gear: Config

!!! example ""

    :material-console-network: Web port: `9001`
    
    :material-console-network: Interface port: `1883`

    User: `mosquitto`

    UID: `1883`

    Group: `mosquitto`

    GID: `1883`

??? abstract "compose.yaml"

    ```yaml
    --8<-- "compose.yaml:mosquitto"
    ```

### :closed_lock_with_key: Permissions

By default, the `eclipse-mosquitto` Docker image is run using the `mosquitto:mosquitto` `1883:1883` `user` and `group`.

To be able to edit the config file using the current user on the host, the mosquitto group needs to be added to the host system and the host user needs to be added to the group.

!!! code "Add the mosquitto group"

    ```shell
    sudo groupadd -g 1883 mosquitto
    ```

!!! code "Add current user to the mosquitto group"

    ```shell
    sudo usermod -aG mosquitto $(whoami)
    ```

!!! success "Check"

    ```shell
    cat /etc/group | grep 1883
    ```

    ```shell title="Output"
    mosquitto:x:1883:username
    ```

### :file_folder: Setup Directories

!!! code "Make directories"

    ```shell
    mkdir -p ./mosquitto/config ./mosquitto/data ./mosquitto/log
    ```

!!! code "Grant group write"

    ```shell
    sudo chmod -R g+w ./mosquitto
    ```

!!! code "Change folder permissions"

    ```shell
    sudo chown -R 1883:1883 ./mosquitto
    ```
  
### :lock: Credentials

Generate `username` and `password` for mosquitto.

!!! code "./mosquitto/config/password.txt"

    === "Automatic"

        ```shell
        sudo touch ./mosquitto/config/password.txt
        docker run -it --rm -v $PWD/mosquitto/config/password.txt:/mosquitto/config/password.txt eclipse-mosquitto -- mosquitto_passwd -c /mosquitto/config/password.txt username
        ```

    === "Manual"
    
        ```shell
        sudo touch ./mosquitto/config/password.txt
        docker exec -it -v $PWD/mosquitto/config/password.txt:/mosquitto/config/password.txt mosquitto sh
        ```

        ```shell
        mosquitto_passwd -c /mosquitto/config/password.txt username
        chown root:root /mosquitto/config/password.txt
        exit 
        ```

!!! code "Change permissions again"

    ```shell
    sudo chown -R 1883:1883 ./mosquitto
    ```

!!! success "Check"

    ```shell
    sudo cat ./mosquitto/config/password.txt
    ```

    ```shell title="Output"
    username:$7$101$o0s01iFdr/lPCuvc$HEUdUhd50k212ZV/B9bjLYb/iKC6R+4srHgVz+3LbIebVavtD+5uRumiEOZGZOdy5LNq/siDdlxXxomOM8u3jA==
    ```

### ![ha](https://cdn.jsdelivr.net/gh/selfhst/icons/png/home-assistant.png){ width="16" } Home Assistant

!!! note

    The `Broker` should match the container name of Eclipse Mosquitto and the `username` and `password` should match the generated ones above.

!!! example ""

    === "MQTT"
    
        Broker: `mosquitto`

        Port: `1883`

        Username: `username`

        Password: `password`

## :link: References

- <https://mosquitto.org/>
- <https://www.home-assistant.io/integrations/mqtt/>

[1]: <https://mosquitto.org/>
