# Agent Skills Catalog

Catalog of custom Antigravity agent skills available in `home-assistant`.

| Skill | Description | Task / Command |
|---|---|---|
| [`docs-build`](skills/docs-build/SKILL.md) | Build and serve MkDocs Material documentation and lint Markdown | `task build` / `task serve` |
| [`ha-ops`](skills/ha-ops/SKILL.md) | Validate Home Assistant config and manage Docker Compose services | `task up-d` / `ha core check` |
| [`sops-secrets`](skills/sops-secrets/SKILL.md) | Encrypt and decrypt SOPS/Age secret files | `task enc` / `task dec` |
