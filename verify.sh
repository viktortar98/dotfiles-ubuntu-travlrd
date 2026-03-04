#!/usr/bin/env bash
set -euo pipefail

check_cmd() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    printf '[ok] %s\n' "$cmd"
  else
    printf '[missing] %s\n' "$cmd"
    return 1
  fi
}

check_cmd git
check_cmd rg
check_cmd bun
check_cmd fnm
check_cmd deno
check_cmd ni
check_cmd java

if ! command -v adb >/dev/null 2>&1 && [ -x "$HOME/.android/sdk/platform-tools/adb" ]; then
  export PATH="$HOME/.android/sdk/platform-tools:$PATH"
fi

check_cmd adb

printf '\nVersions:\n'
git --version || true
rg --version || true
bun --version || true
fnm --version || true
deno --version || true
ni --version || true
java -version || true
adb version || true

if command -v fnm >/dev/null 2>&1; then
  printf '\nNode runtime (fnm):\n'
  fnm current || true
  fnm list || true
fi

if command -v adb >/dev/null 2>&1; then
  printf '\nConnected Android devices:\n'
  adb devices || true
fi
