#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== APT dependencies ==="
sudo apt-get update -qq
DEPS=(git curl unzip ripgrep xclip npm build-essential alacritty tmux)
for dep in "${DEPS[@]}"; do
  if ! command -v "$dep" &>/dev/null && ! dpkg -s "$dep" &>/dev/null 2>&1; then
    echo "Installing $dep..."
    sudo apt-get install -y "$dep"
  else
    echo "$dep: ok"
  fi
done

echo ""
echo "=== Cargo ==="
if ! command -v cargo &>/dev/null; then
  echo "Installing cargo via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  . "$HOME/.cargo/env"
else
  echo "cargo: ok"
fi

echo ""
echo "=== JetBrainsMono Nerd Font ==="
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
if ! fc-list | grep -q "JetBrainsMono"; then
  echo "Downloading..."
  curl -fLo /tmp/JetBrainsMono.zip \
    "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
  unzip -q /tmp/JetBrainsMono.zip -d "$FONT_DIR"
  fc-cache -fv
  echo "Font installed"
else
  echo "JetBrainsMono Nerd Font: ok"
fi

echo ""
echo "=== Alacritty config ==="
ALACRITTY_CONF_DIR="$HOME/.config/alacritty"
mkdir -p "$ALACRITTY_CONF_DIR"
if [ ! -f "$ALACRITTY_CONF_DIR/alacritty.toml" ]; then
  cat > "$ALACRITTY_CONF_DIR/alacritty.toml" <<'EOF'
[font]
normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
size = 13.0
EOF
  echo "Alacritty config written"
else
  echo "Alacritty config exists, skipping"
fi

echo ""
echo "=== Dotfiles ==="
cp "$SCRIPT_DIR/dotfiles/_bash_aliases" "$HOME/.bash_aliases"
cp "$SCRIPT_DIR/dotfiles/_profile" "$HOME/.profile"
cp "$SCRIPT_DIR/dotfiles/_tmux.conf" "$HOME/.tmux.conf"
cp "$SCRIPT_DIR/dotfiles/git-superstate" "$HOME/.local/bin/git-superstate"
chmod +x "$HOME/.local/bin/git-superstate"
echo "Dotfiles copied"

if ! grep -q '\.bash_aliases' "$HOME/.bashrc" 2>/dev/null; then
  echo -e '\n[ -f ~/.bash_aliases ] && . ~/.bash_aliases' >> "$HOME/.bashrc"
  echo "Added .bash_aliases source to .bashrc"
fi

echo ""
echo "=== bootstrap.sh done ==="
echo "Run: source ~/.cargo/env && ./setup.sh"
