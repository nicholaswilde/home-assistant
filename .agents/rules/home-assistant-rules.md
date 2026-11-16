# Home Assistant Infrastructure Rules

## Operational Commands

- Always use `task` for standard operations (`task up-d`, `task restart`, `task update`, `task watch`, `task ps`, `task stop`, `task down`).
- Shell into containers via `task bash-ha` or `task bash-esphome`.
- Verify Home Assistant config before restarting: `docker compose exec homeassistant ha core check`.

## Secrets Management (SOPS + Age)

- **Encrypt before commit**: Run `task enc` after modifying `./ha/secrets.yaml`, `./ha/html5_push_registrations.conf`, `./esphome/secrets.yaml`, `./zwave/settings.json`, or `./.env`.
- **Decrypt before run**: Run `task dec` before starting services.
- **Never commit plaintext**: Keep `.env`, `secrets.yaml`, `html5_push_registrations.conf`, `zwave/settings.json`, and `password.txt` out of git. Always use `!secret` in YAML or env vars.

## YAML & Naming Conventions

- **Indentation**: 2 spaces, no tabs. Keep `ha/configuration.yaml` minimal; split domains via `!include`.
- **Entities**: Use `snake_case` IDs (`sensor.living_room_temperature`), Title Case friendly names (`Living Room Temperature`). Keep entity IDs stable.
- **Comments**: Explain complex template sensors, automations, or non-obvious config.

## Boundaries

- Ask before modifying `Taskfile.yml` or `compose.yaml` network/volume settings, adding services, bumping major service versions, or refactoring file layout.
- Commits closing GitHub issues must contain `Fixes #<number>`.
