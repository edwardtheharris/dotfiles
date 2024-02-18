#!/usr/local/bin/bash

BASH_SILENCE_DEPRECATION_WARNING=1
CLICOLOR=1
GOPATH=/opt/go
HOMEBREW_CELLAR=/usr/local/Cellar
HOMEBREW_PREFIX=/usr/local
LSCOLORS="Ea"
PATH=$PATH:/usr/local/sbin:/Users/duchess/Library/Python/3.9/bin
PS1="[\[$(tput sgr0)\]\[\033[38;5;39m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;147m\]\H\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;255m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]{\$?}\\$ \[$(tput sgr0)\]"
PYTHONPATH=/Volumes/corey/src/github.com/edwardtheharris/money/money/ingest:/Volumes/corey/src/github.com/edwardtheharris/money/money:/Volumes/corey/src/github.com/edwardtheharris/money:/Volumes/corey/src/github.com/edwardtheharris/money/money/notebooks

# shellcheck disable=SC1091
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

if [ -f /usr/local/share/google-cloud-sdk/completion.bash.inc ]; then
  # shellcheck disable=SC1091
  source /usr/local/share/google-cloud-sdk/completion.bash.inc
fi

if [ -f "${HOME}/.gnupg/wakatime-api-key.gpg" ]; then
  WAKATIME_API_KEY="$(gpg -d -q "${HOME}"/.gnupg/wakatime-api-key.gpg)"
  export WAKATIME_API_KEY
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

if [ -f /usr/local/bin/terraform ]; then
  complete -C /usr/local/bin/terraform terraform
  alias tf='terraform'
  complete -C /usr/local/bin/terraform tf
fi

if [ -f /usr/local/bin/direnv ]; then
  eval "$(direnv hook bash)"
fi

export BASH_SILENCE_DEPRECATION_WARNING
export CLICOLOR
export GOPATH
export HOMEBREW_CELLAR
export HOMEBREW_PREFIX
export LSCOLORS
export PATH
export PYTHONPATH

alias 'gp'='git push'
alias 'k'=kubectl
alias 'h'=helm
alias ip='ip -color=auto'
