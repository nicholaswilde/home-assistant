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

    ```shell title="Host"
    sudo groupadd -g 1883 mosquitto
    ```

!!! code "Add current user to the mosquitto group"

    ```shell title="Host"
    sudo usermod -aG mosquitto $(whoami)
    ```

!!! success "Check"

    ```shell title="Host"
    cat /etc/group | grep 1883
    ```

    ```shell title="Output"
    mosquitto:x:1883:username
    ```

### :file_folder: Setup Directories

!!! code "Make directories"

    ```shell title="Host"
    mkdir -p ./mosquitto/config ./mosquitto/data ./mosquitto/log
    ```

!!! code "Grant group write"

    ```shell title="Host"
    sudo chmod -R g+w ./mosquitto
    ```

!!! code "Change folder permissions"

    ```shell title="Host"
    sudo chown -R 1883:1883 ./mosquitto
    ```
  
### :lock: Credentials

Generate `username` and `password` for mosquitto.

!!! code "./mosquitto/config/password.txt"

    ```shell title="Host"
    sudo touch ./mosquitto/config/password.txt
    docker compose up mosquitto -d
    ```
    
    === "Host"

        ```shell title="Host"
        docker exec -it mosquitto mosquitto_passwd -c /mosquitto/config/password.txt username
        ```

    === "Docker container"
    
        ```shell title="Host"
        docker exec -it mosquitto sh
        ```

        ```shell title="Docker container"
        mosquitto_passwd -c /mosquitto/config/password.txt username
        chown root:root /mosquitto/config/password.txt
        exit 
        ```

!!! code "Change permissions again"

    ```shell title="Host"
    sudo chown -R 1883:1883 ./mosquitto
    ```

!!! success "Check"

    === "Host"
    
        ```shell
        sudo cat ./mosquitto/config/password.txt
        ```
    === "Docker container"

        ```shell
        docker exec -it mosquitto cat /mosquitto/config/password.txt
        ```


    ```shell title="Output"
    username:$7$101$o0s01iFdr/lPCuvc$HEUdUhd50k212ZV/B9bjLYb/iKC6R+4srHgVz+3LbIebVavtD+5uRumiEOZGZOdy5LNq/siDdlxXxomOM8u3jA==
    ```

!!! code "Stop the container"

    ```shell title="Host"
    docker compose down mosquitto
    ```

!!! success "Check that it's not running"

    ```shell title="Host"
    docker container ps
    ```

    ```shell title="Output"
    CONTAINER ID    IMAGE    COMMAND    CREATED   STATUS  PORTS   NAMES

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
