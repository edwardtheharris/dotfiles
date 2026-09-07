---
abstract: >
   Xander's Dot files and Sundry Store documentation master file, created by
   sphinx-quickstart on Sat Jan 20 10:30:38 2024.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.
authors: Xander Harris
date: 2024-01-21
title: >
    Xander's Dot Files and Sundry Store
---

## Dot files for the masses

Or just the one guy, you know, whatever.

### Minutiae

```{toctree}
:caption: meta

.github/index
changelog
license
roles/index
readme
```

## Indices and tables

* {ref}`genindex`
* {ref}`modindex`
* {ref}`search`

## Readme

```{include} readme.md
:start-line: 10
```

## Glossary

```{glossary}
AD
  [AD](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview)
  Short for Active Directory, which is a collection of network services
  that are intended to provide an enhanced LDAP service.

Ansible
  [Ansible](https://ansible.com) is an open source IT automation engine that automates provisioning,
  configuration management, application deployment, orchestration, and many
  other IT processes.

ArchLinux
  [ArchLinux](https://archlinux.org) is a lightweight and flexible Linux® distribution that tries to
  Keep It Simple.

crowdsec
  [crowdsec](https://www.crowdsec.net/) A free, OSS firewall that takes advantage of the wisdom of crowds.

dotfiles
  [dotfiles](https://wiki.archlinux.org/title/Dotfiles) A collection of configuration files for a luser's shell environment.

DC
  [DC](https://en.wikipedia.org/wiki/Domain_controller) short for Domain Controller,
  this is a system that manages domain
  services for a computer network.

etcd
  [etcd](https://etcd.io/docs/v3.5/) is a key value store that is used by Kubernetes Control Planes

GPG
  [GnuPG](https://gnupg.org) is a complete and free implementation of
  the OpenPGP standard as
  defined by RFC4880 (also known as PGP).

netctl
  [netctl](https://wiki.archlinux.org/title/Netctl) is a program that allows
  the configuration of multiple
  network interfaces on a single system.

  For more information on setting up profiles, see
  [netctl.profile(5)](https://man.archlinux.org/man/netctl.profile.5)

router
  [Router](https://wiki.archlinux.org/title/Router) is network
  infrastructure that sends network packets to the
    appropriate destination.

Sphinx
  [Sphinx](https://sphinx-doc.org) is a static site generator
  that is used to generate the documentation
    for this repository.

sysctl
  [sysctl](https://wiki.archlinux.org/title/Sysctl#Configuration) is a
  utility that can be used to configure Linux system
  options.

  See this [documentation](http://0pointer.de/blog/projects/the-new-configuration-files)
  for more information about how to configure `sysctl`.

  You can also read the related man page,
  [sysctl.d.5](https://man.archlinux.org/man/sysctl.d.5).

systemd
  [systemd](https://www.mankier.com/1/systemd) is a set of programs
  that manage the boot process and system
  services for Linux after the kernel has been loaded. It is usually
  run as PID 1.

ufw
  [ufw](https://help.ubuntu.com/community/UFW) is short
  for Un-complicated FireWall, which is an Ubuntu project designed to make managing
  Linux firewalls less of a disaster area.
```

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>
```
