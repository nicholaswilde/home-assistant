---
name: sops-secrets
description: Encrypt and decrypt SOPS/Age secret files via Taskfile tasks before running or committing. Trigger: /sops-secrets, "encrypt secrets", "decrypt secrets", "task enc", "task dec".
---

# SOPS Secrets Skill

Manage Age-encrypted secrets across Home Assistant, ESPHome, Z-Wave JS UI, and Docker environment files.

## Encrypted Files

- `./ha/secrets.yaml` <-> `./ha/secrets.yaml.enc`
- `./ha/html5_push_registrations.conf` <-> `./ha/html5_push_registrations.conf.enc`
- `./esphome/secrets.yaml` <-> `./esphome/secrets.yaml.enc`
- `./zwave/settings.json` <-> `./zwave/settings.json.enc`
- `./.env` <-> `./.env.enc`

## Protocol

1. **Decrypt before running services**:

   ```bash
   task dec
   ```

2. **Encrypt after editing any secret file**:

   ```bash
   task enc
   ```

3. **Inspect public Age key**:

   ```bash
   task show-pub-key
   ```

4. **Verify before commit**:
   - Check `rtk git status` to ensure no plaintext secret files are untracked/staged.
   - Stage only `.enc` files explicitly (never `git add .` or `git add -A`).
   - Use Conventional Commits with `Fixes #<number>` when closing an issue.
