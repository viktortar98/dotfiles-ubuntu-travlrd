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
- For repo-managed config, the default expectation is end-to-end execution in one turn: update the tracked source, deploy it to the current machine when applicable, verify it, and commit the result unless the user explicitly narrows scope.
- When adding a new tool: update Ansible role AND `verify.sh`.
- When modifying WSL config files (e.g., `.wslconfig`), copy the updated file to the Windows user home directory after changes.
- Run `./bootstrap.sh` after making changes that affect it. Since sudo may be required, ask the user to run it for you.
- Run `./verify.sh` to confirm tools are installed correctly.

## Request Interpretation

- If the user asks to correct or improve a tracked policy, workflow, template, or config file in this repo, treat that as a request to update the file in the repo source of truth, not just to discuss wording, unless the user clearly says they only want a draft or review.
- Do not stop at proposing text when the repo-managed artifact can be updated safely in the same turn.
- If a change affects a file that is deployed from this repo into the current machine, deploy the updated file after editing the tracked source unless the user says not to.
- If the user points out missed follow-through, treat that as an immediate instruction to complete the omitted execution steps, not as a request for explanation only.

## Session Learnings

- Save stable, project-specific meta-learnings discovered while doing tasks in this file.
- After completing a task, ask yourself exactly: `is there any meta-level information you had to figure out in this session about the task you did?`
- If the answer is yes, add the reusable project instruction or recurring task heuristic to this file in the same turn unless the user narrows scope.
- When changing agent workflows or prompts, check the full contract surface, not just the file named in the request. Relevant behavior may also live in `config/agents/prompts/`, `config/agents/workflows/`, and `config/agents/AGENTS.md`.
- Workflow changes under `config/agents/` should be deployed through the `agents` Ansible role, rerun to confirm idempotence, and verified with `./verify.sh` when installed artifacts changed.
- To run only the `agents` role locally, use a temporary playbook saved under `ansible/` with `ansible/inventory.ini`; feeding Ansible a playbook from `/dev/stdin` breaks this repo's `playbook_dir`-relative paths inside the role.

## Agent Workflow

1. Always run `git pull` before making any changes to ensure you have the latest state.
2. Implement changes in repo, not ad-hoc on the machine.
3. Run relevant syntax/lint/consistency checks.
4. Run bootstrap/verify when behavior is affected.
5. Re-run to confirm idempotence.
6. Update docs when policy or default behavior changes.
7. Commit changes with a descriptive message and push to remote.
8. Ensure git state is clean when finished; commit any existing uncommitted changes.
