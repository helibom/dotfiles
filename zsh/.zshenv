source $HOME/.profile

export MANPAGER='nvim +Man!'

. "$HOME/.cargo/env"

# Lua language server for neovim
export PATH=$PATH:$HOME/.local/language-servers/lua.ls
