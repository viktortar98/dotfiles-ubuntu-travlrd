# Agent Config

Track only non-secret baseline settings in this directory.

Contents:
- `base-config.toml`: Safe baseline agent tool config.
- `AGENTS.md`: Global agent rules installed to `~/.agents/AGENTS.md`.
- `protocols/`: Opt-in protocol overlays installed to `~/.agents/protocols/`.
- `prompts/`: Reusable protocol prompts installed to `~/.agents/prompts/`.
- `protocol-templates/`: Reusable protocol templates installed to `~/.agents/templates/`.
- `templates/`: Per-project `AGENTS.md` and `AGENTS.local.md` starter templates installed to `~/templates/`.

Do not commit API keys, auth tokens, machine ids, or credentials.
