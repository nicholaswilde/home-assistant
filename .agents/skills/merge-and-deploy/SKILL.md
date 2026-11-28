---
name: merge-and-deploy
description: Merge a GitHub PR by number into main, push, and update the remote Raspberry Pi Home Assistant instance. Trigger: /merge-and-deploy, "merge and deploy", "merge pr and update remote", "merge pr and deploy".
---

# Merge and Deploy Skill

Merge an open pull request into `main`, push to `origin`, verify PR state,
and update the remote Raspberry Pi 4 Home Assistant instance.

## Inputs

- `<pr_number>` (Required): Numeric GitHub PR identifier (e.g., `552`).
- `[--base <branch>]` (Optional): Target base branch (defaults to PR base
  branch, fallback `main`).
- `[--merge|--squash]` (Optional): Merge strategy (defaults to `--merge` /
  `--no-ff`).
- `[--host <user@host>]`, `[--dir <remote_dir>]` (Optional): Remote target
  overrides.
- `[--no-deploy]` (Optional): Merge and push only; skip remote update.

## Protocol

1. **Run merge and deploy script**:

   ```bash
   ./scripts/merge-and-deploy.sh <pr_number>
   ```

2. **Handle conflicts**:
   - **Exit `3` (local merge conflict)**: Inspect `git diff --name-only
     --diff-filter=U`, resolve conflict markers, stage resolved files, run
     `git commit --no-edit` and `rtk git push origin main`, then run
     `./scripts/update-remote.sh`.
   - **Exit `4` (remote stash pop conflict)**: Do NOT drop the stash on the
     remote host. SSH to the Pi, inspect `git stash list`, resolve
     `compose.yaml` / `ha/configuration.yaml` conflicts preserving local
     overrides (`network_mode: host`, packages), then run
     `docker compose config --quiet && task update`.

3. **Verify remote containers**:
   - Confirm updated image tag is `Up` in `docker ps` output.

   - If any container is `starting` or unhealthy, inspect logs:

     ```bash
     ssh nicholas@192.168.1.88 \
       'cd /home/nicholas/git/nicholaswilde/home-assistant && \
        docker compose logs --tail=20 <service>'
     ```

4. **Report terse summary**:
   - PR `#<pr_number>` merge/push/state, remote pull/stash status,
     `task update`, and running container statuses.
