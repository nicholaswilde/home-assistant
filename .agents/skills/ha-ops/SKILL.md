---
name: ha-ops
description: Validate Home Assistant config, SSH to Raspberry Pi 4 to pull and update, and manage Docker Compose services via Taskfile. Trigger: /ha-ops, "update home assistant", "check ha config", "restart home assistant", "ha core check", "task up-d".
---

# Home Assistant Operations Skill

Verify configuration and manage Home Assistant, ESPHome, Mosquitto, RTL_433, and Z-Wave JS UI containers via `task`.

## Protocol

1. **Remote Raspberry Pi 4 Update (when running from another host)**:
   SSH to Pi 4, enter repo, pull latest changes, and update:

   ```bash
   ssh nicholas@192.168.1.88 'cd /home/nicholas/git/nicholaswilde/home-assistant && git pull && task update'
   ```

   (Or run `task upgrade`, which executes `git pull origin` followed by `task update`.)

2. **Verify Home Assistant configuration before restarting**:

   ```bash
   docker compose exec homeassistant ha core check
   ```

3. **Standard container operations**:

   ```bash
   task ps          # List relevant containers
   task up-d        # Start stack in background
   task restart     # Restart containers
   task update      # Recreate/build containers and prune images
   task logs:ha     # Tail Home Assistant logs
   task logs:rtl433 # Tail RTL_433 logs
   task watch       # Follow all compose logs
   ```

4. **Container shells**:

   ```bash
   task bash-ha
   task bash-esphome
   task bash-wyze-bridge
   ```

5. **Commit changes**:
   - Run `task enc` if any secret file changed.
   - Use Conventional Commits (e.g., `fix: correct mqtt sensor topic (Fixes #123)`).
