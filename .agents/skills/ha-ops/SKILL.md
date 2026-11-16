---
name: ha-ops
description: Validate Home Assistant config and manage Docker Compose services via Taskfile commands. Trigger: /ha-ops, "check ha config", "restart home assistant", "ha core check", "task up-d".
---

# Home Assistant Operations Skill

Verify configuration and manage Home Assistant, ESPHome, Mosquitto, RTL_433, and Z-Wave JS UI containers via `task`.

## Protocol

1. **Verify Home Assistant configuration before restarting**:

   ```bash
   docker compose exec homeassistant ha core check
   ```

2. **Standard container operations**:

   ```bash
   task ps          # List relevant containers
   task up-d        # Start stack in background
   task restart     # Restart containers
   task update      # Recreate/build containers and prune images
   task logs:ha     # Tail Home Assistant logs
   task logs:rtl433 # Tail RTL_433 logs
   task watch       # Follow all compose logs
   ```

3. **Container shells**:

   ```bash
   task bash-ha
   task bash-esphome
   task bash-wyze-bridge
   ```

4. **Commit changes**:
   - Run `task enc` if any secret file changed.
   - Use Conventional Commits (e.g., `fix: correct mqtt sensor topic (Fixes #123)`).
