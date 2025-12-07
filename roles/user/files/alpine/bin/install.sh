#!/usr/bin/env bash

dotfiles_targetpath="${DOTFILES_TARGETPATH:-$HOME/.dotfiles/alpine}"

#
# Configure wakatime
#
wakatime_api_key=${WAKATIME_API_KEY:-none}
sed -i "s/wakatime_api_key/${wakatime_api_key}/g" "${dotfiles_targetpath}"/.wakatime.cfg

#
# Install files
#
cp -v "${dotfiles_targetpath}"/.bash_profile "${HOME}"/.bash_profile
cp -v "${dotfiles_targetpath}"/.bashrc "${HOME}"/.bashrc
cp -v "${dotfiles_targetpath}"/.vimrc "${HOME}"/.vimrc
cp -v "${dotfiles_targetpath}"/.wakatime.cfg "${HOME}"/.wakatime.cfg

#
# Install Vundle
#
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
