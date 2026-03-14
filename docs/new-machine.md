# New Machine Setup

## Scope

- Android emulator is intentionally out of scope.
- Project secrets are intentionally out of scope.

## WSL laptop flow

1. Install Ubuntu 24.04 in WSL.
2. Clone this repo to `~/dotfiles`.
3. Run `./bootstrap.sh`.
4. Restart shell.
5. Run `./verify.sh`.
6. Confirm `~/.agents/AGENTS.md` and `~/templates/AGENTS.md` exist if you use AI coding tools.

## Native Ubuntu desktop flow

1. Install Ubuntu 24.04.
2. Clone this repo to `~/dotfiles`.
3. Run `./bootstrap.sh`.
4. Restart shell.
5. Run `./verify.sh`.
6. Confirm `~/.agents/AGENTS.md` and `~/templates/AGENTS.md` exist if you use AI coding tools.

## Android device debugging in WSL

1. On Windows, attach USB with `usbipd`.
2. In WSL, run `adb devices` and confirm the device is visible.
