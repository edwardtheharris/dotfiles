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

{.glossary}
[AD](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview)
: Short for Active Directory, which is a collection of network services
  that are intended to provide an enhanced LDAP service.

[crowdsec](https://www.crowdsec.net/)
: A free, OSS firewall that takes advantage of the wisdom of crowds.

dotfiles
: A collection of configuration files for a luser's shell environment.

[DC](https://en.wikipedia.org/wiki/Domain_controller)
: Short for Domain Controller, this is a system that manages domain
  services for a computer network.

[etcd](https://etcd.io/docs/v3.5/)
: This is a key value store that is used by Kubernetes Control Planes

[netctl](https://wiki.archlinux.org/title/Netctl)
: This is a program that allows the configuration of multiple
  network interfaces on a single system.

: For more information on setting up profiles, see
  [netctl.profile(5)](https://man.archlinux.org/man/netctl.profile.5)

[Router](https://wiki.archlinux.org/title/Router)
: A piece of network infrastructure that sends network packets to the
    appropriate destination.

[Sphinx](https://sphinx-doc.org)
: Sphinx is a static site generator that is used to generate the documentation
    for this repository.

[sysctl](https://wiki.archlinux.org/title/Sysctl#Configuration)
: This is a utility that can be used to configure Linux system
  options.

: See this [documentation](http://0pointer.de/blog/projects/the-new-configuration-files)
  for more information about how to configure `sysctl`.

: You can also read the related man page,
  [sysctl.d.5](https://man.archlinux.org/man/sysctl.d.5).

[systemd](https://www.mankier.com/1/systemd)
: This is a set of programs that manage the boot process and system
  services for Linux after the kernel has been loaded. It is usually
  run as PID 1.

[ufw](https://help.ubuntu.com/community/UFW)
: Un-Complicated Firewall, which is an Ubuntu project designed to make managing
  Linux firewalls less of a disaster area.
