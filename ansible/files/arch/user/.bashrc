#!/bin/bash

CLICOLOR=1
# shellcheck disable=SC2016
LESS='-R --use-color -Dd+r$Du+b$'
LSCOLORS="Ea"
PS1="[\[$(tput sgr0)\]\[\033[38;5;33m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;160m\]\H\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;46m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]{\[$(tput sgr0)\]\[\033[38;5;57m\]\$?\[$(tput sgr0)\]\[\033[38;5;15m\]} \[$(tput sgr0)\]"
PATH=$PATH:/home/duchess/.local/bin

# shellcheck disable=SC1091
if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

export CLICOLOR
export LESS
export LSCOLORS
export PS1
export PATH

if [ ! -f /usr/bin/yay ]; then
  cd || true
  git clone https://aur.archlinux.org/yay.git Documents/src/aur.archlinux.org/yay
  cd Documents/src/aur.archlinux.org/yay || true
  makepkg -si --noconfirm
fi

if [ ! -f /usr/bin/node ]; then
  yay -S npm
fi

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  git clone git@github.com:bryant/neovim.git "$HOME/Documents/src/github.com/bryant/neovim"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall
fi

if [ ! -f /usr/bin/xsel ]; then
  yay -Sy --noconfirm xsel
fi
if [ ! -f /usr/bin/node ]; then
  yay -S npm
fi

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  git clone git@github.com:bryant/neovim.git "$HOME/Documents/src/github.com/bryant/neovim"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall
fi

if [ ! -f /usr/bin/xsel ]; then
  yay -Sy --noconfirm xsel
fi

if [ -f /usr/bin/xsel ]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
