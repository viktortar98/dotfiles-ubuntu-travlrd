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
check_cmd gh
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
check_cmd claude

android_sdk_root="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-$HOME/.android/sdk}}"
ensure_cmd_path adb "$android_sdk_root/platform-tools"
ensure_cmd_path sdkmanager "$android_sdk_root/cmdline-tools/latest/bin"

check_cmd adb
check_cmd sdkmanager

check_symlink() {
  local path="$1"
  local expected="$2"

  if [ -L "$path" ] && [ "$(readlink "$path")" = "$expected" ]; then
    printf '[ok] symlink %s -> %s\n' "$path" "$expected"
  else
    printf '[missing] symlink %s -> %s\n' "$path" "$expected"
    return 1
  fi
}

check_file() {
  local path="$1"

  if [ -f "$path" ]; then
    printf '[ok] file %s\n' "$path"
  else
    printf '[missing] file %s\n' "$path"
    return 1
  fi
}

check_contains_line() {
  local path="$1"
  local pattern="$2"

  if [ -f "$path" ] && rg -qx --fixed-strings "$pattern" "$path" >/dev/null 2>&1; then
    printf '[ok] %s contains %s\n' "$path" "$pattern"
  else
    printf '[missing] %s contains %s\n' "$path" "$pattern"
    return 1
  fi
}

check_file "$HOME/.agents/AGENTS.md"
check_file "$HOME/.agents/workflows/plan-build.md"
check_file "$HOME/.agents/workflows/incremental-audit.md"
check_file "$HOME/.agents/prompts/project-derived-incremental-audit.md"
check_file "$HOME/.agents/templates/vertical-slice-overview-template.md"
check_file "$HOME/.agents/templates/problem-log-template.md"
check_file "$HOME/templates/AGENTS.md"
check_file "$HOME/templates/AGENTS.local.md"
check_file "$HOME/.gitignore_global"

check_symlink "$HOME/.claude/CLAUDE.md" "$HOME/.agents/AGENTS.md"
check_symlink "$HOME/.config/opencode/AGENTS.md" "$HOME/.agents/AGENTS.md"
check_symlink "$HOME/.codex/AGENTS.md" "$HOME/.agents/AGENTS.md"

check_contains_line "$HOME/.gitignore_global" "AGENTS.local.md"

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
gh --version || true
bun --version || true
fnm --version || true
pnpm --version || true
deno --version || true
ni --version || true
vercel --version || true
micro --version || true
java -version || true
claude --version || true
adb version || true
sdkmanager --version || true

printf '\nGit config:\n'
git config --global --get core.excludesfile || true

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
