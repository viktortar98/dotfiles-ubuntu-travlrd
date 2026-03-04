# dotfiles

Ansible-managed Ubuntu setup for WSL and native Ubuntu desktop.

## Quick start

```bash
git clone <private-repo-url> ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
./verify.sh
```

## What's included

### Core tools
- **fnm**: Node version manager (floating LTS by default)
- **bun**: JavaScript runtime and package manager
- **deno**: Secure JavaScript/TypeScript runtime
- **pnpm**: Fast, disk space efficient package manager
- **corepack**: Package manager version manager (built into Node)

### CLI utilities
- **ripgrep (rg)**: Fast search
- **zoxide (z)**: Smart directory jumper
- **fzf**: Fuzzy finder
- **bat**: Better cat
- **fd**: Better find
- **jq**: JSON processor
- **tldr**: Simplified man pages
- **htop**: Better top
- **micro**: Terminal editor

### Development
- **Android SDK**: Command-line tools + platform-tools (no emulator)
- **OpenJDK 17**: For Android development
- **Git + gh**: Version control and GitHub CLI

## Configuration

### Node.js versioning

In `ansible/group_vars/all.yml`:

- `node_lts: "lts"` — always use latest LTS (default, recommended for workstation)
- `node_lts: "v22.14.0"` — pin exact version for reproducibility

For project-level reproducibility, use `.nvmrc` or `.node-version` files in your repositories.

### Package manager selection

Corepack automatically uses the correct package manager per project based on `packageManager` field in `package.json`:

```json
{
  "packageManager": "pnpm@10.17.0"
}
```

## Keeping up to date

### After changing your setup

```bash
cd ~/dotfiles
git add -A
git commit -m "Update setup"
git push
```

### On other machines

```bash
cd ~/dotfiles
git pull
./bootstrap.sh
```

## Setup on another computer

### WSL / Ubuntu desktop

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

### WSL-specific: Windows-side config

After bootstrap, copy WSL config to Windows:

```bash
cp ~/dotfiles/windows/.wslconfig /mnt/c/Users/<username>/
wsl --shutdown  # restart WSL to apply
```

### Android device debugging (WSL)

1. Install usbipd on Windows: `winget install dorssel.usbipd-win`
2. Attach USB device: `usbipd attach --wsl --busid <busid>`
3. Verify in WSL: `adb devices`

## Platform support

- **WSL2**: Fully supported
- **Ubuntu desktop**: Fully supported
- **macOS**: Possible but requires additional roles (Homebrew instead of apt)
- **Other Linux**: Should work with minor adjustments

## Philosophy

- **Floating versions for workstation**: Always latest LTS for good DX
- **Pinned versions per project**: Reproducible builds via `.nvmrc`, `package.json`
- **No emulator**: Physical device debugging only
- **No project secrets**: Only machine-level configuration
