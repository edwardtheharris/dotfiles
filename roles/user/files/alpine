#!/usr/bin/env bash

BASH_SILENCE_DEPRECATION_WARNING=1
CLICOLOR=1
GOPATH=/opt/go
LSCOLORS="Ea"
PATH="/usr/local/opt/python@3.7/bin:/opt/homebrew/sbin:/opt/homebrew/bin:$PATH:/usr/local/sbin"
PIPENV_VENV_IN_PROJECT=1

if [ -f "${HOME}/.gnupg/confluence-api-key.gpg" ]; then
  confluence_api_key="$(gpg -d -q "${HOME}"/.gnupg/confluence-api-key.gpg)"
  CONFLUENCE_SERVER_PASS=${confluence_api_key}
  export confluence_api_key
  export CONFLUENCE_SERVER_PASS
fi

if [ -f "${HOME}/.gnupg/wakatime-api-key.gpg" ]; then
  WAKATIME_API_KEY="$(gpg -d -q "${HOME}"/.gnupg/wakatime-api-key.gpg)"
  export WAKATIME_API_KEY
fi

# shellcheck disable=SC1091
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
  # shellcheck disable=SC1091
  . /usr/share/bash-completion/bash_completion
fi

if [[ "${TERM_PROGRAM/.app/}" == 'Apple_Terminal' ]]; then
  echo "${TERM_PROGRAM} is Apple Terminal"
  set +o history
  echo "History off."
else
  echo "${TERM_PROGRAM} is iTerm"
  set -o history
  echo "History on."
fi

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ -f /usr/bin/xsel ]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

if [[ "${HOME}" == "/root" ]]; then
  PS1="[\[$(tput sgr0)\]\[\033[38;5;1m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;2m\]\H\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;255m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]{\$?}\\$ \[$(tput sgr0)\]"
else
  PS1="[\[$(tput sgr0)\]\[\033[38;5;39m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;147m\]\H\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;255m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]{\$?}\\$ \[$(tput sgr0)\]"
fi

export BASH_SILENCE_DEPRECATION_WARNING
export CLICOLOR
export GOPATH
export LSCOLORS
export PATH
export PIPENV_VENV_IN_PROJECT
export PYTHONPATH

alias ibrew="arch -x86_64 /usr/local/bin/brew"
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias h='helm'
alias ip='ip -color=auto'
alias k='kubectl'
alias ls='ls --color'
alias vi='$(command -v vim)'
