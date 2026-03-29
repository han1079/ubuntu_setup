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
mkdir -p "$NVIM_CONF"

echo "Copying lua config files..."
cp "$SCRIPT_DIR/nvim_lua_files/init.lua" "$NVIM_CONF/init.lua"
cp "$SCRIPT_DIR/nvim_lua_files/lazy-lock.json" "$NVIM_CONF/lazy-lock.json"
cp -r "$SCRIPT_DIR/nvim_lua_files/lua" "$NVIM_CONF/lua"

echo ""
echo "=== Lazy restore ==="
echo "Running headless :Lazy restore to install pinned plugin versions..."
nvim --headless "+Lazy restore" +qa

echo ""
echo "=== setup.sh done ==="
echo "Open alacritty and launch nvim."
