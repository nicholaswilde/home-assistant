# Project Overview

This is a **Home Assistant** configuration repository, managing a smart home setup using **Docker Compose**. It integrates various services including Home Assistant Core, ESPHome, Mosquitto (MQTT), RTL_433, and Z-Wave JS UI.

Key Technologies:
*   **Home Assistant:** Core automation platform.
*   **Docker Compose:** Service orchestration.
*   **Task (go-task):** Automation of maintenance tasks (updates, secrets, logs).
*   **SOPS:** Secrets management using Age encryption.
*   **MkDocs:** Project documentation.

# Building and Running

The project relies heavily on `task` for management.

## Prerequisites
*   Docker & Docker Compose
*   [Task](https://taskfile.dev/)
*   [SOPS](https://github.com/getsops/sops)
*   [Age](https://github.com/FiloSottile/age) (for secrets)

## Initial Setup
1.  **Environment Variables:**
    ```bash
    cp .env.tmpl .env
    # Edit .env with appropriate values
    ```
2.  **Secrets Decryption:**
    Ensure you have the correct Age private key in `~/.config/sops/age/keys.txt`.
    ```bash
    task dec
    ```

## Running Services
*   **Start all services:**
    ```bash
    task up-d
    # OR
    docker compose up -d
    ```
*   **Watch logs:**
    ```bash
    task watch
    ```

## Maintenance
*   **Update containers:** `task update`
*   **Restart services:** `task restart`
*   **Stop services:** `task stop` or `task down`

# Development Conventions

## Directory Structure
*   `ha/`: Main Home Assistant configuration (YAML files, custom components, themes).
    *   Configuration is split into multiple files (e.g., `automations.yaml`, `sensors.yaml`) rather than a monolithic `configuration.yaml`.
*   `esphome/`: ESPHome device configurations (`.yaml` files).
*   `mosquitto/`: MQTT broker configuration and data.
*   `zwave/`: Z-Wave JS UI data and settings.
*   `docs/`: Documentation source files (Markdown).

## Secrets Management
**CRITICAL:** Never commit plain-text secrets.
*   Secrets are stored in files ending with `.enc` (e.g., `ha/secrets.yaml.enc`, `.env.enc`).
*   Use `task enc` to encrypt files before committing.
*   Use `task dec` to decrypt files for local usage.
*   Reference the `README.md` for specific SOPS commands if needed.

## Documentation
Documentation is built with `mkdocs-material`.
*   **Serve locally:** `task serve` (starts server on port 8000).
*   **Build:** `task build`.

## Automation
Always check `Taskfile.yml` for the standard way to perform actions.
