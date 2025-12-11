#!/bin/bash

CLICOLOR=1
# shellcheck disable=SC2016
LESS='-R --use-color -Dd+r$Du+b$'
LSCOLORS="Ea"
if [ "${HOME}" != "/home" ]; then
	. ".ps1-sa"
elif [ "${HOME}" == "/root" ]; then
	. ".ps1-root"
elif [ "${HOME}" == "/var|/srv" ]; then
	. ".ps1-ns"
else
	. ".ps1-user"
fi
PATH="${PATH}:${HOME}/.local/bin"

# shellcheck disable=SC1091
if [ -f /usr/share/bash-completion/bash_completion ]; then
	source /usr/share/bash-completion/bash_completion
fi

export CLICOLOR
export LESS
export LSCOLORS
export PS1
export PATH

on_arch="$(uname -r | grep arch)"

if [ "$on_arch" != "" ]; then
	. ".arch"
fi

if [ ! -f "${HOME}/.local/bin/direnv" ]; then
	bin_path="${HOME}/.local/bin"
	mkdir -pv "${bin_path}"
	curl -sfL https://direnv.net/install.sh | bash
	eval "$(direnv hook bash)"
fi

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias h='h --debug'
alias ip='ip -color=auto'
alias k='kubectl'
alias ls='ls --color'
alias tf='terraform'
alias tfd='terraform-docs'
alias tg='terragrunt'
