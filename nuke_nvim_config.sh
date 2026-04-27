#!/bin/bash
set -e
rm -rf ~/.local/share/nvim 
rm -rf ~/.local/state/nvim 
rm -rf ~/.cache/nvim 
rm -rf ~/.config/nvim

echo "Run ./setup.sh to restore configs and reinstall."
