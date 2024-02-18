#!/bin/bash

CLICOLOR=1
# shellcheck disable=SC2016
LESS='-R --use-color -Dd+r$Du+b$'
LSCOLORS="Ea"
PS1='[\[\e[38;5;196;1m\]\u\[\e[0m\]@\[\e[38;5;213;1m\]\H\[\e[0m\]:\w]{$?}\$ '
PATH="$PATH:/root/.local/bin"

# shellcheck disable=SC1091
if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

export CLICOLOR
export LESS
export LSCOLORS
export PS1
export PATH

if [ ! -f /usr/bin/node ]; then
  pacman -S npm
fi

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  git clone git@github.com:bryant/neovim.git "$HOME/Documents/src/github.com/bryant/neovim"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall
fi

if [ ! -f /usr/bin/xsel ]; then
  pacman -Sy --noconfirm xsel
fi

if [ -f /usr/bin/xsel ]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
