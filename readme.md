---
abstract: >
  The dotfiles of excellent graphic designer and noted sesquipedalian,
  @edwardtheharris. Contains system-appropriate configs for bash, vim,
  and wakatime.
authors: Xander Harris
date: 2024-01-27
title: dotfiles readme
---

## [<3 bash](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html)

- [BASH Prompt Generator](https://bash-prompt-generator.org/)

Best Amazing SHell is the best.

### Supported Distributions

- [Alpine](https://www.alpinelinux.org/)
- [ArchLinux](https://archlinux.org)
- [Linux Mint](https://www.linuxmint.com/)
- [MacOS](https://support.apple.com/en-us/102662)
- [Ubuntu](https://ubuntu.com/)

Though mainly work is done on [ArchLinux](https://archlinux.org) because
apt is a bummer.

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

## tools

Apparently, [neovim](https://github.com/neovim/neovim) has completely
eliminated the need for anything as silly as VSCode or some other
abominable thing like emacs.

Sphinx extensions used by the documentation include the following.

1. [myst-parser](https://myst-parser.readthedocs.io/en/latest/)
2. [sphinxcontrib-autoyaml](https://pypi.org/project/sphinxcontrib-autoyaml/)
3. [sphinx-copybutton](https://sphinx-copybutton.readthedocs.io/en/latest/index.html)
4. [sphinx-last-updated-by-git](https://pypi.org/project/sphinx-last-updated-by-git/)

### pre-commit hooks

1. [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)
2. [black](https://black.readthedocs.io/en/stable/integrations/source_version_control.html)
