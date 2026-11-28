---
name: update-remote
description: Safely pull latest main (preserving local overrides) and update Docker containers on the remote Raspberry Pi Home Assistant instance. Trigger: /update-remote, "update remote", "update remote instance", "deploy to pi", "update pi04".
---

# Update Remote Instance Skill

Pull latest changes on the remote Raspberry Pi 4 (`nicholas@192.168.1.88`),
preserve tracked local overrides (`compose.yaml` `network_mode: host`,
`ha/configuration.yaml`), validate Compose config, and run `task update`.

## Inputs

- `[--host <user@host>]` (Optional): Remote SSH target (default:
  `nicholas@192.168.1.88`).
- `[--dir <remote_dir>]` (Optional): Remote repository path (default:
  `/home/nicholas/git/nicholaswilde/home-assistant`).
- `[--branch <branch>]` (Optional): Branch to pull on remote (default: `main`).
- `[--skip-update]` (Optional): Pull, re-apply local overrides, and validate
  `docker compose config --quiet` without running `task update`.

## Protocol

1. **Run remote update script**:

   ```bash
   ./scripts/update-remote.sh
   ```

   The script stashes tracked local overrides (`compose.yaml`,
   `ha/configuration.yaml`), pulls `--ff-only`, pops the stash back, validates
   `docker compose config --quiet`, runs `task update`, and prints `docker ps`.

2. **Handle stash pop conflict (Exit `4`)**:
   - Never drop the remote stash.
   - SSH to `nicholas@192.168.1.88`, inspect `git stash list` in
     `/home/nicholas/git/nicholaswilde/home-assistant`, resolve conflicts while
     keeping Pi-specific overrides (`network_mode: host`), then run
     `docker compose config --quiet && task update`.

3. **Verify health**:
   - Confirm containers are `Up` in `docker ps` output; inspect
     `docker compose logs --tail=20 <service>` if any container is still
     starting or unhealthy.
