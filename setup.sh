#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Cargo must be on PATH
if ! command -v cargo &>/dev/null; then
  if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
  else
    echo "ERROR: cargo not found. Run bootstrap.sh first."
    exit 1
  fi
fi

if ! grep -q '\.cargo/env' "$HOME/.bashrc" 2>/dev/null; then
  echo "Adding cargo/env to .bashrc"
  echo '. "$HOME/.cargo/env"' >> "$HOME/.bashrc"
fi

echo "=== Bob ==="
if ! command -v bob &>/dev/null; then
  echo "Installing bob..."
  cargo install bob-nvim
  export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
  if ! grep -q 'bob/nvim-bin' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"' >> "$HOME/.bashrc"
  fi
else
  echo "bob: ok"
  export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
fi

echo ""
echo "=== Neovim ==="
# Remove system nvim if it's not the bob-managed version
if command -v nvim &>/dev/null && [[ "$(command -v nvim)" != *"bob"* ]]; then
  echo "Removing conflicting system nvim..."
  sudo apt remove -y neovim 2>/dev/null || true
fi

if ! command -v nvim &>/dev/null; then
  echo "Installing nvim stable via bob..."
  bob install stable
  bob use stable
else
  echo "nvim: ok ($(nvim --version | head -1))"
fi

echo ""
echo "=== Nvim config ==="
NVIM_CONF="$HOME/.config/nvim"
NVIM_SRC="$SCRIPT_DIR/nvim_lua_files"
mkdir -p "$(dirname "$NVIM_CONF")"

if [ -L "$NVIM_CONF" ]; then
  CURRENT_TARGET="$(readlink -f "$NVIM_CONF")"
  EXPECTED_TARGET="$(readlink -f "$NVIM_SRC")"
  if [ "$CURRENT_TARGET" = "$EXPECTED_TARGET" ]; then
    echo "nvim config: symlink already correct"
  else
    echo "nvim config: symlink points to $CURRENT_TARGET; replacing"
    rm "$NVIM_CONF"
    ln -s "$NVIM_SRC" "$NVIM_CONF"
  fi
elif [ -e "$NVIM_CONF" ]; then
  BACKUP="$NVIM_CONF.bak.$(date +%Y%m%d%H%M%S)"
  echo "nvim config: existing dir found, backing up to $BACKUP"
  mv "$NVIM_CONF" "$BACKUP"
  ln -s "$NVIM_SRC" "$NVIM_CONF"
else
  echo "nvim config: creating symlink"
  ln -s "$NVIM_SRC" "$NVIM_CONF"
fi

echo ""
echo "=== pylsp ==="
if ! command -v pylsp &>/dev/null; then
  echo "Installing pylsp via pip..."
  if python3 -m pip install --break-system-packages python-lsp-server; then
    echo "pylsp: installed"
  else
    echo "WARNING: pylsp install failed."
    echo "  Option 1: python3 -m pip install --break-system-packages python-lsp-server"
    echo "  Option 2: download wheels from pypi.org/project/python-lsp-server/#files"
    echo "            then: python3 -m pip install --break-system-packages --no-index --find-links=./wheels python-lsp-server"
  fi
else
  echo "pylsp: ok"
fi

echo ""
echo "=== ruff ==="
if ! command -v ruff &>/dev/null; then
  echo "Installing ruff..."
  RUFF_URL="https://github.com/astral-sh/ruff/releases/latest/download/ruff-x86_64-unknown-linux-gnu.tar.gz"
  if curl -fsSL "$RUFF_URL" | tar -xz --strip-components=1 -C "$HOME/.local/bin" 2>/dev/null; then
    echo "ruff: installed"
  else
    echo "WARNING: ruff install failed."
    echo "  Option 1: curl -fsSL <url> | tar -xz -C ~/.local/bin ruff"
    echo "  Option 2: download ruff-x86_64-unknown-linux-gnu.tar.gz from"
    echo "            github.com/astral-sh/ruff/releases"
    echo "            then: tar -xz -C ~/.local/bin ruff -f ruff-x86_64-unknown-linux-gnu.tar.gz"
  fi
else
  echo "ruff: ok"
fi

echo ""
echo "=== Lazy restore ==="
echo "Running headless :Lazy restore to install pinned plugin versions..."
nvim --headless "+Lazy restore" +qa

echo ""
echo "=== setup.sh done ==="
echo "Open alacritty and launch nvim."
