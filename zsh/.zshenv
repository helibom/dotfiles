source $HOME/.profile

. "$HOME/.cargo/env"
export NODE_OPTIONS=--use-openssl-ca

# Lua language server for neovim
export PATH=$PATH:$HOME/.local/language-servers/lua.ls
