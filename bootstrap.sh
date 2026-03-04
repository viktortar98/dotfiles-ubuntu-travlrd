#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANSIBLE_DIR="$ROOT_DIR/ansible"

if ! command -v sudo >/dev/null 2>&1; then
  printf 'sudo is required but not available\n' >&2
  exit 1
fi

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo apt-get update
sudo apt-get install -y ansible-core git curl unzip ca-certificates

if [ -f "$ANSIBLE_DIR/requirements.yml" ]; then
  ansible-galaxy collection install -r "$ANSIBLE_DIR/requirements.yml"
fi

ansible-playbook -i "$ANSIBLE_DIR/inventory.ini" "$ANSIBLE_DIR/playbook.yml"

printf '\nBootstrap complete. Run ./verify.sh next.\n'
