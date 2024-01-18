#!/usr/bin/env bash

set -e

# Pull any changes
git pull

# Copy tmux config on machine to local repo
cp ~/.config/tmux/tmux.conf ./tmux/tmux.conf

# Copy .zshrc on machine to local repo 
cp ~/.zshrc ./zsh/.zshrc

# Copy neovim (NvChad) plugins and mappings config on machine to local repo
cp ~/.config/nvim/lua/custom/plugins.lua ./nvim/lua/custom/
cp ~/.config/nvim/lua/custom/mappings.lua ./nvim/lua/custom/

# Copy starship config on machine to local repo
cp ~/.config/starship.toml ./starship/starship.toml

# Push local repo to remote repo
git add .
git commit -m sync
git push -f --set-upstream origin main 
