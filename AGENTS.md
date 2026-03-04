# Dotfiles Agent Guide

This file is the policy contract for AI agents editing this repo.

## Purpose

- Manage workstation setup as code for WSL Ubuntu and native Ubuntu.
- This is machine provisioning, not project/application provisioning.
- The source of truth is this repository (Ansible + tracked config).

## Scope Guardrails

- Keep Android support to physical-device workflows; no emulator automation.
- Do not add project-level secret management.
- Keep the repo private and avoid expanding secret surface area.
- Default workspace root for cloned repos is `~/gh`.

## Drift Prevention

- If a machine tweak is made manually, codify it here immediately.
- Prefer idempotent tasks; second run should be mostly no-op.
- Do not change defaults silently; document behavior/policy changes.
- Keep platform boundaries clean:
  - WSL specifics in `wsl` role
  - Native desktop specifics in `ubuntu_desktop`
  - Shared logic in shared roles

## Security Rules

- Never commit credentials, tokens, keys, or machine-specific secrets.
- Track only safe baseline configs; keep private overrides untracked.
- For risky, destructive, or scope-expanding changes: stop and ask the user first.

## Execution Contract

- `bootstrap.sh` must remain the fresh-machine entrypoint.
- `bootstrap.sh` installs required dependencies itself.
- `verify.sh` validates critical tooling and expected environment state.
- Run `./bootstrap.sh` after making changes that affect it. Since sudo may be required, ask the user to run it for you.

## Agent Workflow

1. Always run `git pull` before making any changes to ensure you have the latest state.
2. Implement changes in repo, not ad-hoc on the machine.
3. Run relevant syntax/lint/consistency checks.
4. Run bootstrap/verify when behavior is affected.
5. Re-run to confirm idempotence.
6. Update docs when policy or default behavior changes.
7. Commit changes with a descriptive message and push to remote.
8. Ensure git state is clean when finished; commit any existing uncommitted changes.
