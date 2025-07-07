# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's "app" directory if it exists
if [ -d "$HOME/.apps" ] ; then
    PATH="$HOME/.apps:$PATH"
fi

. "$HOME/.cargo/env"

export PATH=$PATH:/home/helibom/.local/bin

# Golang to PATH
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go

export EDITOR="/usr/bin/nvim"

export ZSH_TMUX_CONFIG=/home/helibom/.config/tmux/tmux.conf

# Export dev script dir to PATH
export PATH=$PATH:/home/helibom/dev/scripts

# pnpm
export PNPM_HOME="/home/helibom/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun
[ -s "/home/helibom/.bun/_bun" ] && source "/home/helibom/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "/home/helibom/.deno/env"
# bun end

# Windows Sublime Text Path
export PATH=$PATH:"/mnt/c/Program Files/Sublime Text/subl.exe"

# Fly.io CLI (hosting service)
export FLYCTL_INSTALL="/home/helibom/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Flatpak apps?
export XDG_DATA_DIRS=$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share
. "/home/helibom/.deno/env"

# Append .NET paths
export PATH=$PATH:$HOME/.dotnet/

# Append LuaRocks executable paths
export PATH=$PATH:$HOME/.local/share/nvim/lazy-rocks/hererocks/bin/


# direnv
# export DIRENV_LOG_FORMAT=$'\033[2mdirenv: %s\033[0m'
export DIRENV_LOG_FORMAT='' # silence
