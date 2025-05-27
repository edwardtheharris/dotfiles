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
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

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

This repository has three main plays, explained below.

1. Local user, as in your Linux username. The values in `site.yml`
   represent my personal settings, all variables are required.

   ```sh
   ansible-playbook -t user site.yml
   ```

   The default configuration will run this on `localhost`.

2. A service account, as in the account you would use to run
   [bind](https://bind9.readthedocs.io/en/latest/).

   ```sh
   ansible-playbook -t sa site.yml
   ```

   The default configuration assumes a group named `ns` in your
   Ansible inventory.

3. The root account, you shouldn't be using this account but
   if you're always tinkering with stuff like the author does,
   then you'll want to have reasonable settings for the shell at least.

   ```sh
   ansible-playbook -t root site.yml
   ```

## Additional services

[Samba Active Directory](ansible/files/ad/index.md), because AD should be
run on Linux because MS has enough money.

## tools

vim Plugins use [junegunn/vim-plug](https://github.com/junegunn/vim-plug).

Sphinx extensions used by the documentation include the following.

1. [myst-parser](https://myst-parser.readthedocs.io/en/latest/)
2. [sphinxcontrib-autoyaml](https://pypi.org/project/sphinxcontrib-autoyaml/)
3. [sphinx-copybutton](https://sphinx-copybutton.readthedocs.io/en/latest/index.html)
4. [sphinx-last-updated-by-git](https://pypi.org/project/sphinx-last-updated-by-git/)

### pre-commit hooks

1. [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)
2. [black](https://black.readthedocs.io/en/stable/integrations/source_version_control.html)
