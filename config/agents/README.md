# Agent Config

Track only non-secret baseline settings in this directory.

Contents:
- `base-config.toml`: Safe baseline agent tool config.
- `AGENTS.md`: Global agent rules installed to `~/.agents/AGENTS.md`.
- `workflows/`: Opt-in workflow overlays installed to `~/.agents/workflows/`.
- `prompts/`: Reusable workflow prompts installed to `~/.agents/prompts/`.
- `workflow-templates/`: Reusable workflow templates installed to `~/.agents/templates/`.
- `templates/`: Per-project `AGENTS.md` and `AGENTS.local.md` starter templates installed to `~/templates/`.

Do not commit API keys, auth tokens, machine ids, or credentials.
