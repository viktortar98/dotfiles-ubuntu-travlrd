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

ensure_cmd_path() {
  local cmd="$1"
  local dir="$2"

  if command -v "$cmd" >/dev/null 2>&1; then
    return 0
  fi

  if [ -n "$dir" ] && [ -x "$dir/$cmd" ]; then
    export PATH="$dir:$PATH"
  fi
}

check_cmd git
check_cmd rg
check_cmd zoxide
check_cmd fzf
check_cmd bat
check_cmd fd
check_cmd jq
check_cmd tldr
check_cmd htop
check_cmd bun
check_cmd fnm
check_cmd pnpm

deno_install_root="${DENO_INSTALL:-$HOME/.deno}"
ensure_cmd_path deno "$deno_install_root/bin"

check_cmd deno
check_cmd ni
check_cmd vercel
check_cmd micro
check_cmd java

android_sdk_root="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-$HOME/.android/sdk}}"
ensure_cmd_path adb "$android_sdk_root/platform-tools"
ensure_cmd_path sdkmanager "$android_sdk_root/cmdline-tools/latest/bin"

check_cmd adb
check_cmd sdkmanager

printf '\nVersions:\n'
git --version || true
rg --version || true
zoxide --version || true
fzf --version || true
bat --version || true
fd --version || true
jq --version || true
tldr --version || true
htop --version || true
bun --version || true
fnm --version || true
pnpm --version || true
deno --version || true
ni --version || true
vercel --version || true
micro --version || true
java -version || true
adb version || true
sdkmanager --version || true

if command -v fnm >/dev/null 2>&1; then
  printf '\nNode runtime (fnm):\n'
  fnm current || true
  fnm list || true
fi

if command -v adb >/dev/null 2>&1; then
  printf '\nAndroid devices:\n'
  if command -v pgrep >/dev/null 2>&1 && pgrep -x adb >/dev/null 2>&1; then
    adb devices -l || true
  else
    printf 'adb daemon not running; run `adb devices -l` manually when needed\n'
  fi
fi
