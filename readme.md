---
abstract: >
    The dotfiles of excellent graphic designer and noted sesquipedalian,
    @edwardtheharris. Contains system-appropriate configs for bash, vim,
    and wakatime.
authors: Xander Harris
date: 2024-01-27
title: dotfiles readme
---

[![GitHub Pages Deployment](https://img.shields.io/github/actions/workflow/status/edwardtheharris/dotfiles/pages.yml?branch=main&style=flat&logo=github&label=GitHub%20Pages)](https://edwardtheharris.github.io/dotfiles/)
&nbsp; [![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/edwardtheharris/dotfiles/shell.yml?branch=main&style=flat&logo=githubactions&logoColor=white&label=ShellCheck)](https://github.com/edwardtheharris/dotfiles/actions/workflows/shell.yml)
[![wakatime](https://wakatime.com/badge/github/edwardtheharris/dotfiles.svg)](https://wakatime.com/badge/github/edwardtheharris/dotfiles)
[![Coverage Status](https://coveralls.io/repos/github/edwardtheharris/dotfiles/badge.svg)](https://coveralls.io/github/edwardtheharris/dotfiles)

## [<3 bash](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html)

- [BASH Prompt Generator](https://bash-prompt-generator.org/)

Best Amazing SHell is the best.

### Supported Distributions

- [Alpine](https://www.alpinelinux.org/)
- [ArchLinux](https://archlinux.org)
- [Linux Mint](https://www.linuxmint.com/)
- [MacOS](https://support.apple.com/en-us/102662)
- [Ubuntu](https://ubuntu.com/)

## GitHub Actions

You can delete unwanted workflow runs with this script.

```sh
for run in $(gh run list --json databaseId --jq '.[].databaseId'); do
    gh run delete $run;
done
```

## Usage

This is too complicated to explain at the moment.

## Additional services

[Samba Active Directory](ansible/files/ad/index.md), because AD should be
run on Linux.

## Tools

Vim Plugins use [junegunn/vim-plug](https://github.com/junegunn/vim-plug).

Sphinx extensions used by the documentation include the following.

1. [myst-parser](https://myst-parser.readthedocs.io/en/latest/)
2. [sphinxcontrib-autoyaml](https://pypi.org/project/sphinxcontrib-autoyaml/)
3. [sphinx-copybutton](https://sphinx-copybutton.readthedocs.io/en/latest/index.html)
4. [sphinx-last-updated-by-git](https://pypi.org/project/sphinx-last-updated-by-git/)
